/*
 * File:    rtc.c
 * Author:  Interark Corp.
 * Summary: Real Time Clock(RX8035) driver implementation file.
 * Date:    2022/08/13 (R0)
 * Note:    Refer to Application manual of RX-8035SA/LC [ETM35J-09(Epson)]
 */


// Build configuration
#define DEBUG_UART
#define RTC_DEBUG               // Debug RTC initialize function
//#define RTC_DETAIL_TEST         // check ram write/read, if defined

#include <string.h>
#include <time.h>
#include "debug.h"
#include "util.h"
#include "rtc.h"

/*
 *  Register number
 */
// BANK #0 (#1 unused)
#define RTC_REGISTER_SEC            0x00
#define RTC_REGISTER_MIN            0x01
#define RTC_REGISTER_HOUR           0x02
#define RTC_REGISTER_WEEK           0x03    // not used,don't care
#define RTC_REGISTER_DAY            0x04
#define RTC_REGISTER_MONTH          0x05
#define RTC_REGISTER_YEAR           0x06
#define RTC_REGISTER_DIGITAL_OFFSET 0x07    // not used,don't care
#define RTC_REGISTER_ALARMWK_MIN    0x08    // on Alarm_Week
#define RTC_REGISTER_ALARMWK_HOUR   0x09    // on Alarm_Week
#define RTC_REGISTER_ALARMWK_WEEK   0x0a    // on Alarm_Week
#define RTC_REGISTER_ALARMWK_DAY    0x0a    // on Alarm_Week
#define RTC_REGISTER_ALARMMO_MINUTE 0x0b    // on Alarm Month
#define RTC_REGISTER_ALARMMO_HOUR   0x0c    // on Alarm Month
#define RTC_REGISTER_RAM            0x0d    // NVRAM
#define RTC_REGISTER_CONTROL1       0x0e    //
#define RTC_REGISTER_CONTROL2       0x0f    //
  // Bit flags
#define REGISTER_CONTROL1_MOALE     0x40
#define REGISTER_CONTROL1_WKALE     0x80
#define REGISTER_CONTROL1_TEST      0x08
#define REGISTER_CONTROL1_CT_MSK    0x07
#define REGISTER_CONTROL1_BANK_MSK  0x80
#define REGISTER_CONTROL2_VDET      0x40
#define REGISTER_CONTROL2_XSTP      0x20
#define REGISTER_CONTROL2_POR       0x10
#define REGISTER_CONTROL2_CTFG      0x04
#define REGISTER_CONTROL2_WKAFG     0x02
#define REGISTER_CONTROL2_MOAFG     0x01
#define REGISTER_HOUR_24HOUR        0x80

// Leap year calulator expects year argument as years offset from 1970
#define	LEAP_YEAR(Y)                (!((1970+Y) % 4) && (((1970+Y) % 100) || !((1970+Y) % 400)))
#define	SECS_PER_MIN                (60UL)
#define	SECS_PER_HOUR               (3600UL)
#define	SECS_PER_DAY                (SECS_PER_HOUR * 24UL)
#define SECS_JST_TIME_DIFF          (9 * SECS_PER_HOUR)

// BCD <-> Binary conversion
#define TO_BCD(x)                   (uint8_t)(((x) / 10) * 16 + ((x) % 10))
#define TO_BIN(x)                   (uint8_t)(((x) / 16) * 10 + ((x) % 16))

/*
*   global variables
*/
volatile uint32_t RTC_now = 0;          // Current epoch time [Sec]

/*
*   static variables and functions
*/
static EIC_PIN      _RTC_interruptPinA, _RTC_interruptPinB;     // Pin # of nINTRA(Alarm_Mo) and nINTRB(Time update and Alarm_Wk)
static RTC_HANDLER  _RTC_handlerForTimeupdate = NULL;
static RTC_HANDLER  _RTC_handlerForAlarm = NULL;
static RTC_DATETIME _RTC_defaultDateTime = { 22, 1, 1, 0, 0, 0 };    // Date and time to set when initial settings are required(2022/01/01 00:00:00)
static uint32_t     _RTC_updateUnit = 0;                // Time step with time update interrupt [Sec]

