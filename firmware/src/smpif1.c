/*
 * File:    smpif1.c
 * Author:  Interark Corp.
 * Summary: WPFM(code name "DLC_04") project Smartphone interface implementation file.
 * Date:    2022/09/02 (R0)
 * Note:    Operational condition related functions.
 */

#define DEBUG_UART                   // Debug with UART

#include "wpfm.h"
#include "util.h"
#include "debug.h"
#include "smpif.h"

/*
*   Symbols
*/
#define NUM_COLUMNS_TYPE_A          30

/*
*   Locals
*/
static int parseParameterTypeA(const char *param, WPFM_SETTING_PARAMETER *q);


void SMPIF_getOperationalCondition(const char *param, char *resp)
{
    snprintf(resp + 6, SMPIF_MAX_RESPONSE_LENGTH - 1,
        "%lu,%lu,%lu,%lu,",
        WPFM_settingParameter.measurementInterval, WPFM_settingParameter.communicationInterval,
        WPFM_settingParameter.measurementIntervalOnAlert, WPFM_settingParameter.communicationIntervalOnAlert
    );

    char buffer[100];
    snprintf(buffer, sizeof(buffer) - 1,
        "%d,%d,%d,%d,%.3f,%d,%.3f,%d,%.3f,%d,%.3f,%u,",
        WPFM_settingParameter.sensorKinds[0],
        WPFM_settingParameter.upperLimits[0], WPFM_settingParameter.lowerLimits[0],
        WPFM_settingParameter.alertEnableKinds[0][0][1], WPFM_settingParameter.alertUpperLimits[0][1],
        WPFM_settingParameter.alertEnableKinds[0][0][0], WPFM_settingParameter.alertUpperLimits[0][0],
        WPFM_settingParameter.alertEnableKinds[0][1][0], WPFM_settingParameter.alertLowerLimits[0][0],
        WPFM_settingParameter.alertEnableKinds[0][1][1], WPFM_settingParameter.alertLowerLimits[0][1],
        WPFM_settingParameter.alertChatteringTimes[0]
    );
    strcat(resp + 6, buffer);

    snprintf(buffer, sizeof(buffer) - 1,
        "%d,%d,%d,%d,%.3f,%d,%.3f,%d,%.3f,%d,%.3f,%u,",
        WPFM_settingParameter.sensorKinds[1],
        WPFM_settingParameter.upperLimits[1], WPFM_settingParameter.lowerLimits[1],
        WPFM_settingParameter.alertEnableKinds[1][0][1], WPFM_settingParameter.alertUpperLimits[1][1],
        WPFM_settingParameter.alertEnableKinds[1][0][0], WPFM_settingParameter.alertUpperLimits[1][0],
        WPFM_settingParameter.alertEnableKinds[1][1][0], WPFM_settingParameter.alertLowerLimits[1][0],
        WPFM_settingParameter.alertEnableKinds[1][1][1], WPFM_settingParameter.alertLowerLimits[1][1],
        WPFM_settingParameter.alertChatteringTimes[1]
    );
    strcat(resp + 6, buffer);

    snprintf(buffer, sizeof(buffer) - 1,
        "%d,%lu",
        WPFM_settingParameter.alertChatteringKind,
        WPFM_settingParameter.alertTimeout
    );
    strcat(resp+ 6, buffer);

    int length = strlen(resp + 6);
    resp[0] = SMPIF_STX;
    resp[1] = '0' + (length / 100);
    resp[2] = '0' + ((length / 10) % 10);
    resp[3] = '0' + (length % 10);
    resp[4] = 'O';
    resp[5] = 'K';
    resp[6 + length] = SMPIF_ETX;
    resp[7 + length] = '\0';    // terminate

    // Send message to smartphone app.
    APP_printUSB(resp);
    APP_delay(100);

    SMPIF_dumpMessage("RESP", resp);
    APP_delay(100);
}

