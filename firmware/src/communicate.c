/*
 * File:    communicate.c
 * Author:  Interark Corp.
 * Summary: WPFM(code name "DLC_04") project communication implementation file.
 * Date:    2022/08/12 (R0)
 * Note:    DUMMY functions
 */

#define DEBUG_UART

#include "wpfm.h"
#include "debug.h"
#include "util.h"
#include "rtc.h"
#include "mlog.h"

void WPFM_uploadRegularly(void)
{
    /*
     *  Communication processing is described here -- BEGIN --
     ***/

     WPFM_uploadOneShot(true);

    /*
     *  -- END --
     ***/
}

/*
*   Upload logged date only once
*/
void WPFM_uploadOneShot(bool unsentOrEmpty)
{
    // Wake up MATcore
    RF_INT_IN_Set();    // INT_IN high to wake up
#if 0
    APP_delay(10);

    if (unsentOrEmpty)
    {
        // Send all unuploaded data
        /*
         *  Communication processing is described here -- BEGIN --
         ***/

        UTIL_LED1_ON();

        DEBUG_UART_printlnFormat("-- UPLOAD UNSENT MLOG(%u) --", (unsigned int)MLOG_countUploadableLog());
        int stat;
        MLOG_T mlog;
        while ((stat = MLOG_getLog(&mlog)) >= MLOG_ERR_NONE)
        {
            static char _line[100];
            RTC_DATETIME dt;
            RTC_convertToDateTime(mlog.timestamp.second, &dt);
            snprintf(_line, sizeof(_line)-1,
                    "[MLOG %06Xh/%08u] %04d/%02d/%02d %02d:%02d:%02d.%03d,%.3f,%.3f,%u,%u,%.1f,%02Xh,%02Xh",
                    (unsigned int)stat, (unsigned int)mlog.sequentialNumber,
                    (int)(dt.year + 2000), (int)dt.month, (int)dt.day, (int)dt.hour, (int)dt.minute, (int)dt.second, mlog.timestamp.mSecond,
                    mlog.measuredValues[0], mlog.measuredValues[1],
                    (unsigned int)mlog.batteryVoltages[0], (unsigned int)mlog.batteryVoltages[1], (float)mlog.temperatureOnBoard / 10.0,
                    mlog.alertStatus, mlog.batteryStatus);
            DEBUG_UART_printlnString(_line);
            DEBUG_UART_FLUSH();
        }

        if (stat != MLOG_ERR_EMPTY)
        {
            DEBUG_UART_printlnFormat("MLOG_getLog() NG: %d", stat);
        }

        DEBUG_UART_printlnFormat("-- DONE --");

        UTIL_LED1_OFF();

        /*
         *  -- END --
         ***/
    }
    else
    {
        // Send empty data fot test
        DEBUG_UART_printlnString("WPFM_uploadOneShot() upload empty data.");
    }

    // Sleep MATcore
    APP_delay(10);
   RF_INT_IN_Clear();    // INT_IN low to sleep
#endif
}

/*
*   Notificate alert immediately
*/
void WPFM_notifyAlert(void)
{
    APP_delay(10);
    RF_INT_IN_Set();    // INT_IN high to wake up
    DEBUG_UART_printlnString("[[NOTIFY WARNING ALERT !!]]\n");
    APP_delay(5);
}
