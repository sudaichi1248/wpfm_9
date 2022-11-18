/*
 * File:    wpfm.h
 * Author:  Interark Corp.
 * Summary: WPFM(code name "DLC_04") project common header file.
 * Date:    2022/09/21 (R0)
 * Note:    Defined values ​​need to be reviewed according to specifications!
 */

#ifndef WPFM_H
#define	WPFM_H

#define ADD_FUNCTION									// Additional Function ChatteringType2 etc

#ifdef	__cplusplus
extern "C" {
#endif

#include <float.h>
#include "app.h"
#include "sensor.h"

/*
*   Macros
*/

/*
*   Symbols
*/
  // Version
#define WPFM_FW_VERSION                 "1.00"
  // EIC pin
#define WPFM_RTC_INTERRUPT_PINA         EIC_PIN_13      // INTRA: Alarm_Mo interrupt pin
#define WPFM_RTC_INTERRUPT_PINB         EIC_PIN_14      // INTRB: Time update and Alarm_Wk interrupt pin
#define WPFM_TACTSW_INTERRUPT_PIN       EIC_PIN_4       // Tact switch interrupt pin
  // GPIO expander pins
#define WPFM_GPIO_LED1                  0               // LED1 (Low:on/High:Off)
#define WPFM_GPIO_EXT1_LED              1               // External battery LED1 (Low:on/High:off)
#define WPFM_GPIO_EXT2_LED              2               // External battery LED2 (Low:on/High:off)
#define WPFM_GPIO_RESERVED              3               // Reserved
#define WPFM_GPIO_CH1_EXT_PWR           4               // Disconnect external #1 power (Low:disconnect/High:connect)
#define WPFM_GPIO_CH2_EXT_PWR           5               // Disconnect external #2 power (Low:disconnect/High:connect)
#define WPFM_GPIO_CH1_PWR               6               // Control sensor #1 power (low:off/High:on)
#define WPFM_GPIO_CH2_PWR               7               // Control sensor #2 power (low:off/High:on)
  // Timing
#define WPFM_LONG_PRESSED_TIME          5000            // Threshold of time to determine that it is long pressed[mS]
  // Sensor control
#define WPFM_THRESHOLD_FOR_SENSOR_POWER_CONTROL     10  // Threshold for sensor power on/off each time[Sec]
  // Missing values
#define WPFM_MISSING_VALUE_FLOAT        FLT_MAX         //
#define WPFM_MISSING_VALUE_UINT16       0xffff          //
#define WPFM_MISSING_VALUE_UINT32       0xffffffff      //
  // Setting parameter address
#define WPFM_SETTING_PARAMETER_ADDRESS  0x0003FE00      // Last space of flash memory (256Bytes)
  // Maximum symbols
#define WPFM_MAX_TARGET_NAME            16              // Measurement target name ("水圧" ..)
#define WPFM_MAX_UNIT_NAME              16              // Measurement unit name ("MPa" ..)

/*
*   Types
*/

typedef enum
{
    WPFM_OPERATION_MODE_MEASUREMENT = 0,    // 計測モード（通常モード）
    WPFM_OPERATION_MODE_NON_MEASUREMENT      // 非計測モード（設置モード）
} WPFM_OPERATION_MODE;      // 動作モード

typedef enum
{
    WPFM_ALERT_KIND_DISABLED = 0,           // アラート無効
    WPFM_ALERT_KIND_ENABLED = 1,            // アラート有効
    WPFM_ALERT_KIND_PAUSED = 2              // 未使用
} WPFM_ALERT_KIND;          // アラート有効種別（アラート有効無効）

typedef enum
{
    WPFM_CHATTERING_KIND_IGNORE = 1,        // 無視期間
    WPFM_CHATTERING_KIND_CONTINUOUS         // 継続期間
} WPFM_CHATTERING_KIND;

typedef enum
{
    WPFM_STATUS_POWER_OFF = 0,
    WPFM_STATUS_INITIALIZING,
    WPFM_STATUS_IDLE,
    WPFM_STATUS_MEASUREMENT,
    WPFM_STATUS_EMERGENCY_ALERT,
    WPFM_STATUS_SLEEP,
    WPFM_STATUS_EXCHANGING_BATTERY,
    WPFM_STATUS_INITIALIZING_SETTING,
    WPFM_STATUS_WAIT_COMMAND,
    WPFM_STATUS_PROCESSING_COMMAND
} WPFM_STATUS;              // 動作状態

typedef enum {
    WPFM_TACTSW_STATUS_NORMAL = 0,          // 開放されている状態
    WPFM_TACTSW_STATUS_PRESSING,            // 押下中
    WPFM_TACTSW_STATUS_PRESSED,             // 押下された状態
    WPFM_TACTSW_STATUS_RELEASING            // 開放中
} WPFM_TACTSW_STATUS;

typedef struct
{
    // This parameter is invalid or valid
    bool            isInvalid;                          // 本パラメータは無効か(true)/有効か(false)
    // Serial number
    uint32_t        serialNumber;                       // シリアルNo(装置固有の識別番号)
    // Operational condition
    uint32_t        measurementInterval;                // 平時の測定間隔 [Sec]
    uint32_t        communicationInterval;              // 平時の通信間隔 [Sec] - 60で割り切れること
    uint32_t        measurementIntervalOnAlert;         // 警報時の測定間隔 [Sec]
    uint32_t        communicationIntervalOnAlert;       // 警報時の通信間隔 [Sec] - 60で割り切れること
    uint16_t        Measurment  ;                       // Measurement
    SENSOR_KIND     sensorKinds[2];                     // センサ種別[0:ch1/1:ch2]
    int16_t         upperLimits[2];                     // 仕様上のセンサ出力の上限値[0:ch1/1:ch2] [-]
    int16_t         lowerLimits[2];                     // 仕様上のセンサ出力の下限値[0:ch1/1:ch2] [-]
    WPFM_ALERT_KIND alertEnableKinds[2][2][2];          // アラート有効種別(0:無効/1:有効/2:一時停止) [0:ch1/1:ch2] [0:upper/1:lower] [0:上下限1/1:上下限2]
    float           alertUpperLimits[2][2];             // アラート上限値[0:ch1/1:ch2] [0:上限値1/1:上限値2] [V/mA]
    float           alertLowerLimits[2][2];             // アラート下限値[0:ch1/1:ch2] [0:下限値1/1:下限値2] [V/mA]
    uint16_t        alertChatteringTimes[2];            // アラートチャタリング時間 [0:ch1/1:ch2] [Sec]
    WPFM_CHATTERING_KIND alertChatteringKind;           // CH共通チャタリング種別
    uint32_t        alertTimeout;                       // 警報タイムアウト時間 [Sec]
    // Calibration
    uint16_t        calibrationUpperValues[2][4];       // 上限の校正値[0:ch1/1:ch2] [0-3:センサ種別] [LSB]
    uint16_t        calibrationLowerValues[2][4];       // 下限の校正値[0:ch1/1:ch2] [0-3:センサ種別] [LSB]
    uint16_t        lowThresholdVoltage;                // 電池切替が必要だと判断する電圧の閾値[mV]
    uint16_t        timesLessThresholdVoltage;          // 電池切替が必要だと判断する、閾値を下回った最低回数[回]
    uint16_t        maximumBatteryExchangeTime;         // 電池交換のために許容する最大時間[Sec]
    char            Measure_ch1[WPFM_MAX_TARGET_NAME];  // CH1の計測対象名
    char            MeaKind_ch1[WPFM_MAX_UNIT_NAME];    // CH1の単位名
    char            Measure_ch2[WPFM_MAX_TARGET_NAME];  // CH2の計測対象名
    char            MeaKind_ch2[WPFM_MAX_UNIT_NAME];    // CH2の単位名
    char            AlertPause[24];                     // AlertPause(ex. "1970-01-01 09:00:01")
} WPFM_SETTING_PARAMETER;
    // value of sensorKinds[] is used for index of calibrationUpperValues[] and calibrationLowerValues[]
// index of each array -- common values
#define WPFM_SETTING_CH1                    0           // Ch1
#define WPFM_SETTING_CH2                    1           // Ch2
#define WPFM_SETTING_UPPER                  0           // 上限
#define WPFM_SETTING_LOWER                  1           // 下限
#define WPFM_SETTING_LEVEL1                 0           // 注意
#define WPFM_SETTING_LEVEL2                 1           // 警報


/*
*   Global variables (define on wpfm.c)
*/
  // current operation
extern WPFM_OPERATION_MODE WPFM_operationMode;      // Current operation mode(WPFM_OPERATION_MODE_*)
extern WPFM_STATUS WPFM_status;                     // Current status(WPFM_STATUS_*)
extern bool WPFM_isConnectingUSB;                   // Is connected to USB to PC/Smartphone.
extern bool WPFM_isBeingReplacedBattery;           // Is being exchanged battery.
extern bool WPFM_ForcedCall;
  // current settings
extern WPFM_SETTING_PARAMETER WPFM_settingParameter; // Current setting parameters
extern WPFM_SETTING_PARAMETER WPFM_settingParameterDefault;     // Default setting parameters
extern volatile uint32_t WPFM_measurementInterval;           // Current measurement interval[Sec]
extern uint32_t WPFM_communicationInterval;         // Current communication interval[Sec]
  // for alert
extern time_t WPFM_lastAlertStartTimes[2][2];       // Time when the last alert(warnin or attention) was issued [0:ch1/1:ch2] [0:upper/1:lower]
extern time_t WPFM_lastWarningStartTimes[2];        // Time when the last warnin was issued(0 means "not during warning") [0:ch1/1:ch2]
extern bool WPFM_InAlert;
extern uint8_t WPFM_TxType;
#ifdef ADD_FUNCTION
extern time_t WPFM_lastAlertStartTimes2[2][2];   // Chattering_type2 Time when the last alert(warnin or attention) was issued [0:ch1/1:ch2] [0:limit1/1:limit2]
extern bool WPFM_isAlertPause;
extern bool WPFM_cancelAlertDone;
#endif
  // for battery
extern uint8_t WPFM_batteryStatus;                  // Last battery status (use MLOG_BAT_STATUS_BAT* bit flags defined in mlog.h)
extern int WPFM_externalBatteryNumberInUse;         // which battery is used (0:Undefined/1:Batter #1/2:Battery #2)
extern int WPFM_externalBatteryNumberToReplace;    // which battery is exchanged (0:No battery to exchange/1:Batter #1/2:Battery #2)
extern int WPFM_timesBelowTheThresholds[2];         // The number of times current battery voltage has fallen below the threshold - index 0: battery #1/1: battery #2
extern time_t WPFM_startExchangingBatteryTime;      // Time when battery replacement started
  // last measured values and status
extern time_t WPFM_lastMeasuredTime;                // last measured time[Sec]
extern float WPFM_lastMeasuredValues[2];            // measured values - index 0: CH1/1: CH2 [MhPa..]
extern uint16_t WPFM_lastBatteryVoltages[2];        // external battery voltage - index 0: External#1/1: External#2 [mV]
extern int16_t WPFM_lastTemperatureOnBoard;         // temperature on board [x10 C]
extern uint8_t WPFM_lastAlertStatus;                // lasty alert status (use MLOG_ALERT_STATUS_CH* bit flags defined in mlog.h)
extern uint8_t WPFM_lastAlertStatusSuppressed;      // suppressed lasty alert status (use MLOG_ALERT_STATUS_CH* bit flags defined in mlog.h)
  // Opportunity for regular processing
extern volatile bool WPFM_doMeasure;                // Need to do regular measurement processing
extern volatile bool WPFM_doCommunicate;            // Need to do regular comminication processing
extern volatile bool WPFM_doNotifies[2];            // Need to notify processing for each channels
  // Current time
extern volatile uint32_t WPFM_now;                  // Current epoch time [Sec]
  // Tact-switch handling
extern volatile WPFM_TACTSW_STATUS WPFM_tactSwStatus;       //
extern volatile time_t WPFM_lastButtonPressedTime;          //
extern volatile time_t WPFM_lastButtonReleasedTime;         //
extern bool WPFM_wasButtonPressed;                          //
  // last error
extern int WPFM_lastErrorNumber;
extern char *WPFM_lastErrorMessage;

// globals for non-measurement mode
extern bool WPFM_isInSendingRegularly;              //

/*
*   global functions
*/
  // defined in measure.c
extern void WPFM_measureRegularly(bool justMeasure);
  // defined in alert.c
extern uint8_t WPFM_judegAlert(uint32_t ot);
#ifdef ADD_FUNCTION
extern void WPFM_cancelAlert();
#endif
  // defined in communicate.c
extern void WPFM_uploadRegularly(void);
extern void WPFM_uploadOneShot(bool unsentOrEmpty);
extern void WPFM_notifyAlert(void);
  // defined in init.c
extern void WPFM_initializeApplication(void);
extern void WPFM_onAlarm(void);
extern void WPFM_onPressed(uintptr_t p);
extern void WPFM_onTimeupdate(void);
extern void WPFM_reboot(void);
extern void WPFM_sleep(void);
extern void WPFM_halt(const char *lastMessage);
extern void WPFM_updateCommunicationInterval(uint16_t interval);
extern bool WPFM_setNextCommunicateAlarm(void);
// defind in wpfm.c
extern bool WPFM_writeSettingParameter(WPFM_SETTING_PARAMETER *param_p);
extern bool WPFM_readSettingParameter(WPFM_SETTING_PARAMETER *param_p);
extern void WPFM_dumpSettingParameter(WPFM_SETTING_PARAMETER *param_p);


#ifdef	__cplusplus
}
#endif

#endif	/* WPFM_H */