void SMPIF_setOperationalCondition(const char *param, char *resp)
{
    WPFM_SETTING_PARAMETER work;
    work = WPFM_settingParameter;
    int stat = parseParameterTypeA(param, &work);
	if (WPFM_operationMode == WPFM_OPERATION_MODE_MEASUREMENT) {
		stat = SMPIF_ERR_DISAPPROVAL_MODE;	// 測定モードではNG
	}
    if (stat == SMPIF_ERR_NONE)
    {
        // Set global variable "WPFM_settingParameter" and dump it
        WPFM_settingParameter = work;
        DEBUG_UART_printlnString("Store into flash memory.");
        if (! WPFM_writeSettingParameter(&WPFM_settingParameter))
        {
            DEBUG_UART_printlnString("WPFM_writeSettingParameter(): ERROR");
        }
        //WPFM_readSettingParameter(&work);
        //WPFM_dumpSettingParameter(&work);
        WPFM_dumpSettingParameter(&WPFM_settingParameter);

        // Update some parameters (asume not in alert)
        WPFM_updateCommunicationInterval(WPFM_settingParameter.communicationInterval);
        SENSOR_updateMeasurementInterval(WPFM_settingParameter.measurementInterval);
		if (WPFM_operationMode == WPFM_OPERATION_MODE_NON_MEASUREMENT) {	// 非測定モード
			SENSOR_updateMeasurementInterval(1);	// VSコマンドのため測定間隔1秒
		}
		WPFM_InAlert = false;

        sprintf(resp, "%c000OK%c", SMPIF_STX, SMPIF_ETX);
    }
    else
    {
        DEBUG_UART_printlnFormat("PARAM ERROR: %d,%d", SMPIF_errorColumn, SMPIF_errorPosition);
        APP_delay(100);

        sprintf(resp, "%c003NG", SMPIF_STX);
        switch (stat)
        {
            case SMPIF_ERR_BAD_PARAMETER:
                strcat(resp, "101");
                break;
			case SMPIF_ERR_DISAPPROVAL_MODE:
				strcat(resp, "200");
				break;
            default:
                strcat(resp, "102");
                break;
        }
        char etx[2] = { SMPIF_ETX, '\0' };
        strcat(resp, etx);
    }

    // Send message to smartphone app.
    APP_printUSB(resp);
    APP_delay(10);

    SMPIF_dumpMessage("RESP", resp);
    APP_delay(10);
}

