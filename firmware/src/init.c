/*
 * File:    init.c
 * Author:  Interark Corp.
 * Summary: WPFM(code name "DLC_04") project initialization implementation file.
 * Date:    2022/09/19 (R0)
 * Note:
 */

//#define DEBUG_UART              // Debug with UART
//#define DEBUG_USB               // Debug with USB

#include <string.h>
#include "wpfm.h"
#include "util.h"
#include "debug.h"
#include "gpioexp.h"
#include "rtc.h"
#include "s5851a.h"
#include "w25q128jv.h"
#include "mlog.h"
#include "moni.h"
#include "DLCpara.h"
#include "Eventlog.h"
void DLCMatTimerset();
void DLCMatErrorSleep();
#ifdef ADD_FUNCTION
bool DLCMatWatchAlertPause();
#endif

/*
*   Local variables and functions
*/
static void onSysTick(uintptr_t context);   // systick interrupt handler


/*******************************************************************************
  Function:
    int WPFM_initializeApplication(void)

  Summary:
    Initialize peripherals, drivers and global variables.

  Description:

  Precondition:
    SYS_Initialize() function has been completed.
    WPFM_operationMode has been set

  Parameters:
    None.

  Returns:
    None.

  Example:
    <code>
      SYS_Initialize();
      WPFM_initializeApplication();
    </code>

  Remarks:
    Depending on the value of WPFM_operationMode, some of the contents of initialization differ.
 */

