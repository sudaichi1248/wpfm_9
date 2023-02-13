/*
 * File:    measure.c
 * Author:  Interark Corp.
 * Summary: WPFM(code name "DLC_04") project common definition file.
 * Date:    2022/09/09 (R0)
 * Note:
 */

#define DEBUG_UART                   // Debug with UART
//#define DEBUG_DETAIL

#include "wpfm.h"
#include "util.h"
#include "debug.h"
#include "mlog.h"
#include "sensor.h"
#include "battery.h"
#include "s5851a.h"
#include "rtc.h"
#include "moni.h"
#include "Eventlog.h"
#include "DLCpara.h"

#ifdef DEBUG_UART
#   define  DBG_PRINT(...)  { if (DLC_Para.MeasureLog == 0) {char _line[80]; snprintf(_line, sizeof(_line),  __VA_ARGS__); UART_DEBUG_writeBytes(_line, strlen(_line)); UART_DEBUG_writeBytes("\n", 1);} }
#else
#   define  DBG_PRINT()
#endif
/*
*   Symbols
*/

/*
*   Local variables and functions
*/
static void _SENSOR_storeLog(uint32_t occurrenceTime, uint32_t mSec);

int DLCMatIsCom();

 /*
 *   measureRegularly() -
 */
void WPFM_measureRegularly(bool justMeasure)
{
    uint32_t start = SYS_mSec, occurrenceTime = RTC_now;
    int stat = 0;
	bool kind_1_3v = false;

    RTC_DATETIME dt;
    RTC_getDatetime(&dt);
    DBG_PRINT("\n-- START MEASUREMENT(20%02d/%02d/%02d %02d:%02d:%02d.%03lu) --",
            dt.year, dt.month, dt.day, dt.hour, dt.minute, dt.second, SYS_mSec);

    // Start measument of temperature here baecause of too slow
    S5851A_startMeasurement();

    // Turn on a sensor(s)
    for (int sensorIndex = 0; sensorIndex < 2; sensorIndex++)
    {
        uint8_t sensorKind = WPFM_settingParameter.sensorKinds[sensorIndex];
        if (sensorKind == SENSOR_KIND_NOT_PRESENT)
        {
            continue;   // Skip measurement if the sensor is not present
        }

        // Power on sensor power if necessary
        if (! SENSOR_alwaysOnSensorPowers[sensorIndex])
        {
            if  (sensorKind == SENSOR_KIND_1_3V)
            {
                SENSOR_turnOnSensorCircuit(sensorIndex + 1, true);
                kind_1_3v = true;
            }
            else
            {
                SENSOR_turnOnSensorCircuit(sensorIndex + 1, false);
                SYSTICK_DelayMs(10);        // wait a little
            }
        }
    }

	// Turn on wait
	if (kind_1_3v == true) {
		SYSTICK_DelayMs(SENSOR_PRE_ENERGIZATION_TIME_OF_SENSOR);    // APP_delay(SENSOR_PRE_ENERGIZATION_TIME_OF_SENSOR);
	}

    // Reading a sensor(s)
#ifndef SENSOR_SHURINK
    for (int sensorIndex = 0; sensorIndex < 2; sensorIndex++)
    {
        uint8_t sensorKind = WPFM_settingParameter.sensorKinds[sensorIndex];
        if (sensorKind == SENSOR_KIND_NOT_PRESENT)
        {
            continue;   // Skip measurement if the sensor is not present
        }

        float value = WPFM_MISSING_VALUE_FLOAT;
        if ((stat = SENSOR_readSensorOutput(sensorIndex + 1, &value)) == SENSOR_ERR_NONE)
        {
            DEBUG_UART_printlnFormat("SENSOR_readSensorOutput(%d) OK: %.3f", sensorIndex + 1, value);
        }
        else
        {
            DEBUG_UART_printlnFormat("SENSOR_readSensorOutput(%d) NG: %d", sensorIndex + 1, stat);
        }
		if (value > WPFM_settingParameter.upperLimits[sensorIndex]) {	// è„å¿Å^â∫å¿Ç≈ä€ÇﬂçûÇ›
			value = WPFM_settingParameter.upperLimits[sensorIndex];
		} else if (value < WPFM_settingParameter.lowerLimits[sensorIndex]) {
			value = WPFM_settingParameter.lowerLimits[sensorIndex];
		}
        WPFM_lastMeasuredValues[sensorIndex] = value;

        // Power off sensor power if necessary
        if (! SENSOR_alwaysOnSensorPowers[sensorIndex])
        {
            SENSOR_turnOffSensorCircuit(sensorIndex + 1);
        }
    }
#else	// SENSOR_SHURINK
	if ((stat = SENSOR_readSensorOutputShurink(&WPFM_lastMeasuredValues[0], &WPFM_lastMeasuredValues[1])) == SENSOR_ERR_NONE)
	{
		if (WPFM_settingParameter.sensorKinds[0] != SENSOR_KIND_NOT_PRESENT) {
			DBG_PRINT("SENSOR_readSensorOutput(1) OK: %.3f", WPFM_lastMeasuredValues[0]);
		}
		if (WPFM_settingParameter.sensorKinds[1] != SENSOR_KIND_NOT_PRESENT) {
			DBG_PRINT("SENSOR_readSensorOutput(2) OK: %.3f", WPFM_lastMeasuredValues[1]);
		}
	}
	else
	{
		DBG_PRINT("SENSOR_readSensorOutput(-) NG: %d", stat);
	}
#endif	// SENSOR_SHURINK

    // Read temperature sensor on board
    WPFM_getTemperature();

    if (! justMeasure)
    {
        // Judge alert by sensor values and ..
        WPFM_lastAlertStatus = WPFM_judegAlert(occurrenceTime);

        // Store measurement values to mlog
        _SENSOR_storeLog(occurrenceTime, start);
    }

    RTC_getDatetime(&dt);
    DBG_PRINT("-- END MEASUREMENT(%02d:%02d:%02d.%03lu) --\n", dt.hour, dt.minute, dt.second, SYS_mSec);

#ifdef DEBUG_DETAIL
    DEBUG_UART_printlnFormat("measureRegularly() execution time: %umS", (unsigned int)(SYS_mSec - start));
#endif // DEBUG_UART
}

