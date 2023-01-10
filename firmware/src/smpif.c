/*
 * File:    smpif.c
 * Author:  Interark Corp.
 * Summary: WPFM(code name "DLC_04") project Smartphone interface implementation file.
 * Date:    2022/08/18 (R0)
 *          2022/10/08 (R0.1) Introduce DEBUG_ADD_LF symbol
 * Note:    Common definitions
 */

#define DEBUG_UART                   // Debug with UART
//#define DEBUG_ADD_LF                 // If defined, command response terminated by LF for debugging

#include <string.h>
#include <ctype.h>
#include "wpfm.h"
#include "app.h"
#include "util.h"
#include "debug.h"
#include "uart_debug.h"
#include "smpif.h"
#include "Eventlog.h"
#include "Moni.h"
#include "DLCpara.h"
/*
*   Symbols
*/
#define HEADER_LENGTH           6

/*
*   Globals
*/
int SMPIF_errorColumn = 0;              // Column number where error occurred in parameter
int SMPIF_errorPosition = 0;            // Position(byte offset) where error occurred in parameter

/*
*   Locals(static)
*/
typedef void (*COMMAND_HANDLER)(const char *param, char *resp);

typedef struct
{
    char                *messageId;
    COMMAND_HANDLER     handler;
} SMPIF_COMMAND_TABLE;

static char _SMPIF_parameterBuffer[SMPIF_MAX_PARAMETER_LENGTH];
static char _SMPIF_responseBuffer[SMPIF_MAX_RESPONSE_LENGTH];
static int _SMPIF_commandTableIndex = 0;
static SMPIF_COMMAND_TABLE _SMPIF_commandTables[] =
    {
        { "PG", SMPIF_getOperationalCondition },
        { "PS", SMPIF_setOperationalCondition },
        { "VS", SMPIF_startSendRegularly },
        { "VE", SMPIF_endSendRegularly },
        { "SG", SMPIF_getStatus },
        { "DG", SMPIF_getData },
        { "CG", SMPIF_getCallibrationValues },
        { "CS", SMPIF_setCallibrationValues },
        { "CN", SMPIF_notifyCallibrationTarget },
        { "CR", SMPIF_readCallibrationValues },
        { "TS", DLCMatSetClock },
        { "TG", DLCMatGetClock },
        { "M0", DLCMatVersion },
        { "M1", DLCMatUpdateGo },
        { "M2", DLCMatFotaGo },
        { "M3", DLCMatServerChange },
        { "M4", DLCMatEventLog },
        { "M5", DLCMatRepotLogChange },
        { "M6", DLCMatBatCarivChange },
        { "M7", DLCMatSettingClear },
        { "M8", DLCMatEventLogClr },
        { "M9", DLCMatReportLmt },
        { "MA", DLCMatReportFlg },
        { NULL, NULL }
    };

static void discardMessage(const char *cause);


int SMPIF_readMessage(void)
{
    // read fixed length header
    if (APP_getRemainedBytesUSB() < HEADER_LENGTH)
    {
        return (SMPIF_ERR_NO_MESSAGE);
    }

    char header[HEADER_LENGTH+1];
    APP_readUSB((uint8_t *)header, HEADER_LENGTH);
    header[HEADER_LENGTH] = '\0';

    if (header[0] != SMPIF_STX)
    {
        discardMessage("NO STX");

        return (SMPIF_ERR_BAD_FORMAT);
    }
    if (! isdigit(header[1]) || ! isdigit(header[2]) || ! isdigit(header[2]))
    {
        discardMessage("BAD LENGTH");

        return (SMPIF_ERR_BAD_FORMAT);
    }
    DEBUG_UART_printlnFormat("header[]: \"%s\"", header);

    // read variable length parameter
    bool failed = false;
    int readBytes = 0, totalBytes = 0, parameterLength = atoi(header + 1);
    while (totalBytes < parameterLength)
    {
        readBytes = APP_readUSB((uint8_t *)(_SMPIF_parameterBuffer + totalBytes), (parameterLength - totalBytes));
        if (readBytes < 0)
        {
            failed = true;
            break;
        }
        totalBytes += readBytes;
    }
    if (failed)
    {
        DEBUG_UART_printlnFormat("SMPIF_readMessage() read error: %d", readBytes);
        discardMessage("READ ERROR");

        return (SMPIF_ERR_BAD_FORMAT);
    }
    else
    {
        char c;
        if ((c = (char)APP_getByteUSB()) != SMPIF_ETX)
        {
            DEBUG_UART_printlnFormat("SMPIF_readMessage() no ETX: %02Xh", c);
            discardMessage("NO ETX");

            return (SMPIF_ERR_BAD_FORMAT);
        }
    }
    _SMPIF_parameterBuffer[totalBytes] = '\0';

    DEBUG_UART_printlnFormat("SMPIF_parameterBuffer[]: \"%s\"", _SMPIF_parameterBuffer);

    _SMPIF_commandTableIndex = -1;
    for (int i = 0; _SMPIF_commandTables[i].messageId != NULL; i++)
    {
        if (! strncmp(_SMPIF_commandTables[i].messageId, header + 4, 2))
        {
            _SMPIF_commandTableIndex = i;
            DEBUG_UART_printlnFormat("_SMPIF_commandTableIndex: %d(%s)", _SMPIF_commandTableIndex, header + 4);

            //return (_SMPIF_commandTables[i].waitForCommand ? SMPIF_ERR_WAIT_FOR_COMMAND : SMPIF_ERR_NONE);
			DLCEventLogWrite( _ID1_USB_CMD_OKNG,i,0 );
            return (SMPIF_ERR_NONE);
        }
    }
	DLCEventLogWrite( _ID1_USB_CMD_OKNG,-1,0 );

    DEBUG_UART_printlnFormat("_SMPIF_commandTableIndex: not found(%s)", header + 4);

    return (SMPIF_ERR_BAD_MSGID);
}

int SMPIF_handleMessage(void)
{
    DEBUG_UART_printlnFormat("SMPIF_handleMessage(): (%d)", _SMPIF_commandTableIndex);

    if (_SMPIF_commandTableIndex < 0)
    {
        return (SMPIF_ERR_BAD_MSGID);
    }

    // call command handler
    memset((void *)_SMPIF_responseBuffer, 0, SMPIF_MAX_RESPONSE_LENGTH);
    (*(_SMPIF_commandTables[_SMPIF_commandTableIndex].handler))(_SMPIF_parameterBuffer, _SMPIF_responseBuffer);

#ifdef DEBUG_ADD_LF
    APP_printlnUSB("");     // Response terminated by LF for debugging
#endif

    DEBUG_UART_printlnFormat("call handler(%d) done.", _SMPIF_commandTableIndex);
    return (SMPIF_ERR_NONE);
}

void SMPIF_dumpMessage(const char *prefix, const char *message)
{
    int length = strlen(message);
    UART_DEBUG_writeBytes(prefix, strlen(prefix));
    UART_DEBUG_write('>');     // as STX
    UART_DEBUG_writeBytes(message + 1, length - 2);
    UART_DEBUG_write('<');     // as STX
    UART_DEBUG_write('\n');
}

static void discardMessage(const char *cause)
{
    uint32_t start = SYS_tick;
    while (APP_getByteUSB() != SMPIF_ETX)
    {
        SYS_Tasks();
        if (SYS_tick - start > 500)
        {
            DEBUG_UART_printlnFormat(">>%s: not found ETX", cause);
            return;
        }
    }
    DEBUG_UART_printlnFormat(">>%s: found ETX", cause);
}
