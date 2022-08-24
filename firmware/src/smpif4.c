/*
 * File:    smpif4.c
 * Author:  Interark Corp.
 * Summary: WPFM(code name "DLC_04") project Smartphone interface implementation file.
 * Date:    2022/08/16 (R0)
 * Note:    Calibration related functions
 */

#define DEBUG_UART                   // Debug with UART

#include "wpfm.h"
#include "util.h"
#include "debug.h"
#include "smpif.h"

/*
*   Symbols
*/
#define NUM_COLUMNS_TYPE_E      16

static int parseParameterTypeE(const char *param, WPFM_SETTING_PARAMETER *q);


void SMPIF_getCallibrationValues(const char *param, char *resp)
{
    snprintf(resp + 6, SMPIF_MAX_RESPONSE_LENGTH - 1,
        "%lu,%u,%u,%u,%u,%u,%u,%u,%u,%u,%u,%u,%u,%u,%u,%u",
        WPFM_settingParameter.serialNumber,
        WPFM_settingParameter.calibrationLowerValues[0][0], WPFM_settingParameter.calibrationUpperValues[0][0],
        WPFM_settingParameter.calibrationLowerValues[0][1], WPFM_settingParameter.calibrationUpperValues[0][1],
        WPFM_settingParameter.calibrationLowerValues[1][0], WPFM_settingParameter.calibrationUpperValues[1][0],
        WPFM_settingParameter.calibrationLowerValues[1][1], WPFM_settingParameter.calibrationUpperValues[1][1],
        WPFM_settingParameter.calibrationLowerValues[1][2], WPFM_settingParameter.calibrationUpperValues[1][2],
        WPFM_settingParameter.calibrationLowerValues[1][3], WPFM_settingParameter.calibrationUpperValues[1][3],
        WPFM_settingParameter.lowThresholdVoltage, WPFM_settingParameter.timesLessThresholdVoltage,
        WPFM_settingParameter.maximumBatteryExchangeTime
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

    // Send message to smartphone app.
    APP_printUSB(resp);
    APP_delay(100);

    SMPIF_dumpMessage("RESP", resp);
    APP_delay(100);
}

void SMPIF_setCallibrationValues(const char *param, char *resp)
{
    WPFM_SETTING_PARAMETER work;
    work = WPFM_settingParameter;
    int stat = parseParameterTypeE(param, &work);
    if (stat == SMPIF_ERR_NONE)
    {
        // Set global variable "WPFM_settingParameter" and dump it
        WPFM_settingParameter = work;
        DEBUG_UART_printlnString("Store into flash memory.");
        if (! WPFM_writeSettingParameter(&WPFM_settingParameter))
        {
            DEBUG_UART_printlnString("WPFM_writeSettingParameter(): ERROR");
        }

        WPFM_readSettingParameter(&work);
        WPFM_dumpSettingParameter(&work);

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

void SMPIF_notifyCallibrationTarget(const char *param, char *resp)
{
    if (strlen(param) != 2)
    {
        sprintf(resp, "%c003NG%3d%c", SMPIF_STX, 101, SMPIF_ETX);
    }
    else {
        int channelSetting = atoi(param);
        switch (channelSetting)
        {
            case 11:        // Ch1: 1-3V
                WPFM_settingParameter.sensorKinds[WPFM_SETTING_CH1] = SENSOR_KIND_1_3V;
                sprintf(resp, "%c000OK%c", SMPIF_STX, SMPIF_ETX);
                DEBUG_UART_printlnString("Set: Ch1/1-3V");
                break;
            case 12:        // Ch1: 1-5V
                WPFM_settingParameter.sensorKinds[WPFM_SETTING_CH1] = SENSOR_KIND_1_5V;
                DEBUG_UART_printlnString("Set: Ch1/1-5V");
                sprintf(resp, "%c000OK%c", SMPIF_STX, SMPIF_ETX);
                break;
            case 21:        // Ch2: 1-3V
                WPFM_settingParameter.sensorKinds[WPFM_SETTING_CH2] = SENSOR_KIND_1_3V;
                DEBUG_UART_printlnString("Set: Ch2/1-3V");
                sprintf(resp, "%c000OK%c", SMPIF_STX, SMPIF_ETX);
                break;
            case 22:        // Ch2: 1-5V
                WPFM_settingParameter.sensorKinds[WPFM_SETTING_CH2] = SENSOR_KIND_1_5V;
                DEBUG_UART_printlnString("Set: Ch2/1-5V");
                sprintf(resp, "%c000OK%c", SMPIF_STX, SMPIF_ETX);
                break;
            case 23:        // Ch2: 0-20mA
                WPFM_settingParameter.sensorKinds[WPFM_SETTING_CH2] = SENSOR_KIND_0_20MA;
                DEBUG_UART_printlnString("Set: Ch2/0-20mA");
                sprintf(resp, "%c000OK%c", SMPIF_STX, SMPIF_ETX);
                break;
            case 24:        // Ch2: 4-20mA
                WPFM_settingParameter.sensorKinds[WPFM_SETTING_CH2] = SENSOR_KIND_4_20MA;
                DEBUG_UART_printlnString("Set: Ch2/4-20mA");
                sprintf(resp, "%c000OK%c", SMPIF_STX, SMPIF_ETX);
                break;
            default:
                sprintf(resp, "%c003NG%3d%c", SMPIF_STX, 102, SMPIF_ETX);
                break;
        }
    }

    // Send message to smartphone app.
    APP_printUSB(resp);
    APP_delay(10);

    SMPIF_dumpMessage("RESP", resp);
    APP_delay(10);
}

void SMPIF_readCallibrationValues(const char *param, char *resp)
{
    // Read current two sensors output value
    ADC_ChannelSelect(SENDOR_CHANNEL_IN1, ADC_NEGINPUT_GND);
    uint16_t valueChannel1 = SENSOR_readRawValue();
    ADC_ChannelSelect(SENDOR_CHANNEL_IN2, ADC_NEGINPUT_GND);
    uint16_t valueChannel2 = SENSOR_readRawValue();
    snprintf(resp + 6, SMPIF_MAX_RESPONSE_LENGTH - 1, "%u,%u", valueChannel1, valueChannel2);

    // Make response message
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
    APP_delay(10);

    SMPIF_dumpMessage("RESP", resp);
    APP_delay(10);
}

static int parseParameterTypeE(const char *param, WPFM_SETTING_PARAMETER *q)
{
    char *p = (char *)param;

    // 各カラムをパースして、該当する動作条件項目へ設定する
    for (int column = 1; column <= NUM_COLUMNS_TYPE_E; column++)
    {
        switch (column)
        {
            // Individual identification
            case 1:     // シリアルNo [UINT: max 8-digits]
                q->serialNumber = atoi(p);
                break;

            // Ch1
            case 2:     // Ch1 1-3V入力時の0点 [UINT]
                q->calibrationLowerValues[WPFM_SETTING_CH1][SENSOR_KIND_1_3V - 1] = atoi(p);
                break;
            case 3:     // Ch1 1-3V入力時の最大点 [UINT]
                q->calibrationUpperValues[WPFM_SETTING_CH1][SENSOR_KIND_1_3V - 1] = atoi(p);
                break;
            case 4:     // Ch1 1-5V入力時の0点 [UINT]
                q->calibrationLowerValues[WPFM_SETTING_CH1][SENSOR_KIND_1_5V - 1] = atoi(p);
                break;
            case 5:     // Ch1 1-5V入力時の最大点 [UINT]
                q->calibrationUpperValues[WPFM_SETTING_CH1][SENSOR_KIND_1_5V - 1] = atoi(p);
                break;

            // Ch2
            case 6:     // Ch2 1-3V入力時の0点 [UINT]
                q->calibrationLowerValues[WPFM_SETTING_CH2][SENSOR_KIND_1_3V - 1] = atoi(p);
                break;
            case 7:     // Ch2 1-3V入力時の最大点 [UINT]
                q->calibrationUpperValues[WPFM_SETTING_CH2][SENSOR_KIND_1_3V - 1] = atoi(p);
                break;
            case 8:     // Ch2 1-5V入力時の0点 [UINT]
                q->calibrationLowerValues[WPFM_SETTING_CH2][SENSOR_KIND_1_5V - 1] = atoi(p);
                break;
            case 9:     // Ch2 1-5V入力時の最大点 [UINT]
                q->calibrationUpperValues[WPFM_SETTING_CH2][SENSOR_KIND_1_5V - 1] = atoi(p);
                break;
            case 10:     // Ch2 0-20mA入力時の0点 [UINT]
                q->calibrationLowerValues[WPFM_SETTING_CH2][SENSOR_KIND_0_20MA - 1] = atoi(p);
                break;
            case 11:     // Ch2 0-20mA入力時の最大点 [UINT]
                q->calibrationUpperValues[WPFM_SETTING_CH2][SENSOR_KIND_0_20MA - 1] = atoi(p);
                break;
            case 12:     // Ch2 4-20mA入力時の0点 [UINT]
                q->calibrationLowerValues[WPFM_SETTING_CH2][SENSOR_KIND_4_20MA - 1] = atoi(p);
                break;
            case 13:     // Ch2 4-20mA入力時の最大点 [UINT]
                q->calibrationUpperValues[WPFM_SETTING_CH2][SENSOR_KIND_4_20MA - 1] = atoi(p);
                break;

            // Battery
            case 14:    // 電池切替が必要だと判断する電圧の閾値（mV） [UINT]
                q->lowThresholdVoltage = atoi(p);
                break;
            case 15:    // 電池切替が必要だと判断する、閾値を下回った回数の閾値（回） [UINT]
                q->timesLessThresholdVoltage = atoi(p);
                break;
            case 16:    // 電池交換のために許容する最大時間（秒） [UINT]
                q->maximumBatteryExchangeTime = atoi(p);
                break;
        }

        if (column < NUM_COLUMNS_TYPE_E)
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
