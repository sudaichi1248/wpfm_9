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
#include "Moni.h"
#include "DLCpara.h"
/*
*   Symbols and Constants
*/
#define WAIT_TIME_FOR_EACH_MEASUREMENT  10              // Free time for continuous measurements[mS] (@tune)
#define SHUNT_REGISTANCE                150             // for current output sensor [ohm]

/*
*   Global variables
*/
bool SENSOR_alwaysOnSensorPowers[2] = { false, false };
uint32_t	BatteryValueSum1 = 0, BatteryValueSum2 = 0;

const static float _SENSOR_conversionFactor                = 0.000990000;      // Conversion to voltage factor [V/LSB]
const static float _SENSOR_dividedRatioOfExternalBattery   = 880.0 / 200.0;    // Voltage division ratio: (R1) Corresponded to battery voltage change to 12V
const static float _SENSOR_dividedRatioOfExternalBattery2     = 0.005750; // Voltage division ratio: (R1) Corresponded to battery voltage change to 12V by kamimoto
#ifndef SENSOR_SHURINK
int SENSOR_readSensorOutput(int sensorNo, float *result_p)
{
    DEBUG_UART_printlnFormat("> SENSOR_readSensorOutput(%d,-)", sensorNo);
    *result_p = WPFM_MISSING_VALUE_FLOAT;
#ifdef _TESTTEST
	static uint16_t TestVal = 100;
	static char		TestDir;
#endif
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
    float loLmt,calb1,calb2;
    WPFM_SETTING_PARAMETER *p = &WPFM_settingParameter;
    switch (sensorKind)
    {
        case SENSOR_KIND_NOT_PRESENT:
            // specified sensor is not exist.
            return (SENSOR_ERR_NOT_EXIST);
        case SENSOR_KIND_1_3V:
        case SENSOR_KIND_1_5V:
        case SENSOR_KIND_4_20MA:
            // (1) read raw value using ADC
            rawValue = SENSOR_readRawValue();
            // (2) calculate slope
            slope = ((float)(p->upperLimits[sensorIndex]) - (float)(p->lowerLimits[sensorIndex]))
                    / ((float)(p->calibrationUpperValues[sensorIndex][sensorKindIndex]) - (float)(p->calibrationLowerValues[sensorIndex][sensorKindIndex]));
#ifdef DEBUG_DETAIL1
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
            // (1) read raw value using ADC
#ifndef _TESTTEST
            rawValue = SENSOR_readRawValue();															/* AD生値 */
#else
            rawValue = TestVal;																			/* AD生値 */
			APP_delay(200);DEBUG_UART_printlnFormat("\nTestVal=%d", TestVal );APP_delay(20);
			if( TestDir )
	            TestVal += 5;
            else
    	        TestVal -= 5;
    	    if( TestVal == 0 ){
    	    	TestDir = 1;
    	    }
    	    if( TestVal > 4000 ){
    	    	TestDir = 0;
    	    }
#endif
            loLmt = 0.4;																				/* 下限値 */
            calb1 = p->calibrationUpperValues[sensorIndex][sensorKindIndex];							/* キャリブレーション値上 */
            calb2 = p->calibrationLowerValues[sensorIndex][sensorKindIndex];							/* キャリブレーション値下 */
            // (2) calculate slope
            if( rawValue >= calb2 )
	            slope = ( (float)p->upperLimits[sensorIndex] - loLmt) / ( (float)calb1 - (float)calb2 );
	        else
	        	slope = loLmt/calb2;
#ifdef DEBUG_DETAIL
            DEBUG_UART_printlnFormat("slope=%f", slope);APP_delay(20);
            DEBUG_UART_printlnFormat("upLmt=%.3f", (float)p->upperLimits[sensorIndex]); APP_delay(10);
            DEBUG_UART_printlnFormat("loLmt=%.3f", loLmt); APP_delay(10);
            DEBUG_UART_printlnFormat("calib1=%.3f", calb1); APP_delay(10);
            DEBUG_UART_printlnFormat("calib2=%.3f", calb2); APP_delay(10);
#endif // DEBUG_DETAIL
            // (3) calculate measured value
            result = slope * (float)(rawValue - p->calibrationLowerValues[sensorIndex][sensorKindIndex]) + loLmt;
            DEBUG_UART_printlnFormat("result=%.3f", result);
            break;
        default:
            return (SENSOR_ERR_PARAM);
    }

    *result_p = result;

    DEBUG_UART_printlnFormat("< SENSOR_readSensorOutput(%d,-) OK: %.3f", sensorNo, result);
    return (SENSOR_ERR_NONE);
}
#else	// SENSOR_SHURINK

