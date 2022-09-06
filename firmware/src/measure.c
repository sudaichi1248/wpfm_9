/*
 * File:    measure.c
 * Author:  Interark Corp.
 * Summary: WPFM(code name "DLC_04") project common definition file.
 * Date:    2022/09/04 (R0)
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

/*
*   Symbols
*/

/*
*   Local variables and functions
*/
static void _SENSOR_storeLog(uint32_t occurrenceTime, uint32_t mSec);


 /*
 *   measureRegularly() -
 */
void WPFM_measureRegularly(bool justMeasure)
{
    uint32_t start = SYS_mSec, occurrenceTime = RTC_now;
    int stat = 0;

    RTC_DATETIME dt;
    RTC_getDatetime(&dt);
    DEBUG_UART_printlnFormat("\n-- START MEASUREMENT(20%02d/%02d/%02d %02d:%02d:%02d.%03lu) --",
            dt.year, dt.month, dt.day, dt.hour, dt.minute, dt.second, SYS_mSec);

    // Start measument of temperature here baecause of too slow
    S5851A_startMeasurement();

    // Reading a sensor(s)
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
                SYSTICK_DelayMs(SENSOR_PRE_ENERGIZATION_TIME_OF_SENSOR);    // APP_delay(SENSOR_PRE_ENERGIZATION_TIME_OF_SENSOR);
            }
            else
            {
                SENSOR_turnOnSensorCircuit(sensorIndex + 1, false);
                SYSTICK_DelayMs(10);        // wait a little
            }
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
        WPFM_lastMeasuredValues[sensorIndex] = value;

        // Power off sensor power if necessary
        if (! SENSOR_alwaysOnSensorPowers[sensorIndex])
        {
            SENSOR_turnOffSensorCircuit(sensorIndex + 1);
        }
    }

    // Read two external battery voltages
    WPFM_lastBatteryVoltages[0] = WPFM_lastBatteryVoltages[1] = WPFM_MISSING_VALUE_UINT16;
    SENSOR_readExternalBatteryVoltage(1, &WPFM_lastBatteryVoltages[0]);
    SENSOR_readExternalBatteryVoltage(2, &WPFM_lastBatteryVoltages[1]);
    DEBUG_UART_printlnFormat("SENSOR_readExternalBatteryVoltage(): %u/%u", WPFM_lastBatteryVoltages[0], WPFM_lastBatteryVoltages[1]);
    DEBUG_UART_FLUSH(); APP_delay(10);

    // Check two batteries and auto switch if nessesary
    if ((stat = BATTERY_checkAndSwitchBattery()) != BATTERY_ERR_NONE)
    {
        if (stat == BATTERY_ERR_HALT)
        {
            // Halt due to low voltage in both batteries
            WPFM_halt("Low voltage in both batteries");
        }
    }
    DEBUG_UART_printlnFormat("BATTERY: Status %02Xh, USE #%d/RPL #%d",
            WPFM_batteryStatus, WPFM_externalBatteryNumberInUse, WPFM_externalBatteryNumberToReplace);
    APP_delay(20);

    // Read temperature sensor on board
    float temp;
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

    DEBUG_UART_printlnFormat("+alertStaus Raw: %02Xh, Sup: %02Xh", WPFM_lastAlertStatus, WPFM_lastAlertStatusSuppressed);

    // Store in flash memory as mlog
    int stat;
    if (MLOG_IsSwitchedSRAM())
    {
        // Store log into SRAM
 //       stat = MLOG_putLogOnSRAM(&mlog);
    }
    else
    {
        // Store log into Flash
        stat = MLOG_putLog(&mlog);
    }

    if (stat >= 0)
    {
        DEBUG_UART_printlnFormat("MLOG_putLog() OK: %06Xh", stat);
    }
    else
    {
//        fatal("MLOG_putLog() ERROR: %d", stat);
    }
}