void WPFM_initializeApplication(void)
{
    //- Set up systick
    SYSTICK_TimerCallbackSet(onSysTick, (uintptr_t)0);
    SYSTICK_TimerStart();

    //- Initialize GPIO expander's pins
    GPIOEXP_clear(WPFM_GPIO_CH1_PWR);
    GPIOEXP_clear(WPFM_GPIO_CH2_PWR);
    GPIOEXP_clear(WPFM_GPIO_CH1_EXT_PWR);
    GPIOEXP_clear(WPFM_GPIO_CH2_EXT_PWR);
    GPIOEXP_clear(WPFM_GPIO_RESERVED);
    GPIOEXP_set(WPFM_GPIO_LED1);
    GPIOEXP_set(WPFM_GPIO_EXT1_LED);
    GPIOEXP_set(WPFM_GPIO_EXT2_LED);

    //- Initialize UART_DEBUG because of debugging
    DEBUG_UART_printlnFormat("** DLC-04(F/W Ver%s) **", WPFM_FW_VERSION);
    DEBUG_UART_printlnString("Initialize..");

    putst("RESET CAUSE is ");
    PM_RESET_CAUSE cause = PM_ResetCauseGet();
    switch (cause)
    {
        case PM_RESET_CAUSE_POR_RESET:
#ifdef VER_DELTA_5
			WPFM_doConfigPost = true;	// send Config
#endif
            putst("POR ");
            break;
        case PM_RESET_CAUSE_BOD12_RESET:
            putst("BOD12 ");
            break;
        case PM_RESET_CAUSE_BOD33_RESET:
            putst("BOD33 ");
            break;
        case PM_RESET_CAUSE_EXT_RESET:
            putst("EXT_RESET ");
#ifdef VER_DELTA_5
			WPFM_doConfigPost = true;	// send Config
#endif
            break;
        case PM_RESET_CAUSE_WDT_RESET:
            putst("WDT_RESET ");
#ifdef VER_DELTA_5
			WPFM_doConfigPost = true;	// send Config
#endif
            break;
        case PM_RESET_CAUSE_SYST_RESET:
            putst("SYS_RESET ");
#ifdef VER_DELTA_5
			WPFM_doConfigPost = true;	// send Config
#endif
            break;
        default:
            putst("UNKNOWN ");
            break;
    }
    putcrlf();
    SYSTICK_DelayMs(10);

    // Load setting parameter from internal-flash
    if (! WPFM_readSettingParameter(&WPFM_settingParameter))
    {
        putst("parameter read error.");
    }
    //if (true)
    if (WPFM_settingParameter.isInvalid)
    {
        // Set default values
        putst("Set default parameter.");
        if (! WPFM_writeSettingParameter(&WPFM_settingParameterDefault))
        {
            putst("parameter write error!");
        }
        if (! WPFM_readSettingParameter(&WPFM_settingParameter))
        {
            putst("parameter read error!");
        }
    }
    WPFM_dumpSettingParameter(&WPFM_settingParameter);

    //- Initialize SPI-Flash
    W25Q128JV_begin(MEM_CS_PIN);
	DLCEventLogInit();	// Initialize EventLog

    // Control external batteries
//    uint16_t voltage = 0;
//    SENSOR_readExternalBatteryVoltage(1, &voltage);
#if 1
	SENSOR_readExternalBatteryVoltage(1, &WPFM_lastBatteryVoltages[0]);
	SENSOR_readExternalBatteryVoltage(2, &WPFM_lastBatteryVoltages[1]);
#else
	SENSOR_readExternalBatteryVoltageShurink(&WPFM_lastBatteryVoltages[0], &WPFM_lastBatteryVoltages[1]);
#endif
//    if (voltage > WPFM_settingParameter.lowThresholdVoltage)
	if (WPFM_lastBatteryVoltages[0] > WPFM_settingParameter.lowThresholdVoltage)
    {
        // Use Battery #1, detach Battery #2
        WPFM_externalBatteryNumberInUse = 1;
        WPFM_batteryStatus = MLOG_BAT_STATUS_BAT1_IN_USE | MLOG_BAT_STATUS_BAT2_NOT_USE;
		DLCEventLogWrite( _ID1_POWER_START,cause,0 );
        EXT2_OFF_Set();         // detach battery #2
    }
    else
    {
        // Use Battery #2, detach Battery #1
//        SENSOR_readExternalBatteryVoltage(2, &voltage);
//        if (voltage > WPFM_settingParameter.lowThresholdVoltage)
		if (WPFM_lastBatteryVoltages[1] > WPFM_settingParameter.lowThresholdVoltage)
        {
            WPFM_externalBatteryNumberInUse = 2;
            WPFM_batteryStatus = MLOG_BAT_STATUS_BAT2_IN_USE | MLOG_BAT_STATUS_BAT1_NOT_USE;
			DLCEventLogWrite( _ID1_POWER_START,cause,1 );
            EXT1_OFF_Set();     // detach battery #1
        }
        else
        {
            // Both batteries are low voltage, blink ext1-led and ext2-led until the battery is replaced and reset.
			// ‚±‚±‚ÍVBAT‹ì“®
putst("##### VBAT drive\r\n");
#if 1
			WPFM_isVbatDrive = true;	// VBAT‹ì“®
#else
 #if 1
		        WPFM_externalBatteryNumberInUse = 1;
		        WPFM_batteryStatus = MLOG_BAT_STATUS_BAT1_IN_USE | MLOG_BAT_STATUS_BAT2_NOT_USE;
		        EXT2_OFF_Set();         // detach battery #2
				DLCEventLogWrite( _ID1_POWER_START,cause,3 );
 #else
	            UTIL_startBlinkEXT1AND2LED();
	            while (true)
	                ;           // Stop here
 #endif
#endif
        }
    }

    //- Initialize RTC
    int stat;
    if (RTC_initialize(WPFM_RTC_INTERRUPT_PINA, WPFM_RTC_INTERRUPT_PINB) == RTC_ERR_INITIALIZED)
    {
        // Set default date and time (2022/09/01 00:00:00) if the date and time are abnormal
        RTC_DATETIME dt;
        dt.year = 22;
        dt.month = 9;
        dt.day = 1;
        dt.hour = 0;
        dt.minute = 0;
        dt.second = 0;
        RTC_setDateTime(dt);
    }
    if ((stat = RTC_setTimeUpdateInterrupt(RTC_TIMEUPDATE_SECOND, WPFM_onTimeupdate)) != RTC_ERR_NONE)
    {
        DEBUG_UART_printlnFormat("RTC_setTimeUpdateInterrupt() ERROR: %d", stat);
        DEBUG_UART_FLUSH();
		DLCEventLogWrite( _ID1_ERROR,0,stat );
    }

    // Set dafault intervals
    SENSOR_updateMeasurementInterval(WPFM_settingParameter.measurementInterval);
    WPFM_updateCommunicationInterval(WPFM_settingParameter.communicationInterval);
	WPFM_InAlert = false;
    DEBUG_UART_printlnFormat("Intervales: %lu,%lu", WPFM_measurementInterval, WPFM_communicationInterval);
    DEBUG_UART_FLUSH();

    //- Check analog sensors
    if (WPFM_settingParameter.sensorKinds[0] != SENSOR_KIND_NOT_PRESENT)
    {
        // Calibrate sensor #1
        DEBUG_UART_printlnFormat("Sensor #1 set as %d", WPFM_settingParameter.sensorKinds[0]);
        DEBUG_UART_FLUSH();
    }
    if (WPFM_settingParameter.sensorKinds[1] != SENSOR_KIND_NOT_PRESENT)
    {
        // Calibrate sensor #2
        DEBUG_UART_printlnFormat("Sensor #2 set as %d", WPFM_settingParameter.sensorKinds[1]);
        DEBUG_UART_FLUSH();
    }

#if 0	// main‚ÌLED“_–ÅŒã‚ÉˆÚ“®
    if (WPFM_operationMode == WPFM_OPERATION_MODE_MEASUREMENT)
    {
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
    }
#endif

    //- Initialize temperature sensor(S5851A)
    S5851A_setMode(S5851A_MODE_SHUTDOWN);

    //- Sleep MATcore
    RF_INT_IN_Clear();

    //- Set interrupt handler for tact-switch
    EIC_CallbackRegister(WPFM_TACTSW_INTERRUPT_PIN, (EIC_CALLBACK)WPFM_onPressed, (uintptr_t)NULL);
    EIC_InterruptEnable(WPFM_TACTSW_INTERRUPT_PIN);

    DEBUG_UART_printlnString("Initialize Done.");
    DEBUG_UART_FLUSH();
}

