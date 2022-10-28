/*
 * File:    sensor.c
 * Author:  Interark Corp.
 * Summary: Analog Sensor control implementation file.
 * Date:    2022/09/04 (R0)
 *          2022/10/17 (R1) Corresponded to battery voltage change to 12V
 * Note:    Points to be adjusted where ""@tune" is listed
 */

//#define DEBUG_UART
//#define DEBUG_DETAIL

#include "debug.h"
#include "wpfm.h"
#include "util.h"
#include "gpioexp.h"
#include "sensor.h"
#include "rtc.h"

/*
*   Symbols and Constants
*/
#define NUM_TIMES_ACTUALLY              10              // The number of times the value is actually read in one measurement (@specify by customer)
#define WAIT_TIME_FOR_EACH_MEASUREMENT  10              // Free time for continuous measurements[mS] (@tune)
#define SHUNT_REGISTANCE                150             // for current output sensor [ohm]

/*
*   Global variables
*/
bool SENSOR_alwaysOnSensorPowers[2] = { false, false };

const static float _SENSOR_conversionFactor                = 0.000990000;      // Conversion to voltage factor [V/LSB]
const static float _SENSOR_dividedRatioOfExternalBattery   = 880.0 / 200.0;    // Voltage division ratio: (R1) Corresponded to battery voltage change to 12V


int SENSOR_readSensorOutput(int sensorNo, float *result_p)
{
    DEBUG_UART_printlnFormat("> SENSOR_readSensorOutput(%d,-)", sensorNo);
    *result_p = WPFM_MISSING_VALUE_FLOAT;

    int sensorIndex;
    switch (sensorNo)
    {
        case 1:
            ADC_ChannelSelect(SENSOR_CHANNEL_IN1, ADC_NEGINPUT_GND);
            sensorIndex = 0;
            break;
        case 2:
            ADC_ChannelSelect(SENSOR_CHANNEL_IN2, ADC_NEGINPUT_GND);
            sensorIndex = 1;
            break;
        default:
            return (SENSOR_ERR_PARAM);
    }
    int sensorKind = WPFM_settingParameter.sensorKinds[sensorIndex];
    DEBUG_UART_printlnFormat("sensorIndex=%d,sensorKind=%d", sensorIndex, sensorKind);

    int sensorKindIndex = sensorKind - 1;
    uint16_t rawValue;
    float slope = 0.0, result = 0.0;
    WPFM_SETTING_PARAMETER *p = &WPFM_settingParameter;
    switch (sensorKind)
    {
        case SENSOR_KIND_NOT_PRESENT:
            // specified sensor is not exist.
            return (SENSOR_ERR_NOT_EXIST);

        case SENSOR_KIND_1_3V:
        case SENSOR_KIND_1_5V:
            // (1) read raw value using ADC
            rawValue = SENSOR_readRawValue();
            // (2) calculate slope
            slope = ((float)(p->upperLimits[sensorIndex]) - (float)(p->lowerLimits[sensorIndex]))
                    / ((float)(p->calibrationUpperValues[sensorIndex][sensorKindIndex]) - (float)(p->calibrationLowerValues[sensorIndex][sensorKindIndex]));
#ifdef DEBUG_DETAIL
            DEBUG_UART_printlnFormat("slope=%f", slope);
            DEBUG_UART_printlnFormat("upperLimit=%.3f", (float)p->upperLimits[sensorIndex]); APP_delay(10);
            DEBUG_UART_printlnFormat("lowerLimit=%.3f", (float)p->lowerLimits[sensorIndex]); APP_delay(10);
            DEBUG_UART_printlnFormat("calibrationUpperValue=%.3f", (float)p->calibrationUpperValues[sensorIndex][sensorKindIndex]); APP_delay(10);
            DEBUG_UART_printlnFormat("calibrationLowerValue=%.3f", (float)p->calibrationLowerValues[sensorIndex][sensorKindIndex]); APP_delay(10);
#endif // DEBUG_DETAIL
            // (3) calculate measured value
            result = slope * (float)(rawValue - p->calibrationLowerValues[sensorIndex][sensorKindIndex]) + (float)(p->lowerLimits[sensorIndex]);
            DEBUG_UART_printlnFormat("result=%.3f", result);
            break;

        case SENSOR_KIND_0_20MA:
        case SENSOR_KIND_4_20MA:
            // (1) read raw value using ADC
            rawValue = SENSOR_readRawValue();
            // (2) calculate slope
            slope = ((float)(p->upperLimits[sensorIndex]) - (float)(p->lowerLimits[sensorIndex]))
                    / ((float)(p->calibrationUpperValues[sensorIndex][sensorKindIndex]) - (float)(p->calibrationLowerValues[sensorIndex][sensorKindIndex]));
            DEBUG_UART_printlnFormat("slope=%.3f", slope);
            // (3) calculate measured value
            result = slope * (float)(rawValue - p->calibrationLowerValues[sensorIndex][sensorKindIndex]) + (float)(p->lowerLimits[sensorIndex]);
            DEBUG_UART_printlnFormat("result=%.3f", result);
            break;

        default:
            return (SENSOR_ERR_PARAM);
    }

    *result_p = result;

    DEBUG_UART_printlnFormat("< SENSOR_readSensorOutput(%d,-) OK: %.3f", sensorNo, result);
    return (SENSOR_ERR_NONE);
}

