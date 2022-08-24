/*
 * File:    smpif2.c
 * Author:  Interark Corp.
 * Summary: WPFM(code name "DLC_04") project Smartphone interface implementation file.
 * Date:    2022/08/16 (R0)
 * Note:    Periodic measure related functions.
 */

#define DEBUG_UART                   // Debug with UART

#include "wpfm.h"
#include "util.h"
#include "debug.h"
#include "smpif.h"

void SMPIF_sendRegularly(void)
{
    char buffer[50];
    // Make message
    snprintf(buffer + 6, sizeof(buffer) - 1,
            "%u,%.3f,%.3f",
            WPFM_measurementInterval, WPFM_lastMeasuredValues[0], WPFM_lastMeasuredValues[1]);
    int length = strlen(buffer + 6);

    buffer[0] = SMPIF_STX;
    buffer[1] = '0' + (length / 100);
    buffer[2] = '0' + ((length / 10) % 10);
    buffer[3] = '0' + (length % 10);
    buffer[4] = 'V';
    buffer[5] = 'R';
    buffer[6 + length] = SMPIF_ETX;
    buffer[7 + length] = '\0';    // terminate

    // Send message to smartphone app.
    APP_printUSB(buffer);

    SMPIF_dumpMessage("PUSH", buffer);
}

void SMPIF_startSendRegularly(const char *param, char *resp)
{
    DEBUG_UART_printlnFormat("> SMPIF_startSendRegularly(\"%s\", -)", param);
    APP_delay(3);

    if (WPFM_isInSendingRegularly)
    {
        // Already start..
        sprintf(resp, "%c003NG201%c", SMPIF_STX, SMPIF_ETX);
    }
    else
    {
        WPFM_isInSendingRegularly = true;

        WPFM_measureRegularly(true);

        snprintf(resp + 6, SMPIF_MAX_RESPONSE_LENGTH - 1,
                "%u,%.3f,%.3f",
                WPFM_measurementInterval, WPFM_lastMeasuredValues[0], WPFM_lastMeasuredValues[1]);
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

    // Send message to smartphone app.
    APP_printUSB(resp);
    APP_delay(2);

    SMPIF_dumpMessage("RESP", resp);
    APP_delay(2);
}

void SMPIF_endSendRegularly(const char *param, char *resp)
{
    DEBUG_UART_printlnFormat("> SMPIF_endSendRegularly(\"%s\", -)", param);
    APP_delay(2);

    if (! WPFM_isInSendingRegularly)
    {
        // Already end..
        sprintf(resp, "%c003NG202%c", SMPIF_STX, SMPIF_ETX);
    }
    else
    {
        WPFM_isInSendingRegularly = false;

        sprintf(resp, "%c000OK%c", SMPIF_STX, SMPIF_ETX);
    }

    // Send message to smartphone app.
    APP_printUSB(resp);
    APP_delay(2);

    SMPIF_dumpMessage("RESP", resp);
    APP_delay(2);
}
