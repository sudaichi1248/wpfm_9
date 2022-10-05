/*
 * File:    smpif3.c
 * Author:  Interark Corp.
 * Summary: WPFM(code name "DLC_04") project Smartphone interface implementation file.
 * Date:    2022/08/16 (R0)
 *          2022/09/07 (R0.1) modify SMPIF_getData() response message format
 * Note:    LOg data related functions.
 */

#define DEBUG_UART                   // Debug with UART

#include "wpfm.h"
#include "util.h"
#include "debug.h"
#include "mlog.h"
#include "rtc.h"
#include "smpif.h"

#define CHUNK_SIZE          256

static int batteryStatusFormat(uint8_t batteryStatus);
static bool makeDatetimeString(uint32_t epochTime, char datetime[]);
static uint32_t alertStatusFormat(uint8_t alertStatus);


void SMPIF_getStatus(const char *param, char *resp)
{
    DEBUG_UART_printlnFormat("MLOG_getStatus() START: %lu", SYS_tick);
    MLOG_STATUS_T mlogStatus;
    MLOG_getStatus(&mlogStatus);
    DEBUG_UART_printlnFormat("MLOG_getStatus() END: %lu", SYS_tick);
    WPFM_measureRegularly(true);

    char oldestDatetime[20], latestDatetime[20];
    if (makeDatetimeString(mlogStatus.oldestDatetime, oldestDatetime) &&
            makeDatetimeString(mlogStatus.latestDatetime, latestDatetime))
    {
        snprintf(resp + 6, SMPIF_MAX_RESPONSE_LENGTH - 1,
                "%lu,%lu,%s,%s,%u,%u,%.1f,%02d",
                WPFM_settingParameter.serialNumber,
                mlogStatus.latestSequentialNumber - mlogStatus.oldestSequentialNumber + 1,
                oldestDatetime, latestDatetime,
                WPFM_lastBatteryVoltages[0], WPFM_lastBatteryVoltages[1],
                (float)(WPFM_lastTemperatureOnBoard / 10.0),
                batteryStatusFormat(WPFM_batteryStatus)
        );

        int length = strlen(resp + 6);
        resp[0] = SMPIF_STX;
        resp[1] = '0' + (length / 100);
        resp[2] = '0' + ((length / 10) % 10);
        resp[3] = '0' + (length % 10);
        resp[4] = 'O';
        resp[5] = 'K';
        resp[6 + length] = SMPIF_ETX;
        resp[7 + length] = '\0';    // terminate
    }
    else
    {
        // flash-memory log was broken.
        sprintf(resp, "%c003NG901%c", SMPIF_STX, SMPIF_ETX);
    }

    // Send message to smartphone app.
    APP_printUSB(resp);
    APP_delay(10);

    SMPIF_dumpMessage("RESP", resp);
    APP_delay(10);
}