static int _RTC_calculateNextHourAndMinute(uint32_t t, uint32_t minutesLater, uint8_t values[]);
static void _RTC_handlerA(uintptr_t);
static void _RTC_handlerB(uintptr_t);
static int _RTC_readRegister(uint8_t register, uint8_t *value_p);
static int _RTC_readRegisters(uint8_t register, uint8_t value_p[], int nbytes);
static int _RTC_writeRegister(uint8_t register, uint8_t value);
static int _RTC_writeRegisters(uint8_t register, uint8_t values[], int nbytes);

int RTC_initialize(EIC_PIN interruptPinA, EIC_PIN interruptPinB)
{
    _RTC_interruptPinA = interruptPinA;
    _RTC_interruptPinB = interruptPinB;
    EIC_CallbackRegister(_RTC_interruptPinA, (EIC_CALLBACK)_RTC_handlerA, (uintptr_t)NULL);
    EIC_CallbackRegister(_RTC_interruptPinB, (EIC_CALLBACK)_RTC_handlerB, (uintptr_t)NULL);
    EIC_InterruptEnable(_RTC_interruptPinA);
    EIC_InterruptEnable(_RTC_interruptPinB);

    // Initialize SX8900SA
    uint8_t flag;
    if (_RTC_readRegister(RTC_REGISTER_CONTROL2, &flag) == RTC_ERR_NONE)
    {
        DEBUG_UART_printlnFormat("RTC_initialize() flag: %02X", flag);
        if ((flag & REGISTER_CONTROL2_POR) || (flag & REGISTER_CONTROL2_XSTP))
        {
            DEBUG_UART_printlnFormat("RTC_initialize() init&set");
            _RTC_writeRegister(RTC_REGISTER_CONTROL1, 0);   // all:0
            _RTC_writeRegister(RTC_REGISTER_CONTROL2, 0);   // all:0
            RTC_setDateTime(_RTC_defaultDateTime);          // set default date and time

            return (RTC_ERR_INITIALIZED);
        }
        else
        {
            DEBUG_UART_printlnFormat("RTC_initialize() init");
            _RTC_writeRegister(RTC_REGISTER_CONTROL1, 0);   // all:0
            _RTC_writeRegister(RTC_REGISTER_CONTROL2, 0);   // all:0
            RTC_now = RTC_getEpoch();
#ifdef RTC_DEBUG
            RTC_DATETIME dt;
            RTC_getDatetime(&dt);
            DEBUG_UART_printlnFormat(">>20%02d/%02d/%02d %02d:%02d:%02d --", dt.year, dt.month, dt.day, dt.hour, dt.minute, dt.second);
            DEBUG_UART_printlnFormat(">>RTC_now=%lu", RTC_now);
            //RTC_setDateTime(_RTC_defaultDateTime);          // set default date and time
#endif // RTC_DEBUG
        }
    }
    else
    {
        return (RTC_ERR_INTERNAL);
    }

#ifdef RTC_DETAIL_TEST
    // CHECK READ/WRITE RTC REGISTER
    uint8_t writeValue = 0x55, readValue = 0;
    _RTC_writeRegister(RTC_REGISTER_RAM, writeValue);
    _RTC_readRegister(RTC_REGISTER_RAM, &readValue);
    if (writeValue != readValue)
    {
        return (RTC_ERR_INTERNAL);
    }
#endif // RTC_DETAIL_TEST

    return (RTC_ERR_NONE);
}

int RTC_setDateTime(RTC_DATETIME dt)
{
    int stat = RTC_ERR_NONE;
    uint8_t data[7];

    data[0] = TO_BCD(dt.second);
    data[1] = TO_BCD(dt.minute);
    data[2] = TO_BCD(dt.hour) | REGISTER_HOUR_24HOUR;
    data[3] = 0;            // day of week is not used
    data[4] = TO_BCD(dt.day);
    data[5] = TO_BCD(dt.month);
    data[6] = TO_BCD(dt.year);

    if (_RTC_writeRegisters(RTC_REGISTER_SEC, data, (uint32_t)sizeof(data)) == RTC_ERR_NONE)
    {
        // clear VDET
        uint8_t value = 0;
        if (_RTC_readRegister(RTC_REGISTER_CONTROL2, &value) == RTC_ERR_NONE)
        {
            value &= ~REGISTER_CONTROL2_VDET;   // clear VDET bit
            if (_RTC_writeRegister(RTC_REGISTER_CONTROL2, value) != RTC_ERR_NONE)
            {
                stat = RTC_ERR_WRITE;
            }
        }
        else
        {
            stat = RTC_ERR_READ;
        }
    }
    else
    {
        stat = RTC_ERR_WRITE;
    }

    // update RTC_now
    if (stat == RTC_ERR_NONE)
    {
        RTC_now = RTC_getEpoch();
    }

    return (stat);
}

