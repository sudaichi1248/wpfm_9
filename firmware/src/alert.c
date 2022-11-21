/*
 * File:    alert.c
 * Author:  Interark Corp.
 * Summary: WPFM(code name "DLC_04") project alert handling file.
 * Date:    2022/08/12 (R0)
 *          2022/09/07 (R0.1) handle alertEnableKinds
 * Note:
 */

#define DEBUG_UART                   // Debug with UART
#define DEBUG_DETAIL

#include "wpfm.h"
#include "util.h"
#include "debug.h"
#include "mlog.h"
#include "sensor.h"
#include "moni.h"
#include "Eventlog.h"
#ifdef ADD_FUNCTION
void DLCMatAlertTimeClr();
#endif
uint8_t WPFM_suppressAlert(uint8_t chabgealert, bool changefirst, bool sw);

#ifdef DEBUG_DETAIL
#   define  DBG_PRINT(...)  { char _line[80]; snprintf(_line, sizeof(_line),  __VA_ARGS__); UART_DEBUG_writeBytes(_line, strlen(_line)); UART_DEBUG_writeBytes("\n", 1); APP_delay(3); }
#else
#   define  DBG_PRINT()
#endif

/*
*   Local variables and functions
*/


uint8_t WPFM_judegAlert(uint32_t occurrenceTime)
{
    // 各チャネルの上限、下限をチェックする
    bool hasCommunicationIntervalChanged = false;       // 定期通信間隔が変更されたか？
    uint8_t alertStatus = WPFM_lastAlertStatus;
    uint8_t upperWarning = 0, upperAttention = 0, lowerWarning = 0, lowerAttention = 0;
	bool ChangeFirst = false;
    for (int channelIndex = 0; channelIndex < 2; channelIndex++)
    {
        if (WPFM_settingParameter.sensorKinds[channelIndex] == SENSOR_KIND_NOT_PRESENT)
        {
            continue;   // 未使用のセンサはスキップする
        }

#ifdef ADD_FUNCTION
        if (WPFM_isAlertPause == true)
        {
            putst("Alert Pause(");puthxb(channelIndex+1);putst(")\r\n");
            continue;   // AlertPause中はスキップする
        }
#endif

        switch (channelIndex)
        {
            case 0:
                upperWarning = MLOG_ALERT_STATUS_CH1_UPPER_WARNING;
                upperAttention = MLOG_ALERT_STATUS_CH1_UPPER_ATTENTION;
                lowerWarning = MLOG_ALERT_STATUS_CH1_LOWER_WARNING;
                lowerAttention = MLOG_ALERT_STATUS_CH1_LOWER_ATTENTION;
                break;
            case 1:
                upperWarning = MLOG_ALERT_STATUS_CH2_UPPER_WARNING;
                upperAttention = MLOG_ALERT_STATUS_CH2_UPPER_ATTENTION;
                lowerWarning = MLOG_ALERT_STATUS_CH2_LOWER_WARNING;
                lowerAttention = MLOG_ALERT_STATUS_CH2_LOWER_ATTENTION;
                break;
        }

        // (1) 上限のチェック
        if ((WPFM_lastAlertStatus & (0x0F << (channelIndex * 4))) == upperWarning)
        {
            //- 前回は、警報状態にあった場合
            if (WPFM_lastMeasuredValues[channelIndex] > WPFM_settingParameter.alertUpperLimits[channelIndex][1])
            {
                DBG_PRINT("[ALERT(%d)] U1-1: %.3f>%.3f", channelIndex+1, WPFM_lastMeasuredValues[channelIndex], WPFM_settingParameter.alertUpperLimits[channelIndex][1]);
                //- 上限2を超えたので、アラート状態はそのままとする
            }
            else if (WPFM_lastMeasuredValues[channelIndex] > WPFM_settingParameter.alertUpperLimits[channelIndex][0])
            {
                DBG_PRINT("[ALERT(%d)] U1-2: %.3f>%.3f", channelIndex+1, WPFM_lastMeasuredValues[channelIndex], WPFM_settingParameter.alertUpperLimits[channelIndex][0]);
                //- 上限1を超えたので、アラート状態は注意状態へ遷移する
                alertStatus &= ~upperWarning;
                alertStatus |= upperAttention;
				DLCEventLogWrite( _ID1_ALERT1,alertStatus,0 );
#ifdef ADD_FUNCTION
				if (WPFM_settingParameter.alertChatteringKind == 1) {	// チャタリングタイプ1
#endif
					if (WPFM_settingParameter.alertEnableKinds[channelIndex][0][0] == WPFM_ALERT_KIND_ENABLED) {
						WPFM_TxType = 11;
					}
	                WPFM_lastAlertStartTimes[channelIndex][0] = occurrenceTime;
#ifdef ADD_FUNCTION
				} else {	// チャタリングタイプ2
					WPFM_lastAlertStartTimes2[channelIndex][1] = 0;	// 限界2のチャタリング時間ストップ
				}
#endif
            }
            else
            {
                DBG_PRINT("[ALERT(%d)] U1-3: %.3f", channelIndex+1, WPFM_lastMeasuredValues[channelIndex]);
                //- 上限1未満に収まっているので、アラート状態は通常に遷移する
                alertStatus &= ~upperWarning;
#ifdef ADD_FUNCTION
				if (WPFM_settingParameter.alertChatteringKind == 2) {	// チャタリングタイプ2
					WPFM_lastAlertStartTimes2[channelIndex][1] = 0;	// 限界2のチャタリング時間ストップ
				}
#endif
            }
        }
        else if ((WPFM_lastAlertStatus & (0x0F << (channelIndex * 4))) == upperAttention)
        {
            //- 前回は、注意状態にあった場合
            if (WPFM_lastMeasuredValues[channelIndex] > WPFM_settingParameter.alertUpperLimits[channelIndex][1])
            {
                DBG_PRINT("[ALERT(%d)] U2-1: %.3f>%.3f", channelIndex+1, WPFM_lastMeasuredValues[channelIndex], WPFM_settingParameter.alertUpperLimits[channelIndex][1]);
                //- 上限2を超えたので、アラート状態は警報状態へ遷移する
                alertStatus &= ~upperAttention;
                alertStatus |= upperWarning;
#ifdef ADD_FUNCTION
				if (WPFM_settingParameter.alertChatteringKind == 1) {	// チャタリングタイプ1
#endif
	                WPFM_lastAlertStartTimes[channelIndex][0] = occurrenceTime;
	                if (WPFM_settingParameter.alertEnableKinds[channelIndex][0][1] == WPFM_ALERT_KIND_ENABLED)
	                {
	                    SENSOR_updateMeasurementInterval(WPFM_settingParameter.measurementIntervalOnAlert);
	                    WPFM_updateCommunicationInterval(WPFM_settingParameter.communicationIntervalOnAlert);
						WPFM_InAlert = true;
						WPFM_TxType = 12;
	                    WPFM_doNotifies[channelIndex] = true;
	                    hasCommunicationIntervalChanged = true;
	                }
#ifdef ADD_FUNCTION
				} else {	// チャタリングタイプ2
					WPFM_lastAlertStartTimes2[channelIndex][1] = occurrenceTime;	// 限界2のチャタリング時間スタート
				}
#endif
            }
            else if (WPFM_lastMeasuredValues[channelIndex] > WPFM_settingParameter.alertUpperLimits[channelIndex][0])
            {
                DBG_PRINT("[ALERT(%d)] U2-2: %.3f>%.3f", channelIndex+1, WPFM_lastMeasuredValues[channelIndex], WPFM_settingParameter.alertUpperLimits[channelIndex][0]);
                //- 上限1を超えたので、アラート状態はそのままとする
            }
            else
            {
                DBG_PRINT("[ALERT(%d)] U2-3: %.3f", channelIndex+1, WPFM_lastMeasuredValues[channelIndex]);
                //- 上限1未満に収まっているので、アラート状態は通常に遷移する
                alertStatus &= ~upperAttention;
#ifdef ADD_FUNCTION
				if (WPFM_settingParameter.alertChatteringKind == 2) {	// チャタリングタイプ2
					WPFM_lastAlertStartTimes2[channelIndex][0] = 0;	// 限界1のチャタリング時間ストップ
				}
#endif
            }
        }
        else
        {
            //- 前回は、通常状態であった場合
            if (WPFM_lastMeasuredValues[channelIndex] > WPFM_settingParameter.alertUpperLimits[channelIndex][1])
            {
                DBG_PRINT("[ALERT(%d)] U3-1: %.3f>%.3f", channelIndex+1, WPFM_lastMeasuredValues[channelIndex], WPFM_settingParameter.alertUpperLimits[channelIndex][1]);
                //- 上限2を超えたので、アラート状態は警報状態へ遷移する
                alertStatus |= upperWarning;
#ifdef ADD_FUNCTION
				if (WPFM_settingParameter.alertChatteringKind == 1) {	// チャタリングタイプ1
#endif
	                WPFM_lastAlertStartTimes[channelIndex][0] = occurrenceTime;
	                if (WPFM_settingParameter.alertEnableKinds[channelIndex][0][1] == WPFM_ALERT_KIND_ENABLED)
	                {
	                    SENSOR_updateMeasurementInterval(WPFM_settingParameter.measurementIntervalOnAlert);
	                    WPFM_updateCommunicationInterval(WPFM_settingParameter.communicationIntervalOnAlert);
						WPFM_InAlert = true;
						WPFM_TxType = 12;
	                    WPFM_doNotifies[channelIndex] = true;
	                    hasCommunicationIntervalChanged = true;
	                }
#ifdef ADD_FUNCTION
				} else {	// チャタリングタイプ2
					WPFM_lastAlertStartTimes2[channelIndex][1] = occurrenceTime;	// 限界2のチャタリング時間スタート
				}
#endif
            }
            else if (WPFM_lastMeasuredValues[channelIndex] > WPFM_settingParameter.alertUpperLimits[channelIndex][0])
            {
                DBG_PRINT("[ALERT(%d)] U3-2: %.3f>%.3f", channelIndex+1, WPFM_lastMeasuredValues[channelIndex], WPFM_settingParameter.alertUpperLimits[channelIndex][0]);
                //- 上限1を超えたので、アラート状態は注意状態へ遷移する
                alertStatus |= upperAttention;
#ifdef ADD_FUNCTION
				if (WPFM_settingParameter.alertChatteringKind == 1) {	// チャタリングタイプ1
#endif
					if (WPFM_settingParameter.alertEnableKinds[channelIndex][0][0] == WPFM_ALERT_KIND_ENABLED) {
						WPFM_TxType = 11;
					}
	                WPFM_lastAlertStartTimes[channelIndex][0] = occurrenceTime;
#ifdef ADD_FUNCTION
				} else {	// チャタリングタイプ2
					WPFM_lastAlertStartTimes2[channelIndex][0] = occurrenceTime;	// 限界1のチャタリング時間スタート
				}
#endif
            }
            else
            {
                DBG_PRINT("[ALERT(%d)] U3-3: %.3f", channelIndex+1, WPFM_lastMeasuredValues[channelIndex]);
                //- 上限1未満に収まっているので、アラート状態はそのままとする
            }
        }

        // (2) 下限のチェック
        if ((WPFM_lastAlertStatus & (0x0F << (channelIndex * 4))) == lowerWarning)
        {
            //- 前回は、警報状態にあった場合
            if (WPFM_lastMeasuredValues[channelIndex] < WPFM_settingParameter.alertLowerLimits[channelIndex][1])
            {
                //- 下限2を下回ったので、アラート状態はそのままとする
                DBG_PRINT("[ALERT(%d)] L1-1: %.3f<%.3f", channelIndex+1, WPFM_lastMeasuredValues[channelIndex], WPFM_settingParameter.alertLowerLimits[channelIndex][1]);
            }
            else if (WPFM_lastMeasuredValues[channelIndex] < WPFM_settingParameter.alertLowerLimits[channelIndex][0])
            {
                DBG_PRINT("[ALERT(%d)] L1-2: %.3f<%.3f", channelIndex+1, WPFM_lastMeasuredValues[channelIndex], WPFM_settingParameter.alertLowerLimits[channelIndex][0]);
                //- 下限1を下回ったので、アラート状態は注意状態へ遷移する
                alertStatus &= ~lowerWarning;
                alertStatus |= lowerAttention;
#ifdef ADD_FUNCTION
				if (WPFM_settingParameter.alertChatteringKind == 1) {	// チャタリングタイプ1
#endif
					if (WPFM_settingParameter.alertEnableKinds[channelIndex][1][0] == WPFM_ALERT_KIND_ENABLED) {
						WPFM_TxType = 11;
					}
	                WPFM_lastAlertStartTimes[channelIndex][1] = occurrenceTime;
#ifdef ADD_FUNCTION
				} else {	// チャタリングタイプ2
					WPFM_lastAlertStartTimes2[channelIndex][1] = 0;	// 限界2のチャタリング時間ストップ
				}
#endif
            }
            else
            {
                DBG_PRINT("[ALERT(%d)] L1-3: %.3f", channelIndex+1, WPFM_lastMeasuredValues[channelIndex]);
                //- 下限1以上に収まっているので、アラート状態は通常に遷移する
                alertStatus &= ~lowerWarning;
#ifdef ADD_FUNCTION
				if (WPFM_settingParameter.alertChatteringKind == 2) {	// チャタリングタイプ2
					WPFM_lastAlertStartTimes2[channelIndex][1] = 0;	// 限界2のチャタリング時間ストップ
				}
#endif
            }
        }
        else if ((WPFM_lastAlertStatus & (0x0F << (channelIndex * 4))) == lowerAttention)
        {
            //- 前回は、注意状態にあった場合
            if (WPFM_lastMeasuredValues[channelIndex] < WPFM_settingParameter.alertLowerLimits[channelIndex][1])
            {
                DBG_PRINT("[ALERT(%d)] L2-1: %.3f<%.3f", channelIndex+1, WPFM_lastMeasuredValues[channelIndex], WPFM_settingParameter.alertLowerLimits[channelIndex][1]);
                //- 下限2を下回ったので、アラート状態は警報状態へ遷移する
                alertStatus &= ~lowerAttention;
                alertStatus |= lowerWarning;
#ifdef ADD_FUNCTION
				if (WPFM_settingParameter.alertChatteringKind == 1) {	// チャタリングタイプ1
#endif
	                WPFM_lastAlertStartTimes[channelIndex][1] = occurrenceTime;
	                if (WPFM_settingParameter.alertEnableKinds[channelIndex][1][1] == WPFM_ALERT_KIND_ENABLED)
	                {
	                    SENSOR_updateMeasurementInterval(WPFM_settingParameter.measurementIntervalOnAlert);
	                    WPFM_updateCommunicationInterval(WPFM_settingParameter.communicationIntervalOnAlert);
						WPFM_InAlert = true;
						WPFM_TxType = 12;
	                    WPFM_doNotifies[channelIndex] = true;
	                    hasCommunicationIntervalChanged = true;
	                }
#ifdef ADD_FUNCTION
				} else {	// チャタリングタイプ2
					WPFM_lastAlertStartTimes2[channelIndex][1] = occurrenceTime;	// 限界2のチャタリング時間スタート
				}
#endif
            }
            else if (WPFM_lastMeasuredValues[channelIndex] < WPFM_settingParameter.alertLowerLimits[channelIndex][0])
            {
                //- 下限1を下回ったので、アラート状態はそのままとする
                DBG_PRINT("[ALERT(%d)] L2-2: %.3f<%.3f", channelIndex+1, WPFM_lastMeasuredValues[channelIndex], WPFM_settingParameter.alertLowerLimits[channelIndex][0]);
            }
            else
            {
                DBG_PRINT("[ALERT(%d)] L2-3: %.3f", channelIndex+1, WPFM_lastMeasuredValues[channelIndex]);
                //- 下限1以上に収まっているので、アラート状態は通常に遷移する
                alertStatus &= ~lowerAttention;
#ifdef ADD_FUNCTION
				if (WPFM_settingParameter.alertChatteringKind == 2) {	// チャタリングタイプ2
					WPFM_lastAlertStartTimes2[channelIndex][0] = 0;	// 限界1のチャタリング時間ストップ
				}
#endif
            }
        }
        else
        {
            //- 前回は、通常状態であった場合
            if (WPFM_lastMeasuredValues[channelIndex] < WPFM_settingParameter.alertLowerLimits[channelIndex][1])
            {
                DBG_PRINT("[ALERT(%d)] L3-1: %.3f<%.3f", channelIndex+1, WPFM_lastMeasuredValues[channelIndex], WPFM_settingParameter.alertLowerLimits[channelIndex][1]);
                //- 下限2を超えたので、アラート状態は警報状態へ遷移する
                alertStatus |= lowerWarning;
#ifdef ADD_FUNCTION
				if (WPFM_settingParameter.alertChatteringKind == 1) {	// チャタリングタイプ1
#endif
	                WPFM_lastAlertStartTimes[channelIndex][1] = occurrenceTime;
	                if (WPFM_settingParameter.alertEnableKinds[channelIndex][1][1] == WPFM_ALERT_KIND_ENABLED)
	                {
	                    SENSOR_updateMeasurementInterval(WPFM_settingParameter.measurementIntervalOnAlert);
	                    WPFM_updateCommunicationInterval(WPFM_settingParameter.communicationIntervalOnAlert);
						WPFM_InAlert = true;
						WPFM_TxType = 12;
	                    WPFM_doNotifies[channelIndex] = true;
	                    hasCommunicationIntervalChanged = true;
	                }
#ifdef ADD_FUNCTION
				} else {	// チャタリングタイプ2
					WPFM_lastAlertStartTimes2[channelIndex][1] = occurrenceTime;	// 限界2のチャタリング時間スタート
				}
#endif
            }
            else if (WPFM_lastMeasuredValues[channelIndex] < WPFM_settingParameter.alertLowerLimits[channelIndex][0])
            {
                DBG_PRINT("[ALERT(%d)] L3-2: %.3f<%.3f", channelIndex+1, WPFM_lastMeasuredValues[channelIndex], WPFM_settingParameter.alertLowerLimits[channelIndex][0]);
                //- 下限1を超えたので、アラート状態は注意状態へ遷移する
                alertStatus |= lowerAttention;
#ifdef ADD_FUNCTION
				if (WPFM_settingParameter.alertChatteringKind == 1) {	// チャタリングタイプ1
#endif
					if (WPFM_settingParameter.alertEnableKinds[channelIndex][1][0] == WPFM_ALERT_KIND_ENABLED) {
						WPFM_TxType = 11;
					}
	                WPFM_lastAlertStartTimes[channelIndex][1] = occurrenceTime;
#ifdef ADD_FUNCTION
				} else {	// チャタリングタイプ2
					WPFM_lastAlertStartTimes2[channelIndex][0] = occurrenceTime;	// 限界1のチャタリング時間スタート
				}
#endif
            }
            else
            {
                DBG_PRINT("[ALERT(%d)] L3-3: %.3f", channelIndex+1, WPFM_lastMeasuredValues[channelIndex]);
                //- 下限1未満に収まっているので、アラート状態はそのままとする
            }
        }
    }

#ifdef ADD_FUNCTION
	if (WPFM_settingParameter.alertChatteringKind == 1) {	// チャタリングタイプ1
#endif
	    // 必要に応じて、次回の定期通信のアラームを変更する
	    if (hasCommunicationIntervalChanged)
	    {
	        DBG_PRINT("[ALERT_T1] Change next comminication alarm.");
//	        WPFM_setNextCommunicateAlarm();
	    }
#ifdef ADD_FUNCTION
	}
#endif

//putst("1.alertStatus:");puthxb(alertStatus);putcrlf();
		alertStatus = WPFM_suppressAlert(alertStatus, ChangeFirst, true);	// alertStatus抑制
putst("2.alertStatus:");puthxb(alertStatus);putcrlf();

    // Suppress alerts during chattering time (pretend it didn't happen)
    uint8_t alertStatusSuppressed = alertStatus;
    if (WPFM_doNotifies[0] || WPFM_doNotifies[1])
    {
        DBG_PRINT("[ALERT] Do not supress alerts: %d/%d", WPFM_doNotifies[0], WPFM_doNotifies[1]);
        ;   // Do not suppress when notifying
    }
    else
    {
#ifdef ADD_FUNCTION
		if (WPFM_settingParameter.alertChatteringKind == 1) {	// チャタリングタイプ1
#endif
	        for (int channelIndex = 0; channelIndex < 2; channelIndex++)
	        {
	            if (WPFM_settingParameter.sensorKinds[channelIndex] == SENSOR_KIND_NOT_PRESENT)
	            {
	                continue;   // Skip unused sensor
	            }

	            // Check upper-side
	            if (WPFM_lastAlertStartTimes[channelIndex][0] > 0)
	            {
	                if (((alertStatus & (0x0F << (channelIndex * 4))) == upperAttention) && ((WPFM_lastAlertStatus & (0x0F << (channelIndex * 4))) != upperAttention))
	                {
	                    DBG_PRINT("[ALERT_T1(%d)] Not Suppress upper attention: %lu", channelIndex+1, WPFM_lastAlertStartTimes[channelIndex][0]);
						ChangeFirst = true;
	                }
	                else if (occurrenceTime < (WPFM_lastAlertStartTimes[channelIndex][0] + WPFM_settingParameter.alertChatteringTimes[channelIndex]))
	                {
#ifdef ADD_FUNCTION
	                    DBG_PRINT("[ALERT_T1(%d)] Not Suppress upper attention/warning(ChatteringKind 2): %lu<%lu", channelIndex+1, occurrenceTime, (WPFM_lastAlertStartTimes[channelIndex][0]+WPFM_settingParameter.alertChatteringTimes[channelIndex]));
#else
	                    DBG_PRINT("[ALERT_T1(%d)] Suppress upper attention/warning: %lu<%lu", channelIndex+1, occurrenceTime, (WPFM_lastAlertStartTimes[channelIndex][0]+WPFM_settingParameter.alertChatteringTimes[channelIndex]));
	                    // Suppress upper limit alert
	                    alertStatusSuppressed &= ~(upperWarning | upperAttention);
#endif
	                }
	                else
	                {
	                    // Time out
	                    DBG_PRINT("[ALERT_T1(%d)] Not suppress upper attention/warning: %lu->%lu", channelIndex+1, WPFM_lastAlertStartTimes[channelIndex][0], (WPFM_lastAlertStartTimes[channelIndex][0]+WPFM_settingParameter.alertChatteringTimes[channelIndex]));
	                    WPFM_lastAlertStartTimes[channelIndex][0] += WPFM_settingParameter.alertChatteringTimes[channelIndex];  // Extend chattering time
	                    if ((alertStatus & (0x0F << (channelIndex * 4))) == upperWarning)
	                    {
	                        WPFM_doNotifies[channelIndex] = true;
	                    }
	                }
	            }

	            // Check lower -side
	            if (WPFM_lastAlertStartTimes[channelIndex][1] > 0)
	            {
	                if (((alertStatus & (0x0F << (channelIndex * 4))) == lowerAttention) && ((WPFM_lastAlertStatus & (0x0F << (channelIndex * 4))) != lowerAttention))
	                {
	                    DBG_PRINT("[ALERT_T1(%d)] Not Suppress lower attention: %lu", channelIndex+1, WPFM_lastAlertStartTimes[channelIndex][1]);
						ChangeFirst = true;
	                }
	                else if (occurrenceTime < (WPFM_lastAlertStartTimes[channelIndex][1] + WPFM_settingParameter.alertChatteringTimes[channelIndex]))
	                {
#ifdef ADD_FUNCTION
	                    DBG_PRINT("[ALERT_T1(%d)] Not Suppress lower attention/warning(ChatteringKind 2): %lu<%lu", channelIndex+1, occurrenceTime, (WPFM_lastAlertStartTimes[channelIndex][1]+WPFM_settingParameter.alertChatteringTimes[channelIndex]));
#else
	                    DBG_PRINT("[ALERT_T1(%d)] Suppress lower attention/warning: %lu<%lu", channelIndex+1, occurrenceTime, (WPFM_lastAlertStartTimes[channelIndex][1]+WPFM_settingParameter.alertChatteringTimes[channelIndex]));
	                    // Suppress lower limit alert
	                    alertStatusSuppressed &= ~(lowerWarning | lowerAttention);
#endif
	                }
	                else
	                {
	                    // Time out
	                    DBG_PRINT("[ALERT_T1(%d)] Not suppress lower attention/warning: %lu->%lu", channelIndex+1, WPFM_lastAlertStartTimes[channelIndex][1], (WPFM_lastAlertStartTimes[channelIndex][1]+WPFM_settingParameter.alertChatteringTimes[channelIndex]));
	                    WPFM_lastAlertStartTimes[channelIndex][1] += WPFM_settingParameter.alertChatteringTimes[channelIndex];  // Extend chattering time
	                    if ((alertStatus & (0x0F << (channelIndex * 4))) == lowerWarning)
	                    {
	                        WPFM_doNotifies[channelIndex] = true;
	                    }
	                }
	            }
	        }
#ifdef ADD_FUNCTION
		} else {	// チャタリングタイプ2
			for (int channelIndex = 0; channelIndex < 2; channelIndex++)
			{
				if (WPFM_settingParameter.sensorKinds[channelIndex] == SENSOR_KIND_NOT_PRESENT)
				{
					continue;   // Skip unused sensor
				}

				// Check limit2
				if (WPFM_lastAlertStartTimes2[channelIndex][1] > 0)
				{
					if (occurrenceTime >= (WPFM_lastAlertStartTimes2[channelIndex][1] + WPFM_settingParameter.alertChatteringTimes[channelIndex]))
					{
						// Time out
						DBG_PRINT("[ALERT_T2(%d)] Not suppress upper/lower warning: %lu->%lu", channelIndex+1, WPFM_lastAlertStartTimes2[channelIndex][1], (WPFM_lastAlertStartTimes2[channelIndex][1]+WPFM_settingParameter.alertChatteringTimes[channelIndex]));
						WPFM_lastAlertStartTimes2[channelIndex][1] = 0;
						SENSOR_updateMeasurementInterval(WPFM_settingParameter.measurementIntervalOnAlert);
						WPFM_updateCommunicationInterval(WPFM_settingParameter.communicationIntervalOnAlert);
						WPFM_InAlert = true;
						WPFM_TxType = 12;
						hasCommunicationIntervalChanged = true;	// 警報状態へ遷移
						WPFM_doNotifies[channelIndex] = true;
					}
				}

				// Check limit1
				if (WPFM_lastAlertStartTimes2[channelIndex][0] > 0)
				{
					if (occurrenceTime >= (WPFM_lastAlertStartTimes2[channelIndex][0] + WPFM_settingParameter.alertChatteringTimes[channelIndex]))
					{
						// Time out
						DBG_PRINT("[ALERT_T2(%d)] Not suppress upper/lower attention: %lu->%lu", channelIndex+1, WPFM_lastAlertStartTimes2[channelIndex][0], (WPFM_lastAlertStartTimes2[channelIndex][0]+WPFM_settingParameter.alertChatteringTimes[channelIndex]));
						WPFM_lastAlertStartTimes2[channelIndex][0] = 0;
						WPFM_TxType = 11;
					}
				}
			}
			// 必要に応じて、次回の定期通信のアラームを変更する
			if (hasCommunicationIntervalChanged)
			{
				DBG_PRINT("[ALERT_T2] Change next comminication alarm.");
//			    WPFM_setNextCommunicateAlarm();
			}
		}
#endif
    }

//putst("1.alertStatusSuppressed:");puthxb(alertStatusSuppressed);putcrlf();
	alertStatusSuppressed = WPFM_suppressAlert(alertStatusSuppressed, ChangeFirst, false);	// alertStatusSuppressed抑制
putst("2.alertStatusSuppressed:");puthxb(alertStatusSuppressed);putcrlf();

    WPFM_lastAlertStatusSuppressed = alertStatusSuppressed;

    return (alertStatus);       // return real(no-suppressed) alert status
}