void SMPIF_getData(const char *param, char *resp)
{
    uint32_t sequentialNumber = (uint32_t)atoi(param);
    bool failed = false, first = true;
    MLOG_T mlog;
    int stat, number = 0;
    while ((stat = MLOG_findLog(sequentialNumber, &mlog)) == MLOG_ERR_NONE)
    {
        char datetime[20];
        if (! makeDatetimeString(mlog.timestamp.second, datetime))
        {
            APP_delay(20);

            // flash-memory log was broken.
            sprintf(resp, "%c003NG901%c", SMPIF_STX, SMPIF_ETX);
            failed = true;
            break;
        }
        static char buf[80];
        if (first)
        {
            snprintf(buf, sizeof(buf) - 1,
                    (number == 0) ? "%lu,%s,%.3f,%.3f,%08ld" : "/%lu,%s,%.3f,%.3f,%08ld",
                    mlog.sequentialNumber,
                    datetime,
                    mlog.measuredValues[0], mlog.measuredValues[1],
                    alertStatusFormat(mlog.alertStatus)
            );
            first = false;
        }
        else
        {
            snprintf(buf, sizeof(buf) - 1,
                    (number == 0) ? "%s,%.3f,%.3f,%08ld" : "/%s,%.3f,%.3f,%08ld",
                    datetime,
                    mlog.measuredValues[0], mlog.measuredValues[1],
                    alertStatusFormat(mlog.alertStatus)
            );
        }
        strcat(resp + 6, buf);
        DEBUG_UART_printlnFormat("[%08lXh] \"%s\"", mlog.sequentialNumber, buf); APP_delay(20);

        if (++number > SMPIF_MAX_LOGS_PER_RESPONSE)
            break;

        sequentialNumber = mlog.sequentialNumber + 1;
    }
    if (failed)
    {
        // Bad date&time or Get error
        DEBUG_UART_printlnString("--ERROR: bad date&time"); APP_delay(10);

        sprintf(resp, "%c003NG901%c", SMPIF_STX, SMPIF_ETX);
        APP_printUSB(resp);
        APP_delay(10);

        SMPIF_dumpMessage("RESP", resp);
        APP_delay(10);
    }
    else if (number > 0 || stat == MLOG_ERR_NONE)
    {
        int length = strlen(resp + 6);
        DEBUG_UART_printlnFormat("--OK(%d)", length); APP_delay(20);

        resp[0] = SMPIF_STX;
        resp[1] = '0' + (length / 100);
        resp[2] = '0' + ((length / 10) % 10);
        resp[3] = '0' + (length % 10);
        resp[4] = 'O';
        resp[5] = 'K';
        resp[6 + length] = SMPIF_ETX;
        resp[7 + length] = '\0';    // terminate

        //DEBUG_UART_printlnFormat("[%s]", resp); APP_delay(20);

        // Divide and send message to smartphone app.
        length += 7;
        int n = 0;
        for (n = 0; n < length; n += CHUNK_SIZE)
        {
            APP_writeUSB((uint8_t *)resp, CHUNK_SIZE);
            resp += CHUNK_SIZE;
        }
        if (n - length > 0)
        {
            APP_writeUSB((uint8_t *)resp, (n - length + 1));
        }

        //SMPIF_dumpMessage("RESP", resp);
        //APP_delay(200);
    }
    else
    {
        // Bad date&time or Get error
        DEBUG_UART_printlnFormat("--ERROR: %d", stat); APP_delay(20);

        sprintf(resp, "%c003NG203%c", SMPIF_STX, SMPIF_ETX);
        APP_printUSB(resp);
        APP_delay(10);

        SMPIF_dumpMessage("RESP", resp);
        APP_delay(10);
    }
}

static int batteryStatusFormat(uint8_t batteryStatus)
{
    int batteryStatus2digits = 0;
    switch (batteryStatus & 0xf0)
    {
        case MLOG_BAT_STATUS_BAT1_IN_USE:
            batteryStatus2digits = 10;
            break;
        case MLOG_BAT_STATUS_BAT1_LOW_VOLTAGE:
            batteryStatus2digits = 20;
            break;
        default:
            break;
    }
    switch (batteryStatus & 0x0f)
    {
        case MLOG_BAT_STATUS_BAT2_IN_USE:
            batteryStatus2digits += 1;
            break;
        case MLOG_BAT_STATUS_BAT2_LOW_VOLTAGE:
            batteryStatus2digits += 2;
            break;
        default:
            break;
    }

    return (batteryStatus2digits);
}

static bool makeDatetimeString(uint32_t epochTime, char datetime[])
{
    RTC_DATETIME dt;
    if (RTC_convertToDateTime(epochTime, &dt) != RTC_ERR_NONE)
    {
        return (false);     // error!
    }
    sprintf(datetime, "%04u%02u%02u%02u%02u%02u",
            (dt.year + 2000), dt.month, dt.day, dt.hour, dt.minute, dt.second
    );

    return (true);      // okey!
}

static uint32_t alertStatusFormat(uint8_t alertStatus)
{
    uint32_t status = 0;

    // Ch1 alert
    if (alertStatus == MLOG_ALERT_STATUS_CH1_UPPER_WARNING)
    {
        status += 10000000;
    }
    else if (alertStatus == MLOG_ALERT_STATUS_CH1_UPPER_ATTENTION)
    {
        status += 1000000;
    }
    else if (alertStatus == MLOG_ALERT_STATUS_CH1_LOWER_ATTENTION)
    {
        status += 100000;
    }
    else if (alertStatus == MLOG_ALERT_STATUS_CH1_LOWER_WARNING)
    {
        status += 10000;
    }

    // Ch2 alert
    if (alertStatus == MLOG_ALERT_STATUS_CH2_UPPER_WARNING)
    {
        status += 1000;
    }
    else if (alertStatus == MLOG_ALERT_STATUS_CH2_UPPER_ATTENTION)
    {
        status += 100;
    }
    else if (alertStatus == MLOG_ALERT_STATUS_CH2_LOWER_ATTENTION)
    {
        status += 10;
    }
    else if (alertStatus == MLOG_ALERT_STATUS_CH2_LOWER_WARNING)
    {
        status += 1;
    }

    return (status);
}