static int parseParameterTypeA(const char *param, WPFM_SETTING_PARAMETER *q)
{
    char *p = (char *)param;

    // 各カラムをパースして、該当する動作条件項目へ設定する
    for (int column = 1; column <= NUM_COLUMNS_TYPE_A; column++)
    {
        switch (column)
        {
            // Common
            case 1:     // 通常測定間隔（秒）[UINT]
                q->measurementInterval = atoi(p);
                break;
            case 2:     // 通常通信間隔（秒）[UINT]
                q->communicationInterval = atoi(p);
                break;
            case 3:     // 警報時測定間隔（秒）[UINT]
                q->measurementIntervalOnAlert = atoi(p);
                break;
            case 4:     // 警報時通信間隔（秒）[UINT]
                q->communicationIntervalOnAlert = atoi(p);
                break;

            // Ch1
            case 5:     // Ch1入力種類 [UINT]
                q->sensorKinds[WPFM_SETTING_CH1] = atoi(p);
                break;
            case 6:     // Ch1上限 [INT]
                q->upperLimits[WPFM_SETTING_CH1] = atoi(p);
                break;
            case 7:     // Ch1下限 [INT]
                q->lowerLimits[WPFM_SETTING_CH1] = atoi(p);
                break;
            case 8:     // Ch1上アラート２(警報)有効無効 [UINT]
                q->alertEnableKinds[WPFM_SETTING_CH1][WPFM_SETTING_UPPER][WPFM_SETTING_LEVEL2] = atoi(p);
                break;
            case 9:     // Ch1上アラート２(警報)数値 [REAL]
                q->alertUpperLimits[WPFM_SETTING_CH1][WPFM_SETTING_LEVEL2] = atof(p);
                break;
            case 10:    // Ch1上アラート１(注意)有効無効 [UINT]
                q->alertEnableKinds[WPFM_SETTING_CH1][WPFM_SETTING_UPPER][WPFM_SETTING_LEVEL1] = atoi(p);
                break;
            case 11:    // Ch1上アラート１(注意)数値 [REAL]
                q->alertUpperLimits[WPFM_SETTING_CH1][WPFM_SETTING_LEVEL1] = atof(p);
                break;
            case 12:    // Ch1下アラート１(注意)有効無効 [UINT]
                q->alertEnableKinds[WPFM_SETTING_CH1][WPFM_SETTING_LOWER][WPFM_SETTING_LEVEL1] = atoi(p);
                break;
            case 13:    // Ch1下アラート１(注意)数値 [REAL]
                q->alertLowerLimits[WPFM_SETTING_CH1][WPFM_SETTING_LEVEL1] = atof(p);
                break;
            case 14:    // Ch1下アラート２(注意)有効無効 [UINT]
                q->alertEnableKinds[WPFM_SETTING_CH1][WPFM_SETTING_LOWER][WPFM_SETTING_LEVEL2] = atoi(p);
                break;
            case 15:    // Ch1下アラート２(注意)数値 [REAL]
                q->alertLowerLimits[WPFM_SETTING_CH1][WPFM_SETTING_LEVEL2] = atof(p);
                break;
            case 16:    // Ch1チャタリング数値（秒） [UINT]
                q->alertChatteringTimes[WPFM_SETTING_CH1] = atoi(p);
                break;

            // Ch2
            case 17:     // Ch2入力種類 [UINT]
                q->sensorKinds[WPFM_SETTING_CH2] = atoi(p);
                break;
            case 18:     // Ch2上限 [INT]
                q->upperLimits[WPFM_SETTING_CH2] = atoi(p);
                break;
            case 19:     // Ch2下限 [INT]
                q->lowerLimits[WPFM_SETTING_CH2] = atoi(p);
                break;
            case 20:    // Ch2上アラート２(警報)有効無効 [UINT]
                q->alertEnableKinds[WPFM_SETTING_CH2][WPFM_SETTING_UPPER][WPFM_SETTING_LEVEL2] = atoi(p);
                break;
            case 21:    // Ch2上アラート２(警報)数値 [REAL]
                q->alertUpperLimits[WPFM_SETTING_CH2][WPFM_SETTING_LEVEL2] = atof(p);
                break;
            case 22:    // Ch2上アラート１(注意)有効無効 [UINT]
                q->alertEnableKinds[WPFM_SETTING_CH2][WPFM_SETTING_UPPER][WPFM_SETTING_LEVEL1] = atoi(p);
                break;
            case 23:    // Ch2上アラート１(注意)数値 [REAL]
                q->alertUpperLimits[WPFM_SETTING_CH2][WPFM_SETTING_LEVEL1] = atof(p);
                break;
            case 24:    // Ch2下アラート１(注意)有効無効 [UINT]
                q->alertEnableKinds[WPFM_SETTING_CH2][WPFM_SETTING_LOWER][WPFM_SETTING_LEVEL1] = atoi(p);
                break;
            case 25:    // Ch2下アラート１(注意)数値 [REAL]
                q->alertLowerLimits[WPFM_SETTING_CH2][WPFM_SETTING_LEVEL1] = atof(p);
                break;
            case 26:    // Ch2下アラート２(注意)有効無効 [UINT]
                q->alertEnableKinds[WPFM_SETTING_CH2][WPFM_SETTING_LOWER][WPFM_SETTING_LEVEL2] = atoi(p);
                break;
            case 27:    // Ch2下アラート２(注意)数値 [REAL]
                q->alertLowerLimits[WPFM_SETTING_CH2][WPFM_SETTING_LEVEL2] = atof(p);
                break;
            case 28:    // Ch2チャタリング数値（秒） [UINT]
                q->alertChatteringTimes[WPFM_SETTING_CH2] = atoi(p);
                break;

            // Common of alert
            case 29:    // Ch共通チャタリング種類 [UINT]
                q->alertChatteringKind = atoi(p);
                break;
            case 30:    // 警報タイムアウト時間（秒） [UINT]
                q->alertTimeout = atoi(p);
                break;
        }

        if (column < NUM_COLUMNS_TYPE_A)
        {
            while (*p && *p != ',')
                ++p;
            if (*p != ',')
            {
                SMPIF_errorColumn = column;
                SMPIF_errorPosition = param - p;
                return (SMPIF_ERR_BAD_PARAMETER);
            }
            p++;    // skip comma
        }
    }

    return (SMPIF_ERR_NONE);
}