uint8_t WPFM_suppressAlert(uint8_t changealert, bool changefirst, bool sw)
{
    // Suppress CH1 alert and nitification according to disable specification
	if (sw == true) {	// alertStatus
	    WPFM_ALERT_KIND enableKind = WPFM_settingParameter.alertEnableKinds[0][0][1];
	    if (enableKind == WPFM_ALERT_KIND_DISABLED || enableKind == WPFM_ALERT_KIND_PAUSED)	// 上限2がdisable
	    {
			enableKind = WPFM_settingParameter.alertEnableKinds[0][0][0];
			if (enableKind == WPFM_ALERT_KIND_ENABLED) {	// 上限1がenable
				if ((changealert & 0x0F) == MLOG_ALERT_STATUS_CH1_UPPER_WARNING) {	// alertStatus=警報
					changealert &= ~MLOG_ALERT_STATUS_CH1_UPPER_WARNING;	// 注意に変更
					changealert |= MLOG_ALERT_STATUS_CH1_UPPER_ATTENTION;
				}
			} else {
				if ((changealert & 0x0F) <= MLOG_ALERT_STATUS_CH1_UPPER_ATTENTION) {	// 上限1超え
					changealert &= MLOG_ALERT_STATUS_CH1_NORMAL | 0xF0;	// 通常に変更
				}
			}
	    }
	    enableKind = WPFM_settingParameter.alertEnableKinds[0][0][0];
	    if (enableKind == WPFM_ALERT_KIND_DISABLED || enableKind == WPFM_ALERT_KIND_PAUSED)	// 上限1がdisable
	    {
			if ((changealert & 0x0F) == MLOG_ALERT_STATUS_CH1_UPPER_ATTENTION) {	// 上限1
				changealert &= MLOG_ALERT_STATUS_CH1_NORMAL | 0xF0;	// 通常に変更
			}
		}
	    enableKind = WPFM_settingParameter.alertEnableKinds[0][1][1];
	    if (enableKind == WPFM_ALERT_KIND_DISABLED || enableKind == WPFM_ALERT_KIND_PAUSED)	// 下限2がdisable
	    {
			enableKind = WPFM_settingParameter.alertEnableKinds[0][1][0];
			if (enableKind == WPFM_ALERT_KIND_ENABLED) {	// 下限1がenable
				if ((changealert & 0x0F) == MLOG_ALERT_STATUS_CH1_LOWER_WARNING) {	// alertStatus=警報
					changealert &= ~MLOG_ALERT_STATUS_CH1_LOWER_WARNING;	// 注意に変更
					changealert |= MLOG_ALERT_STATUS_CH1_LOWER_ATTENTION;
				}
			} else {
				if ((changealert & 0x0F) >= MLOG_ALERT_STATUS_CH1_LOWER_ATTENTION) {	// 下限1超え
					changealert &= MLOG_ALERT_STATUS_CH1_NORMAL | 0xF0;	// 通常に変更
				}
			}
	    }
	    enableKind = WPFM_settingParameter.alertEnableKinds[0][1][0];
	    if (enableKind == WPFM_ALERT_KIND_DISABLED || enableKind == WPFM_ALERT_KIND_PAUSED)
	    {
			if ((changealert & 0x0F) == MLOG_ALERT_STATUS_CH1_LOWER_ATTENTION) {	// 下限1
				changealert &= MLOG_ALERT_STATUS_CH1_NORMAL | 0xF0;	// 通常に変更
			}
		}

	    // Suppress CH2 alert and nitification according to disable specification
	    enableKind = WPFM_settingParameter.alertEnableKinds[1][0][1];
	    if (enableKind == WPFM_ALERT_KIND_DISABLED || enableKind == WPFM_ALERT_KIND_PAUSED)	// 上限2がdisable
	    {
			enableKind = WPFM_settingParameter.alertEnableKinds[1][0][0];
			if (enableKind == WPFM_ALERT_KIND_ENABLED) {	// 上限1がenable
				if ((changealert & 0xF0) == MLOG_ALERT_STATUS_CH2_UPPER_WARNING) {	// alertStatus=警報
					changealert &= ~MLOG_ALERT_STATUS_CH2_UPPER_WARNING;	// 注意に変更
					changealert |= MLOG_ALERT_STATUS_CH2_UPPER_ATTENTION;
				}
			} else {
				if ((changealert & 0xF0) <= MLOG_ALERT_STATUS_CH2_UPPER_ATTENTION) {	// 上限1超え
					changealert &= MLOG_ALERT_STATUS_CH2_NORMAL | 0x0F;	// 通常に変更
				}
			}
	    }
	    enableKind = WPFM_settingParameter.alertEnableKinds[1][0][0];
	    if (enableKind == WPFM_ALERT_KIND_DISABLED || enableKind == WPFM_ALERT_KIND_PAUSED)	// 上限1がdisable
	    {
			if ((changealert & 0xF0) == MLOG_ALERT_STATUS_CH2_UPPER_ATTENTION) {	// 上限1
				changealert &= MLOG_ALERT_STATUS_CH2_NORMAL | 0x0F;	// 通常に変更
			}
		}
	    enableKind = WPFM_settingParameter.alertEnableKinds[1][1][1];
	    if (enableKind == WPFM_ALERT_KIND_DISABLED || enableKind == WPFM_ALERT_KIND_PAUSED)	// 下限2がdisable
	    {
			enableKind = WPFM_settingParameter.alertEnableKinds[1][1][0];
			if (enableKind == WPFM_ALERT_KIND_ENABLED) {	// 下限1がenable
				if ((changealert & 0xF0) == MLOG_ALERT_STATUS_CH2_LOWER_WARNING) {	// alertStatus=警報
					changealert &= ~MLOG_ALERT_STATUS_CH2_LOWER_WARNING;	// 注意に変更
					changealert |= MLOG_ALERT_STATUS_CH2_LOWER_ATTENTION;
				}
			} else {
				if ((changealert & 0xF0) >= MLOG_ALERT_STATUS_CH2_LOWER_ATTENTION) {	// 下限1超え
					changealert &= MLOG_ALERT_STATUS_CH2_NORMAL | 0x0F;	// 通常に変更
				}
			}
	    }
	    enableKind = WPFM_settingParameter.alertEnableKinds[1][1][0];
	    if (enableKind == WPFM_ALERT_KIND_DISABLED || enableKind == WPFM_ALERT_KIND_PAUSED)
	    {
			if ((changealert & 0xF0) == MLOG_ALERT_STATUS_CH2_LOWER_ATTENTION) {	// 下限1
				changealert &= MLOG_ALERT_STATUS_CH2_NORMAL | 0x0F;	// 通常に変更
			}
		}
	} else {	// alertStatusSuppressed
	    // Suppress CH1 alert and nitification according to disable specification
	    WPFM_ALERT_KIND enableKind = WPFM_settingParameter.alertEnableKinds[0][0][0];
	    if (enableKind == WPFM_ALERT_KIND_DISABLED || enableKind == WPFM_ALERT_KIND_PAUSED)
	    {
			if ((changealert & 0x0F) == MLOG_ALERT_STATUS_CH1_UPPER_ATTENTION) {	// 上限1
				changealert &= MLOG_ALERT_STATUS_CH1_NORMAL | 0xF0;
			}
	    }
	    enableKind = WPFM_settingParameter.alertEnableKinds[0][0][1];
	    if (enableKind == WPFM_ALERT_KIND_DISABLED || enableKind == WPFM_ALERT_KIND_PAUSED)
	    {
			if ((changealert & 0x0F) == MLOG_ALERT_STATUS_CH1_UPPER_WARNING) {
				changealert &= MLOG_ALERT_STATUS_CH1_NORMAL | 0xF0;
				if (enableKind == WPFM_ALERT_KIND_DISABLED) {
					enableKind = WPFM_settingParameter.alertEnableKinds[0][0][0];
					if (enableKind == WPFM_ALERT_KIND_ENABLED) {	// 上限1がenableなら
						if (changefirst == true) {	// 初回変化の場合
							changealert |= MLOG_ALERT_STATUS_CH1_UPPER_ATTENTION;
						}
					}
				}
		        WPFM_doNotifies[0] = false;
			}
	    }
	    enableKind = WPFM_settingParameter.alertEnableKinds[0][1][0];
	    if (enableKind == WPFM_ALERT_KIND_DISABLED || enableKind == WPFM_ALERT_KIND_PAUSED)
	    {
			if ((changealert & 0x0F) == MLOG_ALERT_STATUS_CH1_LOWER_ATTENTION) {	// 下限1
				changealert &= MLOG_ALERT_STATUS_CH1_NORMAL | 0xF0;
			}
	    }
	    enableKind = WPFM_settingParameter.alertEnableKinds[0][1][1];
	    if (enableKind == WPFM_ALERT_KIND_DISABLED || enableKind == WPFM_ALERT_KIND_PAUSED)
	    {
			if ((changealert & 0x0F) == MLOG_ALERT_STATUS_CH1_LOWER_WARNING) {
				changealert &= MLOG_ALERT_STATUS_CH1_NORMAL | 0xF0;
				if (enableKind == WPFM_ALERT_KIND_DISABLED) {
					enableKind = WPFM_settingParameter.alertEnableKinds[0][1][0];
					if (enableKind == WPFM_ALERT_KIND_ENABLED) {	// 下限1がenableなら
						if (changefirst == true) {	// 初回変化の場合
							changealert |= MLOG_ALERT_STATUS_CH1_LOWER_ATTENTION;
						}
					}
				}
		        WPFM_doNotifies[0] = false;
			}
	    }

	    // Suppress CH2 alert and nitification according to disable specification
	    enableKind = WPFM_settingParameter.alertEnableKinds[1][0][0];
	    if (enableKind == WPFM_ALERT_KIND_DISABLED || enableKind == WPFM_ALERT_KIND_PAUSED)
	    {
			if ((changealert & 0xF0) == MLOG_ALERT_STATUS_CH2_UPPER_ATTENTION) {	// 上限1
				changealert &= MLOG_ALERT_STATUS_CH2_NORMAL | 0x0F;
			}
	    }
	    enableKind = WPFM_settingParameter.alertEnableKinds[1][0][1];
	    if (enableKind == WPFM_ALERT_KIND_DISABLED || enableKind == WPFM_ALERT_KIND_PAUSED)
	    {
			if ((changealert & 0xF0) == MLOG_ALERT_STATUS_CH2_UPPER_WARNING) {
				changealert &= MLOG_ALERT_STATUS_CH2_NORMAL | 0x0F;
				if (enableKind == WPFM_ALERT_KIND_DISABLED) {
					enableKind = WPFM_settingParameter.alertEnableKinds[1][0][0];
					if (enableKind == WPFM_ALERT_KIND_ENABLED) {	// 上限1がenableなら
						if (changefirst == true) {	// 初回変化の場合
							changealert |= MLOG_ALERT_STATUS_CH2_UPPER_ATTENTION;
						}
					}
				}
		        WPFM_doNotifies[1] = false;
			}
	    }
	    enableKind = WPFM_settingParameter.alertEnableKinds[1][1][0];
	    if (enableKind == WPFM_ALERT_KIND_DISABLED || enableKind == WPFM_ALERT_KIND_PAUSED)
	    {
			if ((changealert & 0xF0) == MLOG_ALERT_STATUS_CH2_LOWER_ATTENTION) {	// 下限1
				changealert &= MLOG_ALERT_STATUS_CH2_NORMAL | 0x0F;
			}
	    }
	    enableKind = WPFM_settingParameter.alertEnableKinds[1][1][1];
	    if (enableKind == WPFM_ALERT_KIND_DISABLED || enableKind == WPFM_ALERT_KIND_PAUSED)
	    {
			if ((changealert & 0xF0) == MLOG_ALERT_STATUS_CH2_LOWER_WARNING) {
				changealert &= MLOG_ALERT_STATUS_CH2_NORMAL | 0x0F;
				if (enableKind == WPFM_ALERT_KIND_DISABLED) {
					enableKind = WPFM_settingParameter.alertEnableKinds[1][1][0];
					if (enableKind == WPFM_ALERT_KIND_ENABLED) {	// 下限1がenableなら
						if (changefirst == true) {	// 初回変化の場合
							changealert |= MLOG_ALERT_STATUS_CH2_LOWER_ATTENTION;
						}
					}
				}
		        WPFM_doNotifies[1] = false;
			}
	    }
	}
	return changealert;
}

#ifdef ADD_FUNCTION
void WPFM_cancelAlert()
{
	putst("##### cancelAlert\r\n");
	WPFM_lastAlertStatus = WPFM_lastAlertStatusSuppressed = 0;
	WPFM_TxType = 0;
	SENSOR_updateMeasurementInterval(WPFM_settingParameter.measurementInterval);
	WPFM_updateCommunicationInterval(WPFM_settingParameter.communicationInterval);
	WPFM_InAlert = false;
	DLCMatAlertTimeClr();
	WPFM_lastAlertStartTimes[0][0] = WPFM_lastAlertStartTimes[1][0] = WPFM_lastAlertStartTimes[0][1] = WPFM_lastAlertStartTimes[1][1] = 0;
	WPFM_lastAlertStartTimes2[0][0] = WPFM_lastAlertStartTimes2[0][1] = 0;
	WPFM_lastAlertStartTimes2[1][0] = WPFM_lastAlertStartTimes2[1][1] = 0;
// 上記 WPFM_updateCommunicationInterval() でcallされる
//	WPFM_setNextCommunicateAlarm();
}
#endif
