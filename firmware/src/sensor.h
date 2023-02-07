/*
 * File:    sensor.h
 * Author:  Interark Corp.
 * Summary: Analog Sensor control header file.
 * Date:    2022/09/04 (R0)
 * Note:
 */

#ifndef SENSOR_H
#define	SENSOR_H

#ifdef	__cplusplus
extern "C" {
#endif

#include "definitions.h"
#include "app.h"

/*
*   Types
*/
typedef enum {
    SENSOR_KIND_NOT_PRESENT = 0,    // Sensor is not present
    SENSOR_KIND_1_3V = 1,           // Voltage(1-3V) output sensor
    SENSOR_KIND_1_5V = 2,           // Voltage(1-5V) output sensor
    SENSOR_KIND_0_20MA = 3,         // Current(0-20mA) output sensor
    SENSOR_KIND_4_20MA = 4          // Current(4-20mA) output sensor
} SENSOR_KIND;

/*
*   Error codes
*/
#define SENSOR_ERR_NONE             0           // Success (no error)
#define SENSOR_ERR_PARAM            (-1)        // Parameter error
#define SENSOR_ERR_ADC              (-2)        // ADC error
#define SENSOR_ERR_NOT_EXIST        (-10)       // Sensor is not exist

// Channel number
#define SENSOR_CHANNEL_IN1          ADC_POSINPUT_PIN3       // AIN[3]/PB09
#define SENSOR_CHANNEL_IN2          ADC_POSINPUT_PIN4       // AIN[4]/PA04
#define SENSOR_EXTERNAL_BATTERY1    ADC_POSINPUT_PIN0       // AIN[0]/PA02
#define SENSOR_EXTERNAL_BATTERY2    ADC_POSINPUT_PIN2       // AIN[2]/PB08

// Misc.
//#define SENSOR_PRE_ENERGIZATION_TIME_OF_SENSOR     1000     // Time to energize before reading a value from the sensor[mS]
#define SENSOR_PRE_ENERGIZATION_TIME_OF_SENSOR     135     // Time to energize before reading a value from the sensor[mS] íZèk

#define NUM_TIMES_ACTUALLY              10              // The number of times the value is actually read in one measurement (@specify by customer)
#define NUM_TIMES_ACTUALLY_BATT			3				// The number of times the value is actually read battery measurement (@specify by customer)

/*
*   Global functions
*/
extern uint16_t SENSOR_readRawValue(void);
#if 0
extern int SENSOR_readSensorOutput(int sensorNo, float *result_p);
#else
extern int SENSOR_readSensorOutputShurink(float *sensorvalue_p1, float *sensorvalue_p2);
#endif
extern int SENSOR_turnOnSensorCircuit(int sensorNo, bool sensorPower);
extern int SENSOR_turnOffSensorCircuit(int sensorNo);
extern int SENSOR_readExternalBatteryVoltage(int externalBatteryNo, uint16_t *voltage_p);
extern int SENSOR_readExternalBatteryVoltageShurink(uint16_t *voltage_p1, uint16_t *voltage_p2);
extern void SENSOR_updateMeasurementInterval(uint16_t interval);

/*
*   Global variables
*/
extern bool SENSOR_alwaysOnSensorPowers[2];         // Keep the each sensor power always on(true) or not(false)
extern uint8_t	BatteryMeasureTimes;

#ifdef	__cplusplus
}
#endif

#endif	/* SENSOR_H */