int RTC_getDatetime(RTC_DATETIME *dt_p)
{
    int stat = RTC_ERR_NONE;
    uint8_t data[7];

    if (_RTC_readRegisters(RTC_REGISTER_SEC, data, sizeof(data)) == RTC_ERR_NONE)
    {
        dt_p->second = TO_BIN(data[0]);
        dt_p->minute = TO_BIN(data[1]);
        dt_p->hour = TO_BIN(data[2] & ~REGISTER_HOUR_24HOUR);   // clear 12h/24h bit
        dt_p->day = TO_BIN(data[4]);
        dt_p->month = TO_BIN(data[5]);
        dt_p->year = TO_BIN(data[6]);
    }
    else
    {
        stat = RTC_ERR_READ;
    }

    return (stat);
}

uint32_t RTC_getEpoch(void)
{
    static  const uint8_t monthDays[] = { 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 };

    RTC_DATETIME dt;
    if (RTC_getDatetime(&dt) != RTC_ERR_NONE)
    {
        return (0);     // return zero if can't get date and time
    }

    // convert to epoch time - Seconds from 1970 till 1 jan 00:00:00 of the given year
    uint16_t year = (2000 + dt.year) - 1970;
    uint32_t t = year * (SECS_PER_DAY * 365);      // total seconds from 1970/01/01 00:00:00
    for (int y = 0; y < year; y++)
    {
        if (LEAP_YEAR(y))
            t += SECS_PER_DAY;      // add extra days for leap years
    }

    // Add days for this year, months start from 1
    for (int m = 1; m < dt.month; m++)
    {
        if ((m == 2) && LEAP_YEAR(year))
            t += SECS_PER_DAY * (monthDays[m-1] + 1);
        else
            t += SECS_PER_DAY * monthDays[m-1];     //monthDay array starts from 0
    }
    t += (dt.day - 1) * SECS_PER_DAY;
    t += dt.hour * SECS_PER_HOUR;
    t += dt.minute * SECS_PER_MIN;
    t += dt.second;
    t -= SECS_JST_TIME_DIFF;

    return (t);     // return epoch time[sec]
}

int RTC_setTimeUpdateInterrupt(RTC_TIMEUPDATE_TYPE type, RTC_HANDLER handler)
{
    if (handler == NULL)
    {
        // disable time update interrupt
        uint8_t value = 0;
        if (_RTC_readRegister(RTC_REGISTER_CONTROL1, &value) == RTC_ERR_NONE)
        {
            value &= ~REGISTER_CONTROL1_CT_MSK;
            if (_RTC_writeRegister(RTC_REGISTER_CONTROL1, value) != RTC_ERR_NONE)
            {
                return (RTC_ERR_WRITE);
            }
            _RTC_handlerForTimeupdate = NULL;
        }
        else
        {
            return (RTC_ERR_READ);
        }
    }
    else
    {
        _RTC_handlerForTimeupdate = handler;

        // (1) set which timing and enable interrupt
        uint8_t value = 0;
        if (_RTC_readRegister(RTC_REGISTER_CONTROL1, &value) == RTC_ERR_NONE)
        {
            value &= ~REGISTER_CONTROL1_CT_MSK;
            switch (type)
            {
                case RTC_TIMEUPDATE_SECOND:
                    value |= 0x04;      // level mode and 1 sec update
                    _RTC_updateUnit = 1;
                    break;
                case RTC_TIMEUPDATE_MINUTE:
                    value |= 0x05;      // level mode and 1 min update
                    _RTC_updateUnit = 60;
                    break;
                default:
                    return (RTC_ERR_PARAM);
            }

            UTIL_delayMicros(100);

            if (_RTC_writeRegister(RTC_REGISTER_CONTROL1, value) != RTC_ERR_NONE)
            {
                _RTC_handlerForTimeupdate = NULL;   // undo set handler
                return (RTC_ERR_WRITE);
            }
        }
        else
        {
            return (RTC_ERR_READ);
        }
    }

    return (RTC_ERR_NONE);
}

