/*
 * File:    s5851a.c
 * Author:  Interark Corp.
 * Summary: Digital Temperature Sensor (S5851A) driver implementation file.
 * Date:    2022/07/17 (R0)
 * Note:    Refer to S5851A datasheet(Rev.2.2_01)
 */

//#define DEBUG_USB

#include <stdio.h>
#include "app.h"
#include "util.h"
#include "debug.h"
#include "s5851a.h"

/*
*   Symbols
*/
#define ONE_SHOT_TIMEOUT        500         // Maximum temperature update time [mS]
#define I2C_OPERATION_TIMEOUT   20          //

/*
*   Local variables and functions
*/
static S5851A_MODE _S5851A_mode = S5851A_MODE_CONTINOUS;    // Current mode
static bool _S5851A_is_measuring = false;   // Whether or not the measurement is in progress

static bool _S5851A_waitForCompleted(uint32_t timeout);


int S5851A_setMode(S5851A_MODE mode)
{
    uint8_t buf[2];
    buf[0] = 0x01;     // use configuration register
    buf[1] = mode;
    if (SERCOM3_I2C_Write(S5851A_I2C_ADDRESS, buf, 2))
    {
        if (! _S5851A_waitForCompleted(I2C_OPERATION_TIMEOUT))
        {
            return (S5851A_ERR_WRITE);
        }
        UTIL_delayMicros(30);

        buf[0] = 0xff;
        if (SERCOM3_I2C_Read(S5851A_I2C_ADDRESS, buf, 1))
        {
            if (! _S5851A_waitForCompleted(I2C_OPERATION_TIMEOUT))
            {
                return (S5851A_ERR_READ);
            }
            UTIL_delayMicros(10);
            _S5851A_mode = mode;
        }
        else
        {
            return (S5851A_ERR_READ);
        }
    }
    else
    {
        return (S5851A_ERR_WRITE);
    }

    return (S5851A_ERR_NONE);
}

int S5851A_getTemperature(float *temp_p)
{
    uint8_t buf[2];
    if (_S5851A_mode & S5851A_MODE_SHUTDOWN)
    {
        // if shutdown mode then measurement by one shut
        if (! _S5851A_is_measuring)
        {
            S5851A_startMeasurement();
        }
        // Wait until measurement is complete
        uint32_t start = SYS_mSec;
        bool timeouted = false;
        buf[0] = 0xff;
        while (SERCOM3_I2C_Read(S5851A_I2C_ADDRESS, buf, 1)) {
            if (! _S5851A_waitForCompleted(I2C_OPERATION_TIMEOUT))
            {
                return (S5851A_ERR_READ);
            }
            UTIL_delayMicros(30);
            if (! (buf[0] & S5851A_MODE_ONESHUT))
            {
                break;      // Measurement completed
            }
            if (SYS_mSec - start > ONE_SHOT_TIMEOUT)
            {
                timeouted = true;
                break;      // Timed out, can't measure temperature
            }

            APP_delay(20);  //@

        }
        _S5851A_is_measuring = false;
        if (timeouted)
        {
            return (S5851A_ERR_TIMEOUT);        // timeout error
        }
    }

    // read updated temperature
    buf[0] = 0x00;      // use temperature register
    if (SERCOM3_I2C_Write(S5851A_I2C_ADDRESS, buf, 1))
    {
        if (! _S5851A_waitForCompleted(I2C_OPERATION_TIMEOUT))
        {
            return (S5851A_ERR_WRITE);
        }
        UTIL_delayMicros(30);
    }
    else
    {
        return (S5851A_ERR_WRITE);
    }
    if (SERCOM3_I2C_Read(S5851A_I2C_ADDRESS, buf, 2))
    {
        if (! _S5851A_waitForCompleted(I2C_OPERATION_TIMEOUT))
        {
            return (S5851A_ERR_READ);
        }
        UTIL_delayMicros(10);
        int16_t tt = (buf[0] << 4) | (buf[1] >> 4);
        if (buf[0] & 0x80)
        {
            tt |= 0xf000;       // negative value
        }
        *temp_p = (float)tt * 0.0625;
    }
    else
    {
        return (S5851A_ERR_READ);
    }

    return (S5851A_ERR_NONE);
}

int S5851A_startMeasurement(void)
{
    if (_S5851A_mode & S5851A_MODE_SHUTDOWN)
    {
        // if shutdown mode then measurement by one shut
        uint8_t buf[2];
        buf[0] = 0x01;     // use configuration register
        buf[1] = S5851A_MODE_ONESHUT | S5851A_MODE_SHUTDOWN;
        if (! SERCOM3_I2C_Write(S5851A_I2C_ADDRESS, buf, 2))
        {
            return (S5851A_ERR_WRITE);
        }
        if (! _S5851A_waitForCompleted(I2C_OPERATION_TIMEOUT))
        {
            return (S5851A_ERR_WRITE);
        }
        UTIL_delayMicros(30);
    }

    _S5851A_is_measuring = true;

    return (S5851A_ERR_NONE);
}

static bool _S5851A_waitForCompleted(uint32_t timeout)
{
    DEBUG_USB_printlnFormat("> _S5851A_waitForCompleted(): %u", (unsigned int)SYS_mSec)
    uint32_t start = SYS_mSec;
    while (SERCOM3_I2C_IsBusy())
    {
        if (SYS_mSec - start > timeout)
        {
            DEBUG_USB_printlnFormat("< _S5851A_waitForCompleted() ERROR: %u", (unsigned int)SYS_mSec)
            return (false);     // timeout error
        }
    }

    DEBUG_USB_printlnFormat("< _S5851A_waitForCompleted() OK: %u", (unsigned int)SYS_mSec)
    return (true);      // i2c operation was completed
}