static void _SENSOR_storeLog(uint32_t occurrenceTime, uint32_t mSec)
{
    MLOG_T mlog;
    mlog.timestamp.second = occurrenceTime;
    mlog.timestamp.mSecond = mSec % 1000;
    mlog.measuredValues[0] = WPFM_lastMeasuredValues[0];
    mlog.measuredValues[1] = WPFM_lastMeasuredValues[1];
    mlog.batteryVoltages[0] = WPFM_lastBatteryVoltages[0];
    mlog.batteryVoltages[1] = WPFM_lastBatteryVoltages[1];
    mlog.temperatureOnBoard = WPFM_lastTemperatureOnBoard;
    mlog.alertStatus = WPFM_lastAlertStatusSuppressed;
    mlog.batteryStatus = WPFM_batteryStatus;

    DBG_PRINT("[ALERT STATUS] Raw: %02Xh, Sup: %02Xh", WPFM_lastAlertStatus, WPFM_lastAlertStatusSuppressed);

    // Store in flash memory as mlog
    int stat;
    if (MLOG_IsSwitchedSRAM())
    {
        // Store log into SRAM
        stat = MLOG_putLogOnSRAM(&mlog);
    }
    else
    {
        // Store log into Flash
        stat = MLOG_putLog(&mlog, false);
    }

    if (stat >= 0)
    {
        DBG_PRINT("MLOG_putLog() OK: %06Xh", stat);
    }
    else
    {
        fatal("MLOG_putLog() ERROR: %d", stat);
    }
}

void WPFM_getTemperature()
{
    float temp;
    int stat = 0;
#ifdef DEBUG_DETAIL
    uint32_t t0 = SYS_mSec;
    stat = S5851A_getTemperature(&temp);
    DEBUG_UART_printlnFormat("S5851A: %umS", (unsigned int)(SYS_mSec - t0));
#else
    stat = S5851A_getTemperature(&temp);
#endif // DEBUG_UART
    if (stat == S5851A_ERR_NONE)
    {
        WPFM_lastTemperatureOnBoard = temp * 10.0;
        DBG_PRINT("temp: %.1f", temp);
    }
    else
    {
        DEBUG_UART_printlnFormat("S5851A_getTemperature() error: %d", stat);
    }
}

void WPFM_getBatteryValue()
{
	int stat = 0;
	// Read two external battery voltages
	WPFM_lastBatteryVoltages[0] = WPFM_lastBatteryVoltages[1] = WPFM_MISSING_VALUE_UINT16;
	SENSOR_readExternalBatteryVoltageShurink(&WPFM_lastBatteryVoltages[0], &WPFM_lastBatteryVoltages[1]);
	if (DLC_MatBatCnt >= NUM_TIMES_ACTUALLY_BATT) {
		DBG_PRINT("SENSOR_readExternalBatteryVoltageShurink(): %u/%u", WPFM_lastBatteryVoltages[0], WPFM_lastBatteryVoltages[1]);
		if (DLC_Para.MeasureLog == 0) {
			DEBUG_UART_FLUSH(); APP_delay(10);
		}
		// Check two batteries and auto switch if nessesary
		if ((stat = BATTERY_checkAndSwitchBattery()) != BATTERY_ERR_NONE)
		{
			if (stat == BATTERY_ERR_HALT)
			{
				// Halt due to low voltage in both batteries
				WPFM_halt("Low voltage in both batteries");
			}
		}
		DBG_PRINT("BATTERY: Status %02Xh, USE #%d/RPL #%d",
				WPFM_batteryStatus, WPFM_externalBatteryNumberInUse, WPFM_externalBatteryNumberToReplace);
		if (DLC_Para.MeasureLog == 0) {
			APP_delay(20);
		}
		DLC_MatBatCnt = 0;
	}
}