int RTC_setAlarm(uint32_t minutesLater, RTC_HANDLER handler)
{
    if (handler == NULL)
    {
        // disable alarm interrupt
        uint8_t value = 0;
        if (_RTC_readRegister(RTC_REGISTER_CONTROL2, &value) == RTC_ERR_NONE)
        {
            value &= ~ REGISTER_CONTROL2_WKAFG;
            if (_RTC_writeRegister(RTC_REGISTER_CONTROL2, value) != RTC_ERR_NONE)
            {
                return (RTC_ERR_WRITE);
            }
            _RTC_handlerForAlarm = NULL;
        }
        else
        {
            return (RTC_ERR_READ);
        }
    }
    else
    {
        // enable alarm interrupt
        // (1) set which timing
        uint8_t values[3];      // [0] minute, [1] hour, [2] week day
        uint32_t t = RTC_getEpoch();
        if (_RTC_calculateNextHourAndMinute(t, minutesLater, values) != RTC_ERR_NONE)
        {
            return (RTC_ERR_INTERNAL);
        }
        values[0] = TO_BCD(values[0]);
        values[1] = TO_BCD(values[1]);
        values[2] = 0xff;       // enable all week day
        if (_RTC_writeRegisters(RTC_REGISTER_ALARMWK_MIN, values, 3) != RTC_ERR_NONE)
        {
            return (RTC_ERR_WRITE);
        }

        // (2) enable alarm interrupt
        uint8_t value = 0;
        if (_RTC_readRegister(RTC_REGISTER_CONTROL1, &value) == RTC_ERR_NONE)
        {
            _RTC_handlerForAlarm = handler;
            value &= ~REGISTER_CONTROL1_MOALE;     // clear MoALE bit
            value |= REGISTER_CONTROL1_WKALE;      // set WkALE bit
            if (_RTC_writeRegister(RTC_REGISTER_CONTROL1, value) != RTC_ERR_NONE)
            {
                _RTC_handlerForAlarm = NULL;   // undo set handler
                return (RTC_ERR_WRITE);
            }
        }
        else
        {
            return (RTC_ERR_READ);
        }
    }

    return (RTC_ERR_NONE);
}

int RTC_writeNVRAM(uint8_t data)
{
    if (_RTC_writeRegister(RTC_REGISTER_RAM, data) != RTC_ERR_NONE)
    {
        return (RTC_ERR_WRITE);
    }

    return (RTC_ERR_NONE);
}

int RTC_readNVRAM(uint8_t *data_p)
{
    if (_RTC_readRegister(RTC_REGISTER_RAM, data_p) != RTC_ERR_NONE)
    {
        return (RTC_ERR_READ);
    }

    return (RTC_ERR_NONE);
}


int RTC_convertToDateTime(uint32_t epochTime, RTC_DATETIME *dt_p)
{
    epochTime += SECS_JST_TIME_DIFF;
    struct tm *tmp = localtime(&epochTime);
    dt_p->second = tmp->tm_sec;
    dt_p->minute = tmp->tm_min;
    dt_p->hour = tmp->tm_hour;
    dt_p->month = tmp->tm_mon + 1;
    dt_p->day = tmp->tm_mday;;
    dt_p->year = ((int)tmp->tm_year + 1900) % 100;

    return (RTC_ERR_NONE);
}



/*
 *  local functions
 */

static int _RTC_calculateNextHourAndMinute(uint32_t t, uint32_t minutesLater, uint8_t values[])
{
    DEBUG_UART_printlnFormat("> _RTC_calculateNextHourAndMinute(%u,%u,-)", (unsigned int)t, (unsigned int)minutesLater);
    t = (t + (minutesLater * 60) + SECS_JST_TIME_DIFF) % (60 * 60 * 24);
    uint32_t m = t / 60;
    DEBUG_UART_printlnFormat("+ t=%u, m=%u", (unsigned int)t, (unsigned int)m);
    values[0] = m % 60;     // set minute
    values[1] = m / 60;     // set hour
    DEBUG_UART_printlnFormat("< ALARM minute=%u, hour=%u", (unsigned int)values[0], (unsigned int)values[1]);

    return (RTC_ERR_NONE);
}