/*******************************************************************************
  Function:
    int WPFM_onAlarm(void)

  Summary:
    RTC alarm interrupt handler.

  Description:
    Create an opportunity to kick the periodic communication process.

  Precondition:
    The peripheral initialization process in the SYS_Initialize() function has been completed.

  Parameters:
    None.

  Returns:
    None.

  Remarks:

 */

void WPFM_onAlarm(void)
{
    WPFM_doCommunicate = true;
}

/*******************************************************************************
  Function:
    int WPFM_onPressed(void)

  Summary:
    RTC alarm interrupt handler.

  Description:
    Create an opportunity to kick the periodic communication process.

  Precondition:
    The peripheral initialization process in the SYS_Initialize() function has been completed.

  Parameters:
    None.

  Returns:
    None.

  Remarks:
    handle chattering.
 */

void WPFM_onPressed(uintptr_t p)
{
    if (TEST_SW_Get() == 0)
    {
		putst("Push+\r\n");
        // on Pressed (HIGH -> LOW Edge)
        switch (WPFM_tactSwStatus)
        {
            case WPFM_TACTSW_STATUS_PRESSING:
            case WPFM_TACTSW_STATUS_RELEASING:
                return;     // ignore
            case WPFM_TACTSW_STATUS_NORMAL:
            case WPFM_TACTSW_STATUS_PRESSED:
                break;
        }
#if _DAIKOKU_ORG
       TC5_TimerStart();
#else
		DLCMatTimerset( 2,20 );
#endif
        WPFM_tactSwStatus = WPFM_TACTSW_STATUS_PRESSING;
        WPFM_lastButtonPressedTime = SYS_tick;
    }
#if 0
    else
    {
		putst("Push-\r\n");
        // on Released (LOW -> HIGH Edge)
        switch (WPFM_tactSwStatus)
        {
            case WPFM_TACTSW_STATUS_PRESSING:
            case WPFM_TACTSW_STATUS_RELEASING:
                return;     // ignore
            case WPFM_TACTSW_STATUS_NORMAL:
            case WPFM_TACTSW_STATUS_PRESSED:
                break;
        }
#if _DAIKOKU_ORG
       TC5_TimerStart();
#else
		DLCMatTimerset( 2,20 );
#endif
        WPFM_tactSwStatus = WPFM_TACTSW_STATUS_RELEASING;
        WPFM_lastButtonReleasedTime = SYS_tick;
    }
#endif
}

