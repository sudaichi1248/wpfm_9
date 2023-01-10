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
#include "Eventlog.h"

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
    uint32_t start = SYS_mSec, occurrenceTime = RTC_now, battery_readtime;
    int stat = 0;
	uint32_t start_tick = SYS_tick;
	bool kind_1_3v = false;

    RTC_DATETIME dt;
    RTC_getDatetime(&dt);
    DEBUG_UART_printlnFormat("\n-- START MEASUREMENT(20%02d/%02d/%02d %02d:%02d:%02d.%03lu) --",
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

    // Read two external battery voltages
	start_tick = SYS_tick;
    WPFM_lastBatteryVoltages[0] = WPFM_lastBatteryVoltages[1] = WPFM_MISSING_VALUE_UINT16;
    SENSOR_readExternalBatteryVoltage(1, &WPFM_lastBatteryVoltages[0]);
    SENSOR_readExternalBatteryVoltage(2, &WPFM_lastBatteryVoltages[1]);
    DEBUG_UART_printlnFormat("SENSOR_readExternalBatteryVoltage(): %u/%u", WPFM_lastBatteryVoltages[0], WPFM_lastBatteryVoltages[1]);
    DEBUG_UART_FLUSH(); APP_delay(10);
#if 0
	if (DLCMatIsCom()) {	// í êMíÜÇ≈Ç»Ç¢
#endif
	    // Check two batteries and auto switch if nessesary
	    if ((stat = BATTERY_checkAndSwitchBattery()) != BATTERY_ERR_NONE)
	    {
	        if (stat == BATTERY_ERR_HALT)
	        {
	            // Halt due to low voltage in both batteries
	            WPFM_halt("Low voltage in both batteries");
	        }
	    }
#if 0
	} else {
		DEBUG_UART_printlnFormat("SKIP because communication now.");
	}
#endif
    DEBUG_UART_printlnFormat("BATTERY: Status %02Xh, USE #%d/RPL #%d",
            WPFM_batteryStatus, WPFM_externalBatteryNumberInUse, WPFM_externalBatteryNumberToReplace);
    APP_delay(20);
	battery_readtime = SYS_tick - start_tick;

	// Turn on wait
	if (kind_1_3v == true) {
		if (battery_readtime < SENSOR_PRE_ENERGIZATION_TIME_OF_SENSOR) {
			SYSTICK_DelayMs(SENSOR_PRE_ENERGIZATION_TIME_OF_SENSOR - battery_readtime);    // APP_delay(SENSOR_PRE_ENERGIZATION_TIME_OF_SENSOR);
		}
	}

    // Reading a sensor(s)
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
    DEBUG_UART_printlnFormat("-- END MEASUREMENT(%02d:%02d:%02d.%03lu) --\n", dt.hour, dt.minute, dt.second, SYS_mSec);

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

    DEBUG_UART_printlnFormat("[ALERT STATUS] Raw: %02Xh, Sup: %02Xh", WPFM_lastAlertStatus, WPFM_lastAlertStatusSuppressed);

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
        DEBUG_UART_printlnFormat("MLOG_putLog() OK: %06Xh", stat);
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
        DEBUG_UART_printlnFormat("temp: %.1f", temp);
    }
    else
    {
        DEBUG_UART_printlnFormat("S5851A_getTemperature() error: %d", stat);
    }
}