int SENSOR_readSensorOutputShurink(float *sensorvalue_p1, float *sensorvalue_p2)
{
	uint16_t rawValue1 = WPFM_MISSING_VALUE_UINT16, rawValue2 = WPFM_MISSING_VALUE_UINT16;
	DEBUG_UART_printlnFormat("> SENSOR_readSensorOutputShurink(1/2)");
	uint32_t sum1 = 0, sum2 = 0;

	ADC_Enable();       // -- Start ADC --
	for (int i = 0; i < NUM_TIMES_ACTUALLY; i++) {
		// Sens1
		if (WPFM_settingParameter.sensorKinds[0] != SENSOR_KIND_NOT_PRESENT) {
			ADC_ChannelSelect(SENSOR_CHANNEL_IN1, ADC_NEGINPUT_GND);
			ADC_ConversionStart();
			while (! ADC_ConversionStatusGet())
				;
			sum1 += ADC_ConversionResultGet();
			// APP_delay(WAIT_TIME_FOR_EACH_MEASUREMENT);     // wait a little (@tune)
			SYSTICK_DelayMs(WAIT_TIME_FOR_EACH_MEASUREMENT);
		}
		// Sens2
		if (WPFM_settingParameter.sensorKinds[1] != SENSOR_KIND_NOT_PRESENT) {
			ADC_ChannelSelect(SENSOR_CHANNEL_IN2, ADC_NEGINPUT_GND);
			ADC_ConversionStart();
			while (! ADC_ConversionStatusGet())
				;
			sum2 += ADC_ConversionResultGet();
			SYSTICK_DelayMs(WAIT_TIME_FOR_EACH_MEASUREMENT);
		}
	}
	ADC_Disable();      // -- STOP ADC --

	for (int i = 0; i < 2; i++) {
		int sensorKind = WPFM_settingParameter.sensorKinds[i];
		DEBUG_UART_printlnFormat("sensorIndex=%d,sensorKind=%d", i, sensorKind);
		if (sensorKind == SENSOR_KIND_NOT_PRESENT) {
			DEBUG_UART_printlnFormat("SENSOR_readSensorOutputShurink(%d) THROUGH: %d", i + 1, SENSOR_ERR_NOT_EXIST);
			continue;
		} else {
			if (i == 0) {
				rawValue1 = ((float)sum1 / (float)NUM_TIMES_ACTUALLY);
				DEBUG_UART_printlnFormat("readRawValue1 OK: %u", rawValue1);
			} else {
				rawValue2 = ((float)sum2 / (float)NUM_TIMES_ACTUALLY);
				DEBUG_UART_printlnFormat("readRawValue2 OK: %u", rawValue2);
			}
		}

		int sensorKindIndex = sensorKind - 1;
		float slope = 0.0, result = 0.0;
		WPFM_SETTING_PARAMETER *p = &WPFM_settingParameter;
		bool not_present = false;
		switch (sensorKind)
		{
			case SENSOR_KIND_NOT_PRESENT:
				not_present = true;
				break;

			case SENSOR_KIND_1_3V:
			case SENSOR_KIND_1_5V:
				// (1) calculate slope
				slope = ((float)(p->upperLimits[i]) - (float)(p->lowerLimits[i]))
						/ ((float)(p->calibrationUpperValues[i][sensorKindIndex]) - (float)(p->calibrationLowerValues[i][sensorKindIndex]));
#ifdef DEBUG_DETAIL
				DEBUG_UART_printlnFormat("slope=%f", slope);
				DEBUG_UART_printlnFormat("upperLimit=%.3f", (float)p->upperLimits[i]); APP_delay(10);
				DEBUG_UART_printlnFormat("lowerLimit=%.3f", (float)p->lowerLimits[i]); APP_delay(10);
				DEBUG_UART_printlnFormat("calibrationUpperValue=%.3f", (float)p->calibrationUpperValues[i][sensorKindIndex]); APP_delay(10);
				DEBUG_UART_printlnFormat("calibrationLowerValue=%.3f", (float)p->calibrationLowerValues[i][sensorKindIndex]); APP_delay(10);
#endif // DEBUG_DETAIL
				// (2) calculate measured value
				if (i == 0) {
					result = slope * (float)(rawValue1 - p->calibrationLowerValues[i][sensorKindIndex]) + (float)(p->lowerLimits[i]);
				} else {
					result = slope * (float)(rawValue2 - p->calibrationLowerValues[i][sensorKindIndex]) + (float)(p->lowerLimits[i]);
				}
				DEBUG_UART_printlnFormat("result=%.3f", result);
				break;

			case SENSOR_KIND_0_20MA:
			case SENSOR_KIND_4_20MA:
				// (1) calculate slope
				slope = ((float)(p->upperLimits[i]) - (float)(p->lowerLimits[i]))
						/ ((float)(p->calibrationUpperValues[i][sensorKindIndex]) - (float)(p->calibrationLowerValues[i][sensorKindIndex]));
				DEBUG_UART_printlnFormat("slope=%.3f", slope);
				// (2) calculate measured value
				if (i == 0) {
					result = slope * (float)(rawValue1 - p->calibrationLowerValues[i][sensorKindIndex]) + (float)(p->lowerLimits[i]);
				} else {
					result = slope * (float)(rawValue2 - p->calibrationLowerValues[i][sensorKindIndex]) + (float)(p->lowerLimits[i]);
				}
				DEBUG_UART_printlnFormat("result=%.3f", result);
				break;

			default:
				return (SENSOR_ERR_PARAM);
		}
		DEBUG_UART_printlnFormat("SENSOR_readSensorOutputShurink(%d) OK: %.3f", i + 1, result);

		if (result > WPFM_settingParameter.upperLimits[i]) {	// 上限／下限で丸め込み
			result = WPFM_settingParameter.upperLimits[i];
		} else if (result < WPFM_settingParameter.lowerLimits[i]) {
			result = WPFM_settingParameter.lowerLimits[i];
		}
		if (not_present == false) {	// 未使用でない場合
			if (i == 0) {	// ch1
				*sensorvalue_p1 = result;
			} else {		// ch2
				*sensorvalue_p2 = result;
			}
		}

		// Power off sensor power if necessary
		if (! SENSOR_alwaysOnSensorPowers[i])
		{
			SENSOR_turnOffSensorCircuit(i + 1);
		}
	}
	return (SENSOR_ERR_NONE);
}
#endif	// SENSOR_SHURINK

