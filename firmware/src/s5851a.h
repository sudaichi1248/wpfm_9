/*
 * File:    s5851a.h
 * Author:  Interark Corp.
 * Summary: Digital Temperature Sensor (S5851A) driver header file.
 * Date:    2022/07/15 (R0)
 * Note:    Refer to S5851A datasheet(Rev.2.2_01)
 */

#ifndef S5851A_H
#define	S5851A_H

#ifdef	__cplusplus
extern "C" {
#endif

#include "definitions.h"
#include "app.h"

// constants
#define S5851A_I2C_ADDRESS      0x48    // Slave address on A1=0 and A0=0

/*
*   Types
*/
typedef enum {
    S5851A_MODE_CONTINOUS = 0x00,       // Continue to measure
    S5851A_MODE_SHUTDOWN  = 0x01,       // Shut down the S5851A (for reduce current consumption)
    S5851A_MODE_ONESHUT   = 0x80        // Measure only once at a time(call "one shut mode")
} S5851A_MODE;

// Error codes
#define S5851A_ERR_NONE         0       // Success, no error
#define S5851A_ERR_WRITE        (-1)    // i2c write error
#define S5851A_ERR_READ         (-2)    // i2c read error
#define S5851A_ERR_TIMEOUT      (-3)    // temperature measurement process times out(S5851A_MODE_SHUTDOWN only)
#define S5851A_ERR_BUG          (-9)    // implementation error

// Functions
extern int S5851A_setMode(S5851A_MODE mode);    // Initialize with mode
extern int S5851A_getTemperature(float *temp_p);    // Get temperature [C degree]
extern int S5851A_startMeasurement(void);       // Start to measure temperature at shuto down mode


#ifdef	__cplusplus
}
#endif

#endif	/* S5851A_H */