int SENSOR_readExternalBatteryVoltage(int externalNo, uint16_t *voltage_p)
{
    DEBUG_UART_printlnFormat("> SENSOR_readExternalBatteryVoltage(%d,-)", externalNo);
    *voltage_p = WPFM_MISSING_VALUE_UINT16;

    switch (externalNo)
    {
        case 1:
            ADC_ChannelSelect(SENSOR_EXTERNAL_BATTERY1, ADC_NEGINPUT_GND);
            break;
        case 2:
            ADC_ChannelSelect(SENSOR_EXTERNAL_BATTERY2, ADC_NEGINPUT_GND);
            break;
        default:
            return (SENSOR_ERR_PARAM);
    }

    float result = SENSOR_readRawValue() * _SENSOR_dividedRatioOfExternalBattery * _SENSOR_conversionFactor;
    *voltage_p = (uint16_t)(result * 1000.0);      // Convert Volt to milli Volt

    DEBUG_UART_printlnFormat("< SENSOR_readExternalBatteryVoltage(%d,-) OK: %.3f", externalNo, result);
    return (SENSOR_ERR_NONE);
}

int SENSOR_turnOnSensorCircuit(int sensorNo, bool sensorPowered)
{
    DEBUG_UART_printlnFormat("SENSOR_turnOnSensorCircuit(%d,%d)", sensorNo, sensorPowered);

    switch (sensorNo)
    {
        case 1:
            GPIOEXP_set(WPFM_GPIO_CH1_PWR);
            if (sensorPowered)
            {
                GPIOEXP_set(WPFM_GPIO_CH1_EXT_PWR);
            }
            break;
        case 2:
            GPIOEXP_set(WPFM_GPIO_CH2_PWR);
            if (sensorPowered)
            {
                GPIOEXP_set(WPFM_GPIO_CH2_EXT_PWR);
            }
            break;
        default:
            return (SENSOR_ERR_PARAM);
    }

    return (SENSOR_ERR_NONE);
}

int SENSOR_turnOffSensorCircuit(int sensorNo)
{
    DEBUG_UART_printlnFormat("SENSOR_turnOffSensorCircuit(%d)", sensorNo);

    switch (sensorNo)
    {
        case 1:
            GPIOEXP_clear(WPFM_GPIO_CH1_PWR);
            GPIOEXP_clear(WPFM_GPIO_CH1_EXT_PWR);
            break;
        case 2:
            GPIOEXP_clear(WPFM_GPIO_CH2_PWR);
            GPIOEXP_clear(WPFM_GPIO_CH2_EXT_PWR);
            break;
        default:
            return (SENSOR_ERR_PARAM);
    }

    return (SENSOR_ERR_NONE);
}

void SENSOR_updateMeasurementInterval(uint16_t interval)
{
    // Always update regardless of previous settings
    WPFM_measurementInterval = interval;

    for (int sensorIndex = 0; sensorIndex < 2; sensorIndex++)
    {
        uint8_t sensorKind = WPFM_settingParameter.sensorKinds[sensorIndex];
        switch (sensorKind)
        {
            case SENSOR_KIND_NOT_PRESENT:
                SENSOR_turnOffSensorCircuit(sensorIndex + 1);
                SENSOR_alwaysOnSensorPowers[sensorIndex] = false;
                break;

            case SENSOR_KIND_1_3V:
                if (interval < WPFM_THRESHOLD_FOR_SENSOR_POWER_CONTROL)
                {
                    SENSOR_turnOnSensorCircuit(sensorIndex + 1, true);
                    SENSOR_alwaysOnSensorPowers[sensorIndex] = true;
                }
                else
                {
                    SENSOR_turnOffSensorCircuit(sensorIndex + 1);
                    SENSOR_alwaysOnSensorPowers[sensorIndex] = false;
                }
                break;

            case SENSOR_KIND_1_5V:
            case SENSOR_KIND_0_20MA:
            case SENSOR_KIND_4_20MA:
                SENSOR_turnOnSensorCircuit(sensorIndex + 1, false);
                SENSOR_alwaysOnSensorPowers[sensorIndex] = true;
                break;

            default:
                break;
        }
    }
}

uint16_t SENSOR_readRawValue(void)
{
    ADC_Enable();       // -- Start ADC --

    uint32_t sum = 0;
    for (int i = 0; i < NUM_TIMES_ACTUALLY; i++)
    {
        ADC_ConversionStart();
        while (! ADC_ConversionStatusGet())
            ;
        sum += ADC_ConversionResultGet();

        // APP_delay(WAIT_TIME_FOR_EACH_MEASUREMENT);     // wait a little (@tune)
        SYSTICK_DelayMs(WAIT_TIME_FOR_EACH_MEASUREMENT);
    }

    ADC_Disable();      // -- STOP ADC --
    uint16_t rawValue = ((float)sum / (float)NUM_TIMES_ACTUALLY);
    DEBUG_UART_printlnFormat("SENSOR_readRawValue() OK: %u", rawValue);

    return (rawValue);
}
