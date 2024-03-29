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
void DLCMatCall(int);
#ifdef ADD_FUNCTION
void DLCMatAlertTimeStart();
#endif
/*
	定期通信
*/
void WPFM_uploadRegularly(void)
{
    DLCMatCall(1);
}
/*
*   強制発報
*/
void WPFM_uploadOneShot(bool unsentOrEmpty)
{
	WPFM_ForcedCall = true;
	UTIL_startBlinkLED1(5);	// LED1 5回点滅
    DLCMatCall(2);
}
/*
*   警報発報
*/
void WPFM_notifyAlert(void)
{
    APP_delay(10);
    DLCMatCall(3);
#ifdef ADD_FUNCTION
    DLCMatAlertTimeStart();
#endif
    DEBUG_UART_printlnString("[[NOTIFY WARNING ALERT !!]]\n");
    APP_delay(5);
}
