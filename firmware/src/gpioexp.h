/*
 * File:    gpioexp.h
 * Author:  Interark Corp.
 * Summary: GPIO expandwer(PCF8574) driver header file.
 * Date:    2022/07/17 (R0)
 * Note:    Refer to datasheet of PCF8754 [SCPS068J-JULY 2001-REVISED MARCH 2015(TI)]
 */

#ifndef GPIOEXP_H
#define	GPIOEXP_H

#ifdef	__cplusplus
extern "C" {
#endif

#include "definitions.h"

// Constants
#define GPIOEXP_I2C_ADDRESS     0x20    // Slave address on A2=0 and A1=0 and A0=0

// Error codes
#define GPIOEXP_ERR_NONE        0       // Success, no error
#define GPIOEXP_ERR_WRITE       (-1)    // i2c write error
#define GPIOEXP_ERR_READ        (-2)    // i2c read error

// Macros
#define GPIOEXP_SET_BIT(pin)        (uint8_t)(0x01 << (pin))
#define GPIOEXP_CLEAR_BIT(pin)      (uint8_t)(~(0x01 << (pin)))

// Functions
extern int GPIOEXP_readPort(uint8_t *port);
extern int GPIOEXP_writePort(uint8_t port);
extern void GPIOEXP_clear(uint8_t pin);
extern void GPIOEXP_set(uint8_t pin);
extern int GPIOEXP_get(uint8_t pin);

#ifdef	__cplusplus
}
#endif

#endif	/* GPIOEXP_H */
