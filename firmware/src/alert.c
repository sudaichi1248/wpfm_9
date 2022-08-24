/*
 * File:    alert.c
 * Author:  Interark Corp.
 * Summary: WPFM(code name "DLC_04") project alert handling file.
 * Date:    2022/08/12 (R0)
 * Note:
 */

#define DEBUG_UART                   // Debug with UART
#define DEBUG_DETAIL

#include "wpfm.h"
#include "util.h"
#include "debug.h"
#include "mlog.h"
#include "sensor.h"

#ifdef DEBUG_DETAIL
#   define  DBG_PRINT(...)  { char _line[80]; snprintf(_line, sizeof(_line),  __VA_ARGS__); UART_DEBUG_writeBytes(_line, strlen(_line)); UART_DEBUG_writeBytes("\n", 1); APP_delay(2); }
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
    for (int channelIndex = 0; channelIndex < 2; channelIndex++)
    {
        if (WPFM_settingParameter.sensorKinds[channelIndex] == SENSOR_KIND_NOT_PRESENT)
        {
            continue;   // 未使用のセンサはスキップする
        }

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
        if (WPFM_lastAlertStatus & upperWarning)
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
                SENSOR_updateMeasurementInterval(WPFM_settingParameter.measurementInterval);
                WPFM_updateCommunicationInterval(WPFM_settingParameter.communicationInterval);
                WPFM_lastAlertStartTimes[channelIndex][0] = occurrenceTime;
                hasCommunicationIntervalChanged = true;
            }
            else
            {
                DBG_PRINT("[ALERT(%d)] U1-3: %.3f", channelIndex+1, WPFM_lastMeasuredValues[channelIndex]);
                //- 上限1未満に収まっているので、アラート状態は通常に遷移する
                alertStatus &= ~upperWarning;
                SENSOR_updateMeasurementInterval(WPFM_settingParameter.measurementInterval);
                WPFM_updateCommunicationInterval(WPFM_settingParameter.communicationInterval);
                WPFM_lastAlertStartTimes[channelIndex][0] = 0;
                hasCommunicationIntervalChanged = true;
            }
        }
        else if (WPFM_lastAlertStatus & upperAttention)
        {
            //- 前回は、注意状態にあった場合
            if (WPFM_lastMeasuredValues[channelIndex] > WPFM_settingParameter.alertUpperLimits[channelIndex][1])
            {
                DBG_PRINT("[ALERT(%d)] U2-1: %.3f>%.3f", channelIndex+1, WPFM_lastMeasuredValues[channelIndex], WPFM_settingParameter.alertUpperLimits[channelIndex][1]);
                //- 上限2を超えたので、アラート状態は警報状態へ遷移する
                alertStatus &= ~upperAttention;
                alertStatus |= upperWarning;
                SENSOR_updateMeasurementInterval(WPFM_settingParameter.measurementIntervalOnAlert);
                WPFM_updateCommunicationInterval(WPFM_settingParameter.communicationIntervalOnAlert);
                WPFM_lastAlertStartTimes[channelIndex][0] = occurrenceTime;
                WPFM_doNotifies[channelIndex] = true;
                hasCommunicationIntervalChanged = true;
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
                WPFM_lastAlertStartTimes[channelIndex][0] = 0;
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
                SENSOR_updateMeasurementInterval(WPFM_settingParameter.measurementIntervalOnAlert);
                WPFM_updateCommunicationInterval(WPFM_settingParameter.communicationIntervalOnAlert);
                WPFM_lastAlertStartTimes[channelIndex][0] = occurrenceTime;
                WPFM_doNotifies[channelIndex] = true;
                hasCommunicationIntervalChanged = true;
            }
            else if (WPFM_lastMeasuredValues[channelIndex] > WPFM_settingParameter.alertUpperLimits[channelIndex][0])
            {
                DBG_PRINT("[ALERT(%d)] U3-2: %.3f>%.3f", channelIndex+1, WPFM_lastMeasuredValues[channelIndex], WPFM_settingParameter.alertUpperLimits[channelIndex][0]);
                //- 上限1を超えたので、アラート状態は注意状態へ遷移する
                alertStatus |= upperAttention;
                WPFM_lastAlertStartTimes[channelIndex][0] = occurrenceTime;
            }
            else
            {
                DBG_PRINT("[ALERT(%d)] U3-3: %.3f", channelIndex+1, WPFM_lastMeasuredValues[channelIndex]);
                //- 上限1未満に収まっているので、アラート状態はそのままとする
            }
        }

        // (2) 下限のチェック
        if (WPFM_lastAlertStatus & lowerWarning)
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
                SENSOR_updateMeasurementInterval(WPFM_settingParameter.measurementInterval);
                WPFM_updateCommunicationInterval(WPFM_settingParameter.communicationInterval);
                WPFM_lastAlertStartTimes[channelIndex][1] = occurrenceTime;
                hasCommunicationIntervalChanged = true;
            }
            else
            {
                DBG_PRINT("[ALERT(%d)] L1-3: %.3f", channelIndex+1, WPFM_lastMeasuredValues[channelIndex]);
                //- 下限1以上に収まっているので、アラート状態は通常に遷移する
                alertStatus &= ~lowerWarning;
                SENSOR_updateMeasurementInterval(WPFM_settingParameter.measurementInterval);
                WPFM_updateCommunicationInterval(WPFM_settingParameter.communicationInterval);
                WPFM_lastAlertStartTimes[channelIndex][1] = 0;
                hasCommunicationIntervalChanged = true;
            }
        }
        else if (WPFM_lastAlertStatus & lowerAttention)
        {
            //- 前回は、注意状態にあった場合
            if (WPFM_lastMeasuredValues[channelIndex] < WPFM_settingParameter.alertLowerLimits[channelIndex][1])
            {
                DBG_PRINT("[ALERT(%d)] L2-1: %.3f<%.3f", channelIndex+1, WPFM_lastMeasuredValues[channelIndex], WPFM_settingParameter.alertLowerLimits[channelIndex][1]);
                //- 下限2を下回ったので、アラート状態は警報状態へ遷移する
                alertStatus &= ~lowerAttention;
                alertStatus |= lowerWarning;
                SENSOR_updateMeasurementInterval(WPFM_settingParameter.measurementIntervalOnAlert);
                WPFM_updateCommunicationInterval(WPFM_settingParameter.communicationIntervalOnAlert);
                WPFM_lastAlertStartTimes[channelIndex][1] = occurrenceTime;
                WPFM_doNotifies[channelIndex] = true;
                hasCommunicationIntervalChanged = true;
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
                WPFM_lastAlertStartTimes[channelIndex][1] = 0;
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
                SENSOR_updateMeasurementInterval(WPFM_settingParameter.measurementIntervalOnAlert);
                WPFM_updateCommunicationInterval(WPFM_settingParameter.communicationIntervalOnAlert);
                WPFM_lastAlertStartTimes[channelIndex][1] = occurrenceTime;
                WPFM_doNotifies[channelIndex] = true;
                hasCommunicationIntervalChanged = true;
            }
            else if (WPFM_lastMeasuredValues[channelIndex] < WPFM_settingParameter.alertLowerLimits[channelIndex][0])
            {
                DBG_PRINT("[ALERT(%d)] L3-2: %.3f<%.3f", channelIndex+1, WPFM_lastMeasuredValues[channelIndex], WPFM_settingParameter.alertLowerLimits[channelIndex][0]);
                //- 下限1を超えたので、アラート状態は注意状態へ遷移する
                alertStatus |= lowerAttention;
                WPFM_lastAlertStartTimes[channelIndex][1] = occurrenceTime;
            }
            else
            {
                DBG_PRINT("[ALERT(%d)] L3-3: %.3f", channelIndex+1, WPFM_lastMeasuredValues[channelIndex]);
                //- 下限1未満に収まっているので、アラート状態はそのままとする
            }
        }
    }

    // 必要に応じて、次回の定期通信のアラームを変更する
    if (hasCommunicationIntervalChanged)
    {
        DBG_PRINT("[ALERT] Change next comminication alarm.");
        WPFM_setNextCommunicateAlarm();
    }

    // Suppress alerts during chattering time (pretend it didn't happen)
    uint8_t alertStatusSuppressed = alertStatus;
    if (WPFM_doNotifies[0] || WPFM_doNotifies[1])
    {
        DBG_PRINT("[ALERT] Do not supress alerts: %d/%d", WPFM_doNotifies[0], WPFM_doNotifies[1]);
        ;   // Do not suppress when notifying
    }
    else
    {
        for (int channelIndex = 0; channelIndex < 2; channelIndex++)
        {
            if (WPFM_settingParameter.sensorKinds[channelIndex] == SENSOR_KIND_NOT_PRESENT)
            {
                continue;   // Skip unused sensor
            }

            // Check upper-side
            if (WPFM_lastAlertStartTimes[channelIndex][0] > 0)
            {
                if ((alertStatus & upperAttention) && ! (WPFM_lastAlertStatus & upperAttention))
                {
                    DBG_PRINT("[ALERT(%d)] Not Suppress upper attention: %lu", channelIndex+1, WPFM_lastAlertStartTimes[channelIndex][0]);
                }
                else if (occurrenceTime < (WPFM_lastAlertStartTimes[channelIndex][0] + WPFM_settingParameter.alertChatteringTimes[channelIndex]))
                {
                    DBG_PRINT("[ALERT(%d)] Suppress upper attention/warning: %lu<%lu", channelIndex+1, occurrenceTime, (WPFM_lastAlertStartTimes[channelIndex][0]+WPFM_settingParameter.alertChatteringTimes[channelIndex]));
                    // Suppress upper limit alert
                    alertStatusSuppressed &= ~(upperWarning | upperAttention);
                }
                else
                {
                    DBG_PRINT("[ALERT(%d)] Not suppress upper attention/warning: %lu->%lu", channelIndex+1, WPFM_lastAlertStartTimes[channelIndex][0], (WPFM_lastAlertStartTimes[channelIndex][0]+WPFM_settingParameter.alertChatteringTimes[channelIndex]));
                    WPFM_lastAlertStartTimes[channelIndex][0] += WPFM_settingParameter.alertChatteringTimes[channelIndex];  // Extend chattering time
                    if (alertStatus & upperWarning)
                    {
                        WPFM_doNotifies[channelIndex] = true;
                    }
                }
            }

            // Check Lower -side
            if (WPFM_lastAlertStartTimes[channelIndex][1] > 0)
            {
                if ((alertStatus & lowerAttention) && ! (WPFM_lastAlertStatus & lowerAttention))
                {
                    DBG_PRINT("[ALERT(%d)] Not Suppress lower attention: %lu", channelIndex+1, WPFM_lastAlertStartTimes[channelIndex][1]);
                }
                else if (occurrenceTime < (WPFM_lastAlertStartTimes[channelIndex][1] + WPFM_settingParameter.alertChatteringTimes[channelIndex]))
                {
                    DBG_PRINT("[ALERT(%d)] Suppress lower attention/warning: %lu<%lu", channelIndex+1, occurrenceTime, (WPFM_lastAlertStartTimes[channelIndex][1]+WPFM_settingParameter.alertChatteringTimes[channelIndex]));
                    // Suppress lower limit alert
                    alertStatusSuppressed &= ~(lowerWarning | lowerAttention);
                }
                else
                {
                    DBG_PRINT("[ALERT(%d)] Not suppress lower attention/warning: %lu->%lu", channelIndex+1, WPFM_lastAlertStartTimes[channelIndex][1], (WPFM_lastAlertStartTimes[channelIndex][1]+WPFM_settingParameter.alertChatteringTimes[channelIndex]));
                    WPFM_lastAlertStartTimes[channelIndex][1] += WPFM_settingParameter.alertChatteringTimes[channelIndex];  // Extend chattering time
                    if (alertStatus & lowerWarning)
                    {
                        WPFM_doNotifies[channelIndex] = true;
                    }
                }
            }
        }
    }

    // Suppress CH1 alert according to disable specification
    WPFM_ALERT_KIND enableKind = WPFM_settingParameter.alertEnableKinds[0][0][0];
    if (enableKind == WPFM_ALERT_KIND_DISABLED || enableKind == WPFM_ALERT_KIND_PAUSED)
    {
        alertStatusSuppressed &= ~MLOG_ALERT_STATUS_CH1_UPPER_ATTENTION;
    }
    enableKind = WPFM_settingParameter.alertEnableKinds[0][0][1];
    if (enableKind == WPFM_ALERT_KIND_DISABLED || enableKind == WPFM_ALERT_KIND_PAUSED)
    {
        alertStatusSuppressed &= ~MLOG_ALERT_STATUS_CH1_UPPER_WARNING;
    }
    enableKind = WPFM_settingParameter.alertEnableKinds[0][1][0];
    if (enableKind == WPFM_ALERT_KIND_DISABLED || enableKind == WPFM_ALERT_KIND_PAUSED)
    {
        alertStatusSuppressed &= ~MLOG_ALERT_STATUS_CH1_LOWER_ATTENTION;
    }
    enableKind = WPFM_settingParameter.alertEnableKinds[0][1][1];
    if (enableKind == WPFM_ALERT_KIND_DISABLED || enableKind == WPFM_ALERT_KIND_PAUSED)
    {
        alertStatusSuppressed &= ~MLOG_ALERT_STATUS_CH1_LOWER_WARNING;
    }
    // Suppress CH2 alert according to disable specification
    enableKind = WPFM_settingParameter.alertEnableKinds[1][0][0];
    if (enableKind == WPFM_ALERT_KIND_DISABLED || enableKind == WPFM_ALERT_KIND_PAUSED)
    {
        alertStatusSuppressed &= ~MLOG_ALERT_STATUS_CH2_UPPER_ATTENTION;
    }
    enableKind = WPFM_settingParameter.alertEnableKinds[1][0][1];
    if (enableKind == WPFM_ALERT_KIND_DISABLED || enableKind == WPFM_ALERT_KIND_PAUSED)
    {
        alertStatusSuppressed &= ~MLOG_ALERT_STATUS_CH2_UPPER_WARNING;
    }
    enableKind = WPFM_settingParameter.alertEnableKinds[1][1][0];
    if (enableKind == WPFM_ALERT_KIND_DISABLED || enableKind == WPFM_ALERT_KIND_PAUSED)
    {
        alertStatusSuppressed &= ~MLOG_ALERT_STATUS_CH2_LOWER_ATTENTION;
    }
    enableKind = WPFM_settingParameter.alertEnableKinds[1][1][1];
    if (enableKind == WPFM_ALERT_KIND_DISABLED || enableKind == WPFM_ALERT_KIND_PAUSED)
    {
        alertStatusSuppressed &= ~MLOG_ALERT_STATUS_CH2_LOWER_WARNING;
    }

    WPFM_lastAlertStatusSuppressed = alertStatusSuppressed;

    return (alertStatus);       // return real(no-suppressed) alert status
}
