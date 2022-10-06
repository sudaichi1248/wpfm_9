/*
 * File:    wpfm.c
 * Author:  Interark Corp.
 * Summary: WPFM(code name "DLC_04") project common definition file.
 * Date:    2022/09/21 (R0)
 * Note:
 */

#define DEBUG_UART

#include <string.h>
#include "wpfm.h"
#include "debug.h"

/*
*   Global variables
*/
  // current operation mode and status
WPFM_OPERATION_MODE WPFM_operationMode = WPFM_OPERATION_MODE_MEASUREMENT;
WPFM_STATUS WPFM_status = WPFM_STATUS_POWER_OFF;
bool WPFM_isConnectingUSB = false;
bool WPFM_isBeingReplacedBattery = false;
#ifdef ADD_FUNCTION
bool WPFM_isAlertPause = false;
#endif

  // current settings and default settings
WPFM_SETTING_PARAMETER WPFM_settingParameter;           // current setting parameters
WPFM_SETTING_PARAMETER WPFM_settingParameterDefault =   // default setting parameters
{
    // This parameter is valid or invalid
    true,                   // valid or invalid
    // Serial number
    12345678,
    // Operational condition
    10,                     // measurement interval on normal[sec]
    300,                    // communication interval on normal[sec]
    4,                      // measurement interval on alert[sec]
    60,                     // communication interval on alert[sec]
    0,
    { SENSOR_KIND_1_3V, SENSOR_KIND_NOT_PRESENT },   // sensor kinds
    { 3, 5 }, { 1, 1 },                   // upper/lower values
    {
        {       // ch1 alert enabled kind
            { WPFM_ALERT_KIND_ENABLED, WPFM_ALERT_KIND_ENABLED }, { WPFM_ALERT_KIND_ENABLED, WPFM_ALERT_KIND_ENABLED }
        },
        {       // ch2 alert enabled kind
            { WPFM_ALERT_KIND_ENABLED, WPFM_ALERT_KIND_ENABLED }, { WPFM_ALERT_KIND_ENABLED, WPFM_ALERT_KIND_ENABLED }
        }
    },
    { { 2.620, 2.823 }, { 4.620, 4.823 } },         // alart upper limits
    { { 1.315, 1.132 }, { 1.315, 1.132 } },         // alart lower limits
    { 30, 30 },             // alart chattring times
    WPFM_CHATTERING_KIND_IGNORE,    // chattering kind
    300,                    // emergency alart timeout[sec]
    // Calibration
    { { 1793, 2996, 4070, 4060 }, { 1793, 2995, 4070, 4060 } },     // calibration upper values[LSB]
    { { 566, 566,  30,  40 }, { 566, 566,  20,  40  } },                // calibration lower values[LSB]
    2400,                       // lowThresholdVoltage[mV]
    5,                          // timesLessThresholdVoltage
    60,                         // maximumBatteryExchangeTime[sec]
    "水圧", "MPa",              // Measure_ch1, MeaKind_ch1
    "流量", "m3/h",             // Measure_ch2, MeaKind_ch2
    "2040-01-01 09:00:01"      // AlertPause
};
volatile uint32_t WPFM_measurementInterval;     // Current measurement interval[Sec]
uint32_t WPFM_communicationInterval;            // Current communication interval[Sec]
bool WPFM_ForcedCall = false;

  // for alert
time_t WPFM_lastAlertStartTimes[2][2];          // Time when the last alert(warnin or attention) was issued [0:ch1/1:ch2] [0:upper/1:lower]
time_t WPFM_lastWarningStartTimes[2];           // Time when the last warnin was issued(0 means "not during warning") [0:ch1/1:ch2]
bool WPFM_InAlert = false;
uint8_t WPFM_TxType = 0;
#ifdef ADD_FUNCTION
time_t WPFM_lastAlertStartTimes2[2][2];      // Chattering_type2 Time when the last alert(warnin or attention) was issued [0:ch1/1:ch2] [0:limit1/1:limit2]
#endif

  // for battery
uint8_t WPFM_batteryStatus = 0;                 // Last battery status (use MLOG_BAT_STATUS_BAT* bit flags defined in mlog.h)
int WPFM_externalBatteryNumberInUse = 0;        // which battery is used (0:Undefined/1:Batter #1/2:Battery #2)
int WPFM_externalBatteryNumberToReplace = 0;   // which battery is exchanged (0:Undefined/1:Batter #1/2:Battery #2)
int WPFM_timesBelowTheThresholds[2];            // The number of times current battery voltage has fallen below the threshold - index 0: battery #1/1: battery #2
time_t WPFM_startExchangingBatteryTime = 0;

  // last measured values and status
