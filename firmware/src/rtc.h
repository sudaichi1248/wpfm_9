/*
 * File:    rtc.h
 * Author:  Interark Corp.
 * Summary: Real Time Clock(RX-8035) driver header file.
 * Date:    2022/07/29 (R0)
 * Note:    Refer to Application manual of RX-8035SA/LC [ETM35J-09(Epson)]
 */

#ifndef RTC_H
#define	RTC_H

#ifdef	__cplusplus
extern "C" {
#endif

#include "definitions.h"

// Constants
#define RTC_I2C_ADDRESS         0x32            // Slave address of RX-8035
#define RTC_CHIP_NAME           "RX-8035LC"     // Chip name

// Error codes(return value of each function)
#define RTC_ERR_NONE            0               // Succeed, no error
#define RTC_ERR_PARAM           (-1)            // Parameter error
#define RTC_ERR_READ            (-2)            // i2c read error
#define RTC_ERR_WRITE           (-3)            // i2c write error
#define RTC_ERR_INTERNAL        (-10)           // internal error or bug
#define RTC_ERR_INITIALIZED     (-20)           // RTC setting and clock was initialized

/*
*   Types
*/
typedef struct {
    uint8_t year, month, day;       // year(0-2X),month(1-12),day(1-31)
    uint8_t hour, minute, second;   // hour(0-23),minute(0-59),second(0-59)
} RTC_DATETIME;             //-

typedef enum {
    RTC_TIMEUPDATE_SECOND = 0,      // set interrupt every second update
    RTC_TIMEUPDATE_MINUTE,          // set interrupt every minute update
    RTC_TIMEUPDATE_DONT_CARE        // Don't care
} RTC_TIMEUPDATE_TYPE;      //-

typedef void (*RTC_HANDLER)(void);  //-

/*
*   Functions
*/
extern int RTC_initialize(EIC_PIN interruptPinA, EIC_PIN interruptPinB);
extern int RTC_setDateTime(RTC_DATETIME dt);
extern int RTC_getDatetime(RTC_DATETIME *dt_p);
extern uint32_t RTC_getEpoch(void);     // return epoch time(sec.) as JST
extern int RTC_convertToDateTime(uint32_t epochTime, RTC_DATETIME *dt_p);
extern int RTC_setTimeUpdateInterrupt(RTC_TIMEUPDATE_TYPE which, RTC_HANDLER handler);
extern int RTC_setAlarm(uint32_t minutesLater, RTC_HANDLER handler);
extern int RTC_writeNVRAM(uint8_t data);
extern int RTC_readNVRAM(uint8_t *data_p);

/*
*   Variables
*/
extern volatile uint32_t RTC_now;       // Current epoch time[Sec] - maintenanced by setDatatime() and _RTC_handlerB()

#ifdef	__cplusplus
}
#endif

#endif	/* RTC_H */