/*******************************************************************************
  Function:
    int WPFM_reboot(void)

  Summary:
    Reboot the entire device.

  Description:
    Reboot Micro Controller Unit and devices.

  Precondition:
    The peripheral initialization process in the SYS_Initialize() function has been completed.

  Parameters:
    None.

  Returns:
    None.

  Remarks:

 */

void WPFM_reboot(void)
{
    DEBUG_UART_printlnFormat(">>WPFM_reboot(): %u", (unsigned int)WPFM_now);
    APP_delay(100);     // Flush UART

    // Reboot MCU
    NVIC_SystemReset();
}

/*******************************************************************************
  Function:
    int WPFM_sleep(void)

  Summary:
    Fall asleep..

  Description:
    Enter MCU to standby mode.

  Precondition:
    The peripheral initialization process in the SYS_Initialize() function has been completed.

  Parameters:
    None.

  Returns:
    None.

  Remarks:
    Before going to sleep, make appropriate power-saving settings, and
    When wake up, restore the setting.
 */

void WPFM_sleep(void)
{
    // (1) Make settings to save power before going to sleep.
    RF_INT_IN_Clear();      // sleep MATcore
    UTIL_setLED1();         // turn off LED1
    UTIL_setEXT1LED();      // turn off EXT1_LED
    UTIL_setEXT2LED();      // turn off EXT2_LED

    /** ENTER STAND-BY MODE **/

    // (2) Fall asleep..
    SYSTICK_TimerStop();
    PM_StandbyModeEnter();
    SYSTICK_TimerStart();

    /** WAKED UP **/

    // (3) Restore settings if nessesary
}

/*******************************************************************************
  Function:
    void WPFM_halt(const char *lastMessage)

  Summary:
    Halt the entire device.

  Description:
    Halt the entire device. No return function.

  Precondition:
    The peripheral initialization process in the SYS_Initialize() function has been completed.

  Parameters:
    None.

  Returns:
    None.

  Remarks:

 */
void WPFM_halt(const char *lastMessage)
{
    // Output death message
	DLCEventLogWrite( _ID1_SYS_ERROR,0x55,0 );
    DEBUG_UART_printlnFormat("WPFM_halt(%s).", lastMessage);
    DEBUG_UART_FLUSH();
    // Disable all wake-up interrupts
    RTC_setTimeUpdateInterrupt(RTC_TIMEUPDATE_SECOND, NULL);
    RTC_setAlarm((WPFM_communicationInterval / 60), NULL);
    EIC_InterruptDisable(WPFM_TACTSW_INTERRUPT_PIN);
	WDT_Disable();
	DLCMatErrorSleep();
	nV1GD_Clear();
    // Fall asleep..
    WPFM_sleep();
	while (true);
}

/*******************************************************************************
  Function:
    void WPFM_updateCommunicationInterval(void)

  Summary:
    Update communication interval and set next alarm.

  Description:
    Adjust the alarm time to set to match 00 minutes every hour or 00:00 every day.

  Precondition:
    The peripheral initialization process in the SYS_Initialize() function has been completed.

  Parameters:
    None.

  Returns:
    None.

  Remarks:
    Update global variable "WPFM_communicationInterval"
 */

