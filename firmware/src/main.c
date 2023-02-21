/*******************************************************************************
  Main Source File

  Company:
    Interark Corp.

  File Name:
    main.c

  Date:
    2022/09/19 (R0)
    2022/10/08 (R0.1) Introduce DEBUG_ADD_LF symbol for debugging

  Summary:
    This file contains the "main" function for a project.

  Description:
    This source files is for DLC-04 project.

*******************************************************************************/

// *****************************************************************************
// *****************************************************************************
// Section: Included Files
// *****************************************************************************
// *****************************************************************************

#define DEBUG_UART
//#define DEBUG_ADD_LF                 // If defined, command response terminated by LF for debugging

#include <stddef.h>
#include <stdbool.h>
#include <stdlib.h>
#include "definitions.h"
#include "wpfm.h"
#include "util.h"
#include "debug.h"
#include "battery.h"
#include "rtc.h"
#include "smpif.h"

/* temporary */
#include "w25q128jv.h"
#include "s5851a.h"
#include "mlog.h"
#include "Moni.h"
#include "DLCpara.h"
#include "Eventlog.h"
void	DLCMatMain();
int		DLCMatIsSleep();
extern int		RTCReadRetry;
extern int		RTCWriteRetry;

/*
*   Local functions
*/
static void eventLoopOnMeasurementMode(void);
static void eventLoopOnNonMeasurementMode(void);

// *****************************************************************************
// *****************************************************************************
// Section: Main Entry Point
// *****************************************************************************
// *****************************************************************************

