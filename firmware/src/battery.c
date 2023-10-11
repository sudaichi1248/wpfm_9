/*
 * File:    battery.c
 * Author:  Interark Corp.
 * Summary: WPFM(code name "DLC_04") project battery control file.
 * Date:    2022/08/13 (R0)
 *          2022/10/01 (R1) Once the voltage drops, maintain battery status until replacement.(Respond to requests from Mr. Kasai)
 *          2022/10/12 (R2) 
 * Note:
 */

#define DEBUG_UART

#include "wpfm.h"
#include "util.h"
#include "debug.h"
#include "mlog.h"
#include "battery.h"
#include "moni.h"
#include "Eventlog.h"
#include "DLCpara.h"

#ifdef DEBUG_UART
#   define  DBG_PRINT(...)  { if (DLC_Para.MeasureLog == 0) {char _line[80]; snprintf(_line, sizeof(_line),  __VA_ARGS__); UART_DEBUG_writeBytes(_line, strlen(_line)); UART_DEBUG_writeBytes("\n", 1);} }
#else
#   define  DBG_PRINT()
#endif
void BATTERY_AutoResume();
/*
*   外部電池の電圧をチェックし、条件がそろえば、使用する電池を交換する
*   両方の電池が使えない場合は、処理を停止する。
*/
int BATTERY_checkAndSwitchBattery(void)
{
	char	LoNow[2],HiNow[2];
    // Check both batteries for low voltage.
    if( WPFM_timesBelowTheThresholds[0] == 0 )
    	memset( HiNow,0,sizeof ( HiNow ));
    for (int batteryIndex = 0; batteryIndex < 2; batteryIndex++){
        if (WPFM_lastBatteryVoltages[batteryIndex] < WPFM_settingParameter.lowThresholdVoltage){
            DBG_PRINT("Battery #%d low.", batteryIndex + 1);
            LoNow[batteryIndex] = 1;
            if (WPFM_timesBelowTheThresholds[batteryIndex] > 0){
                WPFM_timesBelowTheThresholds[batteryIndex]++;   // count up if continuously
            }
            else {
                WPFM_timesBelowTheThresholds[batteryIndex] = 1;
            }
        }
        else {
            //uint16_t mask = (batteryIndex == 0) ? MLOG_BAT_STATUS_BAT1_LOW_VOLTAGE : MLOG_BAT_STATUS_BAT2_LOW_VOLTAGE;
            //WPFM_batteryStatus &= ~mask;
            LoNow[batteryIndex] = 0;
            WPFM_timesBelowTheThresholds[batteryIndex] = 0;     // reset counter
        }
	    if (WPFM_lastBatteryVoltages[batteryIndex] >= (WPFM_settingParameter.lowThresholdVoltage + BATTERY_MEASURE_MARGIN))//電池が交換されている
		    HiNow[batteryIndex]++;
        else
		    HiNow[batteryIndex] = 0;
    }
    // Set in-use flag to WPFM_batteryStatus
    switch (WPFM_externalBatteryNumberInUse){
        case 1:
            WPFM_batteryStatus &= ~MLOG_BAT_STATUS_BAT2_IN_USE;
            WPFM_batteryStatus |= MLOG_BAT_STATUS_BAT1_IN_USE;
            break;
        case 2:
            WPFM_batteryStatus &= ~MLOG_BAT_STATUS_BAT1_IN_USE;
            WPFM_batteryStatus |= MLOG_BAT_STATUS_BAT2_IN_USE;
            break;
        default:
            DEBUG_UART_printlnFormat("WPFM_externalBatteryNumberInUse is bad: %d", WPFM_externalBatteryNumberInUse);
            break;
    }
    DBG_PRINT("WPFM_batteryStatus %02X\n", WPFM_batteryStatus);
    BATTERY_AutoResume( HiNow );													/* Added 23.10.3 */
    // Switch batteries if necessary.
    uint16_t batteryStatus = WPFM_batteryStatus;
    if (WPFM_timesBelowTheThresholds[0] >= WPFM_settingParameter.timesLessThresholdVoltage){
        // external battery #1 is low
        WPFM_externalBatteryNumberToReplace = 1;
        batteryStatus |= MLOG_BAT_STATUS_BAT1_LOW_VOLTAGE;
		if( LoNow[1] == 0 ){															/* Added 23.8.21 直前がLoである場合は切替ない */
			if (batteryStatus & MLOG_BAT_STATUS_BAT2_LOW_VOLTAGE){
	            // external battery #2 is low too
	            WPFM_batteryStatus = batteryStatus;
	            return (BATTERY_ERR_HALT);      // It will be stopped by caller
	        }
	        if (WPFM_batteryStatus & MLOG_BAT_STATUS_BAT1_IN_USE){
	            // Switch battery #1 -> battery #2
	            batteryStatus &= ~MLOG_BAT_STATUS_BAT1_IN_USE;
	            batteryStatus |= MLOG_BAT_STATUS_BAT2_IN_USE;
	            WPFM_externalBatteryNumberToReplace = 1;
	            // First, attach external battery #2
	            EXT2_OFF_Clear();
	            APP_delay(300);     // wait a little
	            // Second, detach external battery #1
	            EXT1_OFF_Set();
	            // Current uising battery # is 2
	            WPFM_externalBatteryNumberInUse = 2;
				if (DLC_Para.MeasureLog == 0) {
		            DEBUG_UART_printlnString("Exchange Battery #1 -> #2");
				}
				DLCEventLogWrite( _ID1_CELLACT,batteryStatus,WPFM_lastBatteryVoltages[0]<<16|WPFM_lastBatteryVoltages[1] );
	        }
	        WPFM_batteryStatus = batteryStatus;
	    }
	    else {
	    	putst("\r\nCannot Switch(#2 Lo)\r\n");
            return (BATTERY_ERR_HALT);      // It will be stopped by caller
		}
    }
    if (WPFM_timesBelowTheThresholds[1] >= WPFM_settingParameter.timesLessThresholdVoltage) {
        // external battery #2 is low
        WPFM_externalBatteryNumberToReplace = 2;
        batteryStatus |= MLOG_BAT_STATUS_BAT2_LOW_VOLTAGE;
		if( LoNow[0] == 0 ){															/* Added 23.8.21 直前がLoである場合は切替ない */
	        if (batteryStatus & MLOG_BAT_STATUS_BAT1_LOW_VOLTAGE){
	            // external battery #1 is low too
	            WPFM_batteryStatus = batteryStatus;
	            return (BATTERY_ERR_HALT);      // It will be stopped by caller
	        }
	        if (WPFM_batteryStatus & MLOG_BAT_STATUS_BAT2_IN_USE){
	            // Switch batter #2 -> battery #1
	            batteryStatus &= ~MLOG_BAT_STATUS_BAT2_IN_USE;
	            batteryStatus |= MLOG_BAT_STATUS_BAT1_IN_USE;
	            WPFM_externalBatteryNumberToReplace = 2;
	            // First, attach external battery #1
	            EXT1_OFF_Clear();
	            APP_delay(300);     // wait a little
	            // Second, detach external battery #2
	            EXT2_OFF_Set();
	            // Current uising battery # is 1
	            WPFM_externalBatteryNumberInUse = 1;
				if (DLC_Para.MeasureLog == 0) {
		            DEBUG_UART_printlnString("Exchange Battery #2 -> #1");
				}
				DLCEventLogWrite( _ID1_CELLACT,batteryStatus,WPFM_lastBatteryVoltages[0]<<16|WPFM_lastBatteryVoltages[1] );
	        }
	        WPFM_batteryStatus = batteryStatus;
        }
	    else {
	    	putst("\r\nCannot Switch(#1 Lo)\r\n");
	        return (BATTERY_ERR_HALT);      // It will be stopped by caller
		}
    }
    return (BATTERY_ERR_NONE);
}