void WPFM_updateCommunicationInterval(uint32_t interval)
{
    WPFM_communicationInterval = interval;
    if (! WPFM_setNextCommunicateAlarm())
    {
        DEBUG_UART_printlnString("RTC_setAlarm() NG");
    }
}

/*******************************************************************************
  Function:
    void WPFM_setNextCommunicateAlarm(void)

  Summary:
    Set an alarm for the next communication regularly.

  Description:
    Adjust the alarm time to set to match 00 minutes every hour or 00:00 every day.

  Precondition:
    The peripheral initialization process in the SYS_Initialize() function has been completed.

  Parameters:
    None.

  Returns:
    None.

  Remarks:

 */

bool WPFM_setNextCommunicateAlarm(void)
{
    // Adjust and set next alarm
    uint32_t nextTime = RTC_now + WPFM_communicationInterval;
//   putst("WPFM_communicationInterval=");putdecw( WPFM_communicationInterval );putcrlf();
    DEBUG_UART_printlnFormat(">>nextTime: %lu,%lu", nextTime, WPFM_communicationInterval);
// ’èŠú’Ê’m•ªŽU‚Ì‚½‚ß“dŒ¹ON‚©‚çÝ’èŽžŠÔŒã
//    nextTime -= nextTime % WPFM_communicationInterval;
//    DEBUG_UART_printlnFormat(">>nextTime: %lu", nextTime);
    uint32_t minutesLater = ((nextTime - RTC_now) + 59) / 60;
    if (minutesLater ==  0)
    {
        minutesLater++;     // adjust as minimum one minute
    }
#ifdef DEBUG_UART
    char line[80];
    RTC_DATETIME dt;
    RTC_convertToDateTime(RTC_now, &dt);
    snprintf(line, sizeof(line) - 1, "NEXT ALARM> %04d/%02d/%02d %02d:%02d:%02d +%lumin)",
            (dt.year + 2000), dt.month, dt.day, dt.hour, dt.minute, dt.second, minutesLater);
    DEBUG_UART_printlnString(line);
    APP_delay(20);
#endif

    int stat;
    if ((stat = RTC_setAlarm(minutesLater, WPFM_onAlarm)) != RTC_ERR_NONE)
    {
        DEBUG_UART_printlnFormat("RTC_setAlarm() NG: %d", stat);
        return (false);     // Failed
    }

    return (true);      // Okey
}

/*******************************************************************************
  Function:
    int onTimeupdate(void)

  Summary:
    RTC time-update interrupt handler.

  Description:
    Create an opportunity to kick the periodic measurement process.

  Precondition:
    The peripheral initialization process in the SYS_Initialize() function has been completed.

  Parameters:
    None.

  Returns:
    None.

  Remarks:

 */

void WPFM_onTimeupdate(void)
{
    SYS_mSec = 0;               // Reset mSec

    if (RTC_now % WPFM_measurementInterval == 0)
    {
        WPFM_doMeasure = true;
    }
#ifdef ADD_FUNCTION
	WPFM_isAlertPause = DLCMatWatchAlertPause();
	if (WPFM_isAlertPause == true) {
		if (WPFM_cancelAlertDone == false) {
			WPFM_cancelAlert();
			WPFM_cancelAlertDone = true;
		}
	}
#endif
}

/*******************************************************************************
  Function:
    int onSysTick(void)

  Summary:
    systick interrupt handler.

  Description:
    count up SYS_mSec and SYS_tick every systick interrupt.

  Precondition:
    The peripheral initialization process in the SYS_Initialize() function has been completed.

  Parameters:
    context: not used

  Returns:
    None.

  Remarks:

 */

static void onSysTick(uintptr_t context)
{
    SYS_mSec++;
    SYS_tick++;
}