int SENSOR_readExternalBatteryVoltage(int externalNo, uint16_t *voltage_p)
{
	float result;
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
    if( DLC_Para.BatCarivFlg == 0 ){
	    result = SENSOR_readRawValue() * _SENSOR_dividedRatioOfExternalBattery2 ;
//        putst("☆");putdecw( (int)(result *1000));putcrlf();
    }
	else {
	    result = SENSOR_readRawValue() * _SENSOR_dividedRatioOfExternalBattery * _SENSOR_conversionFactor;
	    putst("V.=");putdech( (int)(result *1000));putcrlf();
	}
    *voltage_p = (uint16_t)(result * 1000.0);      // Convert Volt to milli Volt
    DEBUG_UART_printlnFormat("< SENSOR_readExternalBatteryVoltage(%d,-) OK: %.3f", externalNo, result);
    return (SENSOR_ERR_NONE);
}
#if 0
int SENSOR_readExternalBatteryVoltageShurink(uint16_t *voltage_p1, uint16_t *voltage_p2)
{
	float result1, result2;
	uint16_t rawValue1, rawValue2;
	DEBUG_UART_printlnFormat("> SENSOR_readExternalBatteryVoltageShurink(1/2,-)");
	*voltage_p1 = *voltage_p2 = WPFM_MISSING_VALUE_UINT16;

	ADC_Enable();       // -- Start ADC --
	// ch1
	ADC_ChannelSelect(SENSOR_EXTERNAL_BATTERY1, ADC_NEGINPUT_GND);
	ADC_ConversionStart();
	while (! ADC_ConversionStatusGet())
		;
	BatteryValueSum1 += ADC_ConversionResultGet();
	// ch2
	ADC_ChannelSelect(SENSOR_EXTERNAL_BATTERY2, ADC_NEGINPUT_GND);
	ADC_ConversionStart();
	while (! ADC_ConversionStatusGet())
		;
	BatteryValueSum2 += ADC_ConversionResultGet();
	ADC_Disable();      // -- STOP ADC --

	if (DLC_MatBatCnt >= NUM_TIMES_ACTUALLY_BATT) {
		rawValue1 = ((float)BatteryValueSum1 / (float)NUM_TIMES_ACTUALLY_BATT);
		rawValue2 = ((float)BatteryValueSum2 / (float)NUM_TIMES_ACTUALLY_BATT);
		DEBUG_UART_printlnFormat("readRawValue1 OK: %u", rawValue1);
		DEBUG_UART_printlnFormat("readRawValue2 OK: %u", rawValue2);

		if( DLC_Para.BatCarivFlg == 0 ) {
			result1 = rawValue1 * _SENSOR_dividedRatioOfExternalBattery2 ;
			result2 = rawValue2 * _SENSOR_dividedRatioOfExternalBattery2 ;
		}
		else {
			result1 = rawValue1 * _SENSOR_dividedRatioOfExternalBattery * _SENSOR_conversionFactor;
			result2 = rawValue2 * _SENSOR_dividedRatioOfExternalBattery * _SENSOR_conversionFactor;
		}
		*voltage_p1 = (uint16_t)(result1 * 1000.0);	// Convert Volt to milli Volt
		*voltage_p2 = (uint16_t)(result2 * 1000.0);	// Convert Volt to milli Volt
		DEBUG_UART_printlnFormat("< SENSOR_readExternalBatteryVoltageShurink(1,-) OK: %.3f", result1);
		DEBUG_UART_printlnFormat("< SENSOR_readExternalBatteryVoltageShurink(2,-) OK: %.3f", result2);
		BatteryValueSum1 = BatteryValueSum2 = 0;
	}
	return (SENSOR_ERR_NONE);
}
#endif
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
#if 0	// 常時ONは無し
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
#else
		SENSOR_turnOffSensorCircuit(sensorIndex + 1);
#endif
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