/*
*   _RTC_handlerA() - handle interrupt by event-detect or Alarm_Mo
*/
static void _RTC_handlerA(uintptr_t ptr)
{
    uint8_t value = 0;

    if (_RTC_readRegister(RTC_REGISTER_CONTROL2, &value) == RTC_ERR_NONE)
    {
        if (value & REGISTER_CONTROL2_MOAFG)
        {
            // if MoAFG is set, clear MoAFG and call user handler
            value &= ~REGISTER_CONTROL2_MOAFG;      // clear MoAFG
            UTIL_delayMicros(100);
            _RTC_writeRegister(RTC_REGISTER_CONTROL2, value);
            if (_RTC_handlerForAlarm != NULL)
            {
                _RTC_handlerForAlarm();
            }
        }

        // ignore event-detect interrupt
    }
}

/*
*   _RTC_handlerA() - handle interrupt by time-update or Alarm_Wk
*/
static void _RTC_handlerB(uintptr_t ptr)
{
    uint8_t value = 0;

    if (_RTC_readRegister(RTC_REGISTER_CONTROL2, &value) == RTC_ERR_NONE)
    {
        if (value & REGISTER_CONTROL2_CTFG)
        {
            // if CTFG is set, clear CTFG and call user handler
            value &= ~REGISTER_CONTROL2_CTFG;       // cleat CTFG
            UTIL_delayMicros(100);
            _RTC_writeRegister(RTC_REGISTER_CONTROL2, value);
            if (_RTC_handlerForTimeupdate != NULL)
            {
                RTC_now += _RTC_updateUnit;
                _RTC_handlerForTimeupdate();
            }
        }

        if (value & REGISTER_CONTROL2_WKAFG)
        {
            // if WkAFG is set, clear WkAFG and call user handler
            value &= ~REGISTER_CONTROL2_WKAFG;      // clear WkAFG
            UTIL_delayMicros(100);
            _RTC_writeRegister(RTC_REGISTER_CONTROL2, value);
            if (_RTC_handlerForAlarm != NULL)
            {
                _RTC_handlerForAlarm();
            }
        }
    }
}

static int _RTC_readRegister(uint8_t register_, uint8_t *value_p)
{
    int stat = RTC_ERR_NONE;
    register_ = (register_ << 4) + 0x00;
    uint8_t value = 0;
    if (SERCOM3_I2C_WriteRead(RTC_I2C_ADDRESS, &register_, 1, &value, 1))
    {
        while (SERCOM3_I2C_IsBusy())
            ;
        *value_p = value;
    }
    else {
        stat = RTC_ERR_READ;
    }

    return (stat);
}

static int _RTC_readRegisters(uint8_t register_, uint8_t values[], int nbytes)
{
    int stat = RTC_ERR_NONE;
    register_ = (register_ << 4) + 0x00;
    if (SERCOM3_I2C_WriteRead(RTC_I2C_ADDRESS, &register_, 1, values, nbytes))
    {
        while (SERCOM3_I2C_IsBusy())
            ;
    }
    else {
        stat = RTC_ERR_READ;
    }

    return (stat);
}

static int _RTC_writeRegister(uint8_t register_, uint8_t value)
{
    int stat = RTC_ERR_NONE;
    uint8_t txData[2];

    txData[0] = (register_ << 4) + 0x00;
    txData[1] = value;
    if (SERCOM3_I2C_Write(RTC_I2C_ADDRESS, txData, 2))
    {
        while (SERCOM3_I2C_IsBusy())
            ;
    }
    else {
        stat = RTC_ERR_WRITE;
    }

    return (stat);
}

static int _RTC_writeRegisters(uint8_t register_, uint8_t values[], int nbytes)
{
    int stat = RTC_ERR_NONE;
    uint8_t txData[16+1];

    if (nbytes > 16)
    {
        return (RTC_ERR_PARAM);
    }

    txData[0] = (register_ << 4) + 0x00;    // use write mode
    for (int i = 0; i < nbytes; i++)
    {
        txData[i+1] = values[i];
    }
    if (SERCOM3_I2C_Write(RTC_I2C_ADDRESS, txData, nbytes + 1))
    {
        while (SERCOM3_I2C_IsBusy())
            ;
    }
    else {
        stat = RTC_ERR_WRITE;
    }

    return (stat);
}