int main(void)
{
    WPFM_status = WPFM_STATUS_INITIALIZING;

    /* Initialize all modules */
    SYS_Initialize(NULL);
	DLCParaRead();
    /*** FOR DEBUG ***/
    if (TEST_SW_Get() == 0)
    {
        DEBUG_UART_printlnString("## ERASE CHIP ##");
        DEBUG_UART_printlnString("## DO NOT POWER OFF ##");
        UTIL_startBlinkLED1(0);
        // Erase flash memory chip
        W25Q128JV_begin(MEM_CS_PIN);
        int stat;
		DLCEventLogClr(0);
        if ((stat = W25Q128JV_eraseChip(true)) == W25Q128JV_ERR_NONE)
        {
            DEBUG_UART_printlnString("ERASE CHIP OK.");
        }
        else
        {
            DEBUG_UART_printlnFormat("ERASE CHIP ERROR: %d", stat);
        }
        UTIL_stopBlinkLED1();
		DLCEventLogWrite( _ID1_INIT_ALL,0,0 );
    }

    /* Get current operation mode */
    WPFM_operationMode = UTIL_getPowerModeSW();

    /* Initialize for application */
    WPFM_initializeApplication();

    //DEBUG_UART_printlnFormat("WPFM_SETTING_PARAMETER size = %u", (unsigned int)sizeof(WPFM_SETTING_PARAMETER));
    //DEBUG_UART_printlnFormat("MLOG_T size = %u", (unsigned int)sizeof(MLOG_T));
    //DEBUG_UART_printlnFormat("MLOG Max logs = %u", ((MLOG_ADDRESS_MLOG_LAST + 1) / 256) * MLOG_LOGS_PER_PAGE);

    // Read temperature sensor on board 起動時も温度測定
	WPFM_getTemperature();

    // Main-loop
    int stat;
    if ((WPFM_operationMode == WPFM_OPERATION_MODE_NON_MEASUREMENT)||(DLC_Para.FOTAact == 0)) /* 非測定モードorFOTA */
    {
        // Execute on non-measurement mode processing
        DEBUG_UART_printlnString("RUN AS NON-MEASUREMENT MODE");

		// 押しボタン強制発報のため測定logチェック要
        if ((stat = MLOG_begin(true)) != MLOG_ERR_NONE)
        {
            DEBUG_UART_printlnFormat("MLOG ERROR: %d", stat);
            DEBUG_HALT();
        }
        WPFM_status = WPFM_STATUS_WAIT_COMMAND;
        SENSOR_updateMeasurementInterval(1);
        DEBUG_UART_printlnFormat("START NON-MEASURE MODE(%lu)", SYS_tick);
        eventLoopOnNonMeasurementMode();
    }
    else
    {
        // Execute on measurement mode processing
        DEBUG_UART_printlnString("RUN AS MEASUREMENT MODE");
        UTIL_startBlinkLED1(5);
		// initから移動
        if (! WPFM_setNextCommunicateAlarm())
        {
            DEBUG_UART_printlnString("RTC_setAlarm() ERROR");
            DEBUG_HALT();
        }
        if ((stat = MLOG_begin(true)) != MLOG_ERR_NONE)
        {
            DEBUG_UART_printlnFormat("MLOG ERROR: %d", stat);
            DEBUG_HALT();
        }
        WPFM_status = WPFM_STATUS_WAIT_COMMAND;
        DEBUG_UART_printlnFormat("START MEASURE MODE(%lu)", SYS_tick);
        eventLoopOnMeasurementMode();
    }

    /* Execution should not come here during normal operation */
    return (EXIT_FAILURE);
}
/* 
	スライドスイッチのチャタリング用
*/
void SlideSwProc()
{
	if (UTIL_getPowerModeSW() != WPFM_operationMode){								// スライドスイッチの設定が変更されたか否かをチェックする
		WPFM_reboot();																// 変更されていた時は、リブートして新しい動作モードで処理を開始する
	}
}
/*
*   測定モード時のメインループ処理
*/
static void eventLoopOnMeasurementMode(void)
{
	APP_delay(20);
	SlideSwProc();
    while (true)
    {
        SYS_Tasks();
	    DLCMatMain();
        // タクトスイッチが押下されたどうかをチェックする
        if (WPFM_wasButtonPressed)
        {
            if ((SYS_tick-WPFM_lastButtonPressedTime) >=  WPFM_LONG_PRESSED_TIME ){
			    if (TEST_SW_Get()){	                // ボタン押されてない
	                DEBUG_UART_printlnString(">>SHORT PRSD");
	                WPFM_uploadOneShot(true);       // 未送信のログデータをアップロード
	            }
	            else {				                // 押されたまま
	                DEBUG_UART_printlnString(">>LONG PRSD");
	                if (WPFM_isBeingReplacedBattery)
	                {
						DLCEventLogWrite( _ID1_CELLACT,0xfe,WPFM_lastBatteryVoltages[0]<<16|WPFM_lastBatteryVoltages[1] );
	                    // 電池交換を終了する
	                    DEBUG_UART_printFormat("END REPLACE(#%d)", WPFM_externalBatteryNumberToReplace);
	                    int stat;
	                    if ((stat = BATTERY_leaveReplaceBattery()) == BATTERY_ERR_NONE)
	                    {
	                        // 電池交換の終了に成功したとき
	                        DEBUG_UART_printlnString(" - OK");
	                        if ((stat = MLOG_returnToFlash()) != MLOG_ERR_NONE)
	                        {
	                            DEBUG_UART_printlnFormat("MLOG_returnToFlash() error: %d", stat);
	                        }

	                        WPFM_isBeingReplacedBattery = false;
	                    }
	                    else
	                    {
	                        // 電池交換の終了に失敗したとき（交換した電池の電圧が低い）は、終了せず、何もしない
	                        DEBUG_UART_printlnFormat(" - ERROR: %d", stat);
	                    }
	                    DEBUG_UART_FLUSH();
	                }
	                else
	                {
						DLCEventLogWrite( _ID1_CELLACT,0xff,WPFM_lastBatteryVoltages[0]<<16|WPFM_lastBatteryVoltages[1] );
	                    // 電池交換を開始する
	                    DEBUG_UART_printFormat("BEGIN REPLACE(#%d)", WPFM_externalBatteryNumberToReplace);
	                    int stat;
	                    if ((stat = BATTERY_enterReplaceBattery()) == BATTERY_ERR_NONE)
	                    {
	                        // 電池交換の開始に成功したとき
	                        DEBUG_UART_printlnString(" - OK");
	                        if ((stat = MLOG_switchToSRAM()) != MLOG_ERR_NONE)
	                        {
	                            DEBUG_UART_printlnFormat("MLOG_switchToSRAM() error: %d", stat);
	                        }
	                        WPFM_isBeingReplacedBattery = true;
	                        WPFM_startExchangingBatteryTime = RTC_now;
	                    }
	                    else
	                    {
	                        // 電池交換の開始に失敗したとき（電池交換が必要ないとき）は、無視する
	                        DEBUG_UART_printlnFormat(" - ERROR: %d", stat);
	                    }
	                    DEBUG_UART_FLUSH();
	                }
	            }
                WPFM_tactSwStatus = WPFM_TACTSW_STATUS_NORMAL;
	            WPFM_wasButtonPressed = false;
	        }
        }

        // 定期計測のタイミングかどうかチェックする
        if (WPFM_doMeasure)
        {
            // 定期計測処理を実行する
            static int measurementCount = 0;

            WPFM_status = WPFM_STATUS_MEASUREMENT;
            if (measurementCount++ < 5)
            {
				if (UTIL_checkblinkCountLED1()) {	// 起動時LED点滅中の測定はスルー
					;
				} else {
					if (WPFM_ForcedCall == false) {	// 強制発報でない
		                // 定期計測の最初の5回だけLED1を500mS点灯させる
		                UTIL_LED1_ONESHOT();
	                }
				}
            }
            WPFM_measureRegularly(false);
            WPFM_status = WPFM_STATUS_WAIT_COMMAND;

            if (WPFM_isInSendingRegularly)
            {
                SMPIF_sendRegularly();      // 定期受信を実行する
#ifdef DEBUG_ADD_LF
                APP_printlnUSB("");         // デバッグ用に改行を入れる
#endif
            }

            WPFM_doMeasure = false;
        }

        // アラート警報するかどうかチェックする(また、電池交換中は定期通信を行わない)
        if ((WPFM_doNotifies[0] || WPFM_doNotifies[1]) && ! WPFM_isBeingReplacedBattery)
        {
            // 通知処理(ダミー)を実行する
            WPFM_status = WPFM_STATUS_EMERGENCY_ALERT;
            WPFM_notifyAlert();
            WPFM_status = WPFM_STATUS_WAIT_COMMAND;
            WPFM_doNotifies[0] = WPFM_doNotifies[1] = false;
        }

        // 定期通信のタイミングかどうかチェックする(また、電池交換中は定期通信を行わない)
        if (WPFM_doCommunicate && ! WPFM_isBeingReplacedBattery)
        {
            // 次の定期通信のアラームを設定する
            WPFM_setNextCommunicateAlarm();
            // 定期通信処理(ダミー)を実行する
            WPFM_uploadRegularly();
            WPFM_doCommunicate = false;
        }

        /*
         * 条件がそろえば、スリープする。
         * ただし、電池交換中、スマホ/PCがUSBポートに接続されているとき、あるいはタクトスイッチの押下中はスリープしない
         */
        if (WPFM_isBeingReplacedBattery)
        {
            if (RTC_now - WPFM_startExchangingBatteryTime > WPFM_settingParameter.maximumBatteryExchangeTime)
            {
                // 電池交換に要する時間が長すぎる時は、一旦、電池交換モードから抜ける
                int stat;
                if ((stat = MLOG_returnToFlash()) != MLOG_ERR_NONE)
                {
                    DEBUG_UART_printlnFormat("MLOG_returnToFlash() error: %d", stat);
                }
                WPFM_isBeingReplacedBattery = false;
                WPFM_startExchangingBatteryTime = 0;
                BATTERY_turnOffExtLed();
                DEBUG_UART_printlnString("EXIT REPLACE BATTERY..");
            }
        }
        else if (WPFM_isConnectingUSB)
        {
            // USBが接続されているとき
            // Smarthone I/F processing
            int stat = 0;
            switch (WPFM_status)
            {
                case WPFM_STATUS_WAIT_COMMAND:
                    if ((stat = SMPIF_readMessage()) == SMPIF_ERR_NONE)
                    {
                        WPFM_status = WPFM_STATUS_PROCESSING_COMMAND;
                    }
                    else if (stat != SMPIF_ERR_NO_MESSAGE)
                    {
                        // stay in WPFM_STATUS_WAIT_COMMAND
                        DEBUG_UART_printlnFormat("SMPIF_readMessage() error: %d", stat);
                    }
                    break;
                case WPFM_STATUS_PROCESSING_COMMAND:
                    if ((stat = SMPIF_handleMessage()) == SMPIF_ERR_NONE)
                    {
                        WPFM_status = WPFM_STATUS_WAIT_COMMAND;
                    }
                    else
                    {
                        DEBUG_UART_printlnFormat("SMPIF_handleMessage() error: %d", stat);
                    }
                    break;
                default:
                    break;
            }
        }
        else if (WPFM_tactSwStatus != WPFM_TACTSW_STATUS_NORMAL)
        {
            // タクトスイッチの押下中なので、スリープしない
        }
       else if( DLCMatIsSleep() ){
            // USBが接続されていないとき
            WPFM_isInSendingRegularly = false;  // USBケーブルがVEなしで抜かれた時のために

            // Fall asleep if there is no work to do
            WPFM_status = WPFM_STATUS_SLEEP;
            WPFM_sleep();       // MCUをスタンバイモードにする
            putch('.');
            WPFM_status = WPFM_STATUS_IDLE;
			if( RTCReadRetry+RTCWriteRetry )
				DLCEventLogWrite( _ID1_ERROR,0x101,(RTCReadRetry<<16)|RTCWriteRetry);
        }
    } // end-of-while-loop
}
/*
*   非測定モード時のメインループ処理
*/
static void eventLoopOnNonMeasurementMode(void)
{
	DLCEventLogWrite( _ID1_MANTE_START,0,0 );
	APP_delay(20);
	SlideSwProc();
    while (true)
    {
        SYS_Tasks();
	    DLCMatMain();

        // タクトスイッチが押下されたどうかをチェックする
        if (WPFM_wasButtonPressed)
        {
            if ((SYS_tick-WPFM_lastButtonPressedTime) >=  WPFM_LONG_PRESSED_TIME ){
			    if (TEST_SW_Get()){ 	                // ボタン押されてない
	                DEBUG_UART_printlnFormat("SHORT PRESSED: %u %u", (unsigned int)WPFM_lastButtonReleasedTime, (unsigned int)WPFM_lastButtonPressedTime);
					if (WPFM_isVbatDrive == true) {	// VBAT駆動?
						DEBUG_UART_printlnString("Can not call because VBAT drive.");
					} else {	// VBAT駆動
		                WPFM_uploadOneShot(false);      // 空のデータをアップロード
					}
	            }
	            else
	            {
	                // 長押しされたとき
	                DEBUG_UART_printlnFormat("LONG PRESSED: %u %u", (unsigned int)WPFM_lastButtonReleasedTime, (unsigned int)WPFM_lastButtonPressedTime);
	                // 非測定モードの時は電池交換を許容しないので、何もしない

	                // デバッグ用
	                WDT_Disable();
	                MLOG_dump();        // FOR DEBUG! @remove
	                MLOG_checkLogs(false);
	                WDT_Enable();
	            }
	            WPFM_wasButtonPressed = false;
                WPFM_tactSwStatus = WPFM_TACTSW_STATUS_NORMAL;
			}
        }

        if (WPFM_isConnectingUSB)
        {
            if (WPFM_isInSendingRegularly)
            {
                // 1秒間隔で計測を行い、スマホアプリへ送信する
                if (WPFM_doMeasure)
                {
                    WPFM_measureRegularly(true);
                    SMPIF_sendRegularly();       // 定期受信を実行する
#ifdef DEBUG_ADD_LF
                    APP_printlnUSB("");         // デバッグ用に改行を入れる（
#endif
                    WPFM_doMeasure = false;
                }
            }

            // Smarthone I/F processing
            int stat = 0;
            switch (WPFM_status)
            {
                case WPFM_STATUS_WAIT_COMMAND:
                    if ((stat = SMPIF_readMessage()) == SMPIF_ERR_NONE)
                    {
                        WPFM_status = WPFM_STATUS_PROCESSING_COMMAND;
                    }
                    else if (stat != SMPIF_ERR_NO_MESSAGE)
                    {
                        // stay in WPFM_STATUS_WAIT_COMMAND
                        DEBUG_UART_printlnFormat("SMPIF_readMessage() error: %d", stat);
                    }
                    break;
                case WPFM_STATUS_PROCESSING_COMMAND:
                    if ((stat = SMPIF_handleMessage()) == SMPIF_ERR_NONE)
                    {
                        WPFM_status = WPFM_STATUS_WAIT_COMMAND;
                    }
                    else
                    {
                        DEBUG_UART_printlnFormat("SMPIF_handleMessage() error: %d", stat);
                    }
                    break;
                default:
                    break;
            }
        }
        else if (WPFM_tactSwStatus != WPFM_TACTSW_STATUS_NORMAL)
        {
            // タクトスイッチの押下中
        }
        else if( DLCMatIsSleep() ){
            // USBが接続されていないとき
            WPFM_isInSendingRegularly = false;  // USBケーブルがVEなしで抜かれた時のために
            // Fall asleep if there is no work to do
            WPFM_status = WPFM_STATUS_SLEEP;
            APP_delay(1);
            WPFM_sleep();       // MCUをスタンバイモードにする
            APP_delay(1);
            putch(',');
            WPFM_status = WPFM_STATUS_IDLE;
        }
    }
}

/*******************************************************************************
 End of File
*/