time_t WPFM_lastMeasuredTime = 0;               // last measured time [Sec]
float WPFM_lastMeasuredValues[2];               // measured values - index 0: CH1/1: CH2 [MhPa..]
uint16_t WPFM_lastBatteryVoltages[2];           // external battery voltage - index 0: External#1/1: External#2 [mV]
int16_t WPFM_lastTemperatureOnBoard;            // temperature on board [x10 C]
uint8_t WPFM_lastAlertStatus = 0;               // lasty alert status (use MLOG_ALERT_STATUS_CH* bit flags defined in mlog.h)
uint8_t WPFM_lastAlertStatusSuppressed = 0;     // suppressed lasty alert status (use MLOG_ALERT_STATUS_CH* bit flags defined in mlog.h)

  // Opportunity for regular processing
volatile bool WPFM_doMeasure = false;           // Need to do regular measurement processing
volatile bool WPFM_doCommunicate = false;       // Need to do regular comminication processing
volatile bool WPFM_doNotifies[2] = { false, false };    // Need to notify processing for each channels

  // Current time
volatile uint32_t WPFM_now = 0;                 // Current epoch time [Sec]

  // Tact-switch handling
volatile WPFM_TACTSW_STATUS WPFM_tactSwStatus = WPFM_TACTSW_STATUS_NORMAL;  //
volatile time_t WPFM_lastButtonPressedTime = 0;     //
volatile time_t WPFM_lastButtonReleasedTime = 0;    //
bool WPFM_wasButtonPressed = false;                 //

  // last error
int WPFM_lastErrorNumber;
char *WPFM_lastErrorMessage;

  // for non-measurement mode
bool WPFM_isInSendingRegularly = false;             //


bool WPFM_writeSettingParameter(WPFM_SETTING_PARAMETER *param_p)
{
    uint32_t *data = (uint32_t *)param_p;
    uint32_t address = WPFM_SETTING_PARAMETER_ADDRESS;

    param_p->isInvalid = false;

    if (! NVMCTRL_RowErase(WPFM_SETTING_PARAMETER_ADDRESS))
    {
        DEBUG_UART_printlnFormat("NVMCTRL_RowErase() failed: %d", NVMCTRL_ErrorGet());
        return (false);     // error
    }
    while (NVMCTRL_IsBusy()) ;

    for (int n = 0; n < (sizeof(WPFM_SETTING_PARAMETER) / NVMCTRL_FLASH_PAGESIZE) + 1; n++)
    {
        NVMCTRL_CacheInvalidate();
        while (NVMCTRL_IsBusy()) ;

        NVMCTRL_PageWrite(data, address);
        while (NVMCTRL_IsBusy()) ;

        data += NVMCTRL_FLASH_PAGESIZE / sizeof(uint32_t);
        address += NVMCTRL_FLASH_PAGESIZE;
    }

    // Verify original data and
    if (memcmp((void *)param_p, (void *)WPFM_SETTING_PARAMETER_ADDRESS, sizeof(WPFM_SETTING_PARAMETER)) != 0)
    {
        DEBUG_UART_printlnString("WPFM_writeSettingParameter(): verify error.");
        return (false);
    }

    return (true);      // ok
}

bool WPFM_readSettingParameter(WPFM_SETTING_PARAMETER *param_p)
{
    return (NVMCTRL_Read((uint32_t *)param_p, sizeof(WPFM_SETTING_PARAMETER), WPFM_SETTING_PARAMETER_ADDRESS));
}