int BATTERY_enterReplaceBattery(void)
{
    switch (WPFM_externalBatteryNumberToReplace)
    {
        case 0:
            // No battery to echange
            return (BATTERY_ERR_NOT_NECESSARY);

        case 1:
            // Indicate battery #1 to exchange by blinking ext-led1
            UTIL_startBlinkEXT1LED();
            WPFM_startExchangingBatteryTime = WPFM_now;
            // Just in case, detach external battery #1
            EXT1_OFF_Set();
 			DLCEventLogWrite( _ID1_CELLACT,0xfc,WPFM_lastBatteryVoltages[0]<<16|WPFM_lastBatteryVoltages[1] );
           break;

        case 2:
            // Indicate battery #2 to exchange by blinking ext-led2
            UTIL_startBlinkEXT2LED();
            WPFM_startExchangingBatteryTime = WPFM_now;
            // Just in case, detach external battery #2
            EXT2_OFF_Set();
			DLCEventLogWrite( _ID1_CELLACT,0xfd,WPFM_lastBatteryVoltages[0]<<16|WPFM_lastBatteryVoltages[1] );
            break;
    }

    return (BATTERY_ERR_NONE);
}

int BATTERY_leaveReplaceBattery(void)
{
    DEBUG_UART_printlnFormat("> BATTERY_leaveReplaceBattery() : %d", WPFM_externalBatteryNumberToReplace);
    uint16_t voltage = 0;
    SENSOR_readExternalBatteryVoltage(WPFM_externalBatteryNumberToReplace, &voltage);
    if (voltage < WPFM_settingParameter.lowThresholdVoltage + BATTERY_MEASURE_MARGIN)
    {
        // If the battery is replaced failed
        DEBUG_UART_printlnFormat("< BATTERY_leaveReplaceBattery() ERROR: %dmV", voltage);
        return (BATTERY_ERR_LOW_VOLTAGE);
    }

    // If the battery is replaced successfully
    switch (WPFM_externalBatteryNumberToReplace)
    {
        case 1:
            WPFM_timesBelowTheThresholds[0] = 0;
            WPFM_batteryStatus &= ~MLOG_BAT_STATUS_BAT1_LOW_VOLTAGE;    // @add(R1)
            break;
        case 2:
            WPFM_timesBelowTheThresholds[1] = 0;
            WPFM_batteryStatus &= ~MLOG_BAT_STATUS_BAT2_LOW_VOLTAGE;    // @add(R1)
            break;
    }
    BATTERY_turnOffExtLed();
    WPFM_externalBatteryNumberToReplace = 0;
    WPFM_startExchangingBatteryTime = 0;

    DEBUG_UART_printlnString("< BATTERY_leaveReplaceBattery() OK");
    return (BATTERY_ERR_NONE);
}