void WPFM_dumpSettingParameter(WPFM_SETTING_PARAMETER *param_p)
{
    DEBUG_UART_printlnFormat("-- SETTING PARAMETERS --");
    DEBUG_UART_printlnFormat("isInvalid: %d", param_p->isInvalid); APP_delay(10);
    DEBUG_UART_printlnFormat("serialNumber: %08u", (unsigned int)param_p->serialNumber); APP_delay(10);
    DEBUG_UART_printlnFormat("measurementInterval: %u", (unsigned int)param_p->measurementInterval); APP_delay(10);
    DEBUG_UART_printlnFormat("communicationInterval: %u", (unsigned int)param_p->communicationInterval); APP_delay(10);
    DEBUG_UART_printlnFormat("measurementIntervalOnAlert: %u", (unsigned int)param_p->measurementIntervalOnAlert); APP_delay(10);
    DEBUG_UART_printlnFormat("communicationIntervalOnAlert: %u", (unsigned int)param_p->communicationIntervalOnAlert); APP_delay(10);
    DEBUG_UART_printlnFormat("sensorKinds[2]: %d/%d", param_p->sensorKinds[0], param_p->sensorKinds[1]); APP_delay(10);
    DEBUG_UART_printlnFormat("upperLimits[2]: %u/%u", param_p->upperLimits[0], param_p->upperLimits[1]); APP_delay(10);
    DEBUG_UART_printlnFormat("lowerLimits[2]: %u/%u", param_p->lowerLimits[0], param_p->lowerLimits[1]); APP_delay(10);

    DEBUG_UART_printlnFormat("alertEnableKinds[2][2][2]: %d %d %d %d/%d %d %d %d",
            param_p->alertEnableKinds[0][0][0], param_p->alertEnableKinds[0][0][1],param_p->alertEnableKinds[0][1][0], param_p->alertEnableKinds[0][1][1],
            param_p->alertEnableKinds[1][0][0], param_p->alertEnableKinds[1][0][1],param_p->alertEnableKinds[1][1][0], param_p->alertEnableKinds[1][1][1]); APP_delay(10);

    DEBUG_UART_printlnFormat("alertUpperLimits[2][2]: %.3f %.3f/%.3f %.3f", param_p->alertUpperLimits[0][0], param_p->alertUpperLimits[0][1],
            param_p->alertUpperLimits[1][0], param_p->alertUpperLimits[1][1]); APP_delay(10);
    DEBUG_UART_printlnFormat("alertLowerLimits[2][2]: %.3f %.3f/%.3f %.3f", param_p->alertLowerLimits[0][0], param_p->alertLowerLimits[0][1],
            param_p->alertLowerLimits[1][0], param_p->alertLowerLimits[1][1]); APP_delay(10);
    DEBUG_UART_printlnFormat("alertChatteringTimes[2]: %u/%u",
            (unsigned int)param_p->alertChatteringTimes[0], (unsigned int)param_p->alertChatteringTimes[1]); APP_delay(10);
    DEBUG_UART_printlnFormat("alertChatteringKind: %d", (unsigned int)param_p->alertChatteringKind); APP_delay(10);
    DEBUG_UART_printlnFormat("alertTimeout: %u", (unsigned int)param_p->alertTimeout); APP_delay(10);

    DEBUG_UART_printlnFormat("calibrationUpperValues[2][4]: %u %u %u %u/%u %u %u %u",
            param_p->calibrationUpperValues[0][0], param_p->calibrationUpperValues[0][1],
            param_p->calibrationUpperValues[0][2], param_p->calibrationUpperValues[0][3],
            param_p->calibrationUpperValues[1][0], param_p->calibrationUpperValues[1][1],
            param_p->calibrationUpperValues[1][2], param_p->calibrationUpperValues[1][3]); APP_delay(10);
    DEBUG_UART_printlnFormat("calibrationLowerValues[2][4]: %u %u %u %u/%u %u %u %u",
            param_p->calibrationLowerValues[0][0], param_p->calibrationLowerValues[0][1],
            param_p->calibrationLowerValues[0][2], param_p->calibrationLowerValues[0][3],
            param_p->calibrationLowerValues[1][0], param_p->calibrationLowerValues[1][1],
            param_p->calibrationLowerValues[1][2], param_p->calibrationLowerValues[1][3]); APP_delay(10);

    DEBUG_UART_printlnFormat("lowThresholdVoltage: %u", (unsigned int)param_p->lowThresholdVoltage); APP_delay(10);
    DEBUG_UART_printlnFormat("timesLessThresholdVoltage: %u", (unsigned int)param_p->timesLessThresholdVoltage); APP_delay(10);
    DEBUG_UART_printlnFormat("maximumBatteryExchangeTime: %u", (unsigned int)param_p->maximumBatteryExchangeTime); APP_delay(10);

    DEBUG_UART_printlnFormat("Measure_ch1/MeaKind_ch1: \"%s\", \"%s\"", param_p->Measure_ch1, param_p->MeaKind_ch1); APP_delay(10);
    DEBUG_UART_printlnFormat("Measure_ch2/MeaKind_ch2: \"%s\", \"%s\"", param_p->Measure_ch2, param_p->MeaKind_ch2); APP_delay(10);

    DEBUG_UART_printlnFormat("Measurment: %u", (unsigned int)param_p->Measurment); APP_delay(10);
    DEBUG_UART_printlnFormat("AlertPause: \"%s\"", param_p->AlertPause); APP_delay(10);

    DEBUG_UART_printlnFormat("--");
}