void BATTERY_turnOffExtLed(void)
{
    switch (WPFM_externalBatteryNumberToReplace)
    {
        case 1:
            UTIL_stopBlinkEXT1LED();
            UTIL_setEXT1LED();
            break;
        case 2:
            UTIL_stopBlinkEXT2LED();
            UTIL_setEXT2LED();
            break;
    }
}

void BATTERY_shutdown(void)
{
    fatal("both batteries are too low voltage", 0);

    // Detach both batteries
    EXT1_OFF_Set();
    EXT2_OFF_Set();

    // Fall asleep if possible..
    WPFM_sleep();
}
/*
	電池交換後のPushスイッチ忘れ用に自動で電池ステータスを戻す
*/
void BATTERY_AutoResume(	char	HiNow[] )
{
	switch( WPFM_batteryStatus ){
	case MLOG_BAT_STATUS_BAT1_IN_USE|MLOG_BAT_STATUS_BAT2_LOW_VOLTAGE:
		if( HiNow[1] >= 3){		/* Loだった電池2が交換されてる雰囲気 */
			BATTERY_leaveReplaceBattery();
		}
		break;
	case MLOG_BAT_STATUS_BAT1_LOW_VOLTAGE|MLOG_BAT_STATUS_BAT2_IN_USE:
		if( HiNow[0] >= 3){		/* Loだった電池21交換されてる雰囲気 */
			BATTERY_leaveReplaceBattery();
		}
		break;
	}
}
