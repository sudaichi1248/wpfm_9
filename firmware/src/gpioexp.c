/*
 * File:    gpioexp.c
 * Author:  Interark Corp.
 * Summary: GPIO expandwer(PCF8574) driver implementation file.
 * Date:    2022/07/15 (R0)
 * Note:    Refer to datasheet of PCF8754 [SCPS068J-JULY 2001-REVISED MARCH 2015(TI)]
 */

#include <stdio.h>
#include "util.h"
#include "gpioexp.h"


int GPIOEXP_readPort(uint8_t *port_p)
{
    if (SERCOM3_I2C_Read(GPIOEXP_I2C_ADDRESS, port_p, 1))
    {
        while (SERCOM3_I2C_IsBusy())
            ;
        UTIL_delayMicros(30);
    }
    else
    {
        return (GPIOEXP_ERR_READ);
    }

    return (GPIOEXP_ERR_NONE);
}

int GPIOEXP_writePort(uint8_t port)
{
    if (SERCOM3_I2C_Write(GPIOEXP_I2C_ADDRESS, &port, 1))
    {
        while (SERCOM3_I2C_IsBusy())
            ;
        UTIL_delayMicros(30);
    }
    else
    {
        return (GPIOEXP_ERR_WRITE);
    }

    return (GPIOEXP_ERR_NONE);
}

void GPIOEXP_clear(uint8_t pin)
{
    uint8_t port = 0;
    if (GPIOEXP_readPort(&port) == GPIOEXP_ERR_NONE)
    {
        port &= GPIOEXP_CLEAR_BIT(pin);
        GPIOEXP_writePort(port);
    }
}

void GPIOEXP_set(uint8_t pin)
{
    uint8_t port = 0;
    if (GPIOEXP_readPort(&port) == GPIOEXP_ERR_NONE)
    {
        port |= GPIOEXP_SET_BIT(pin);
        GPIOEXP_writePort(port);
    }
}

int GPIOEXP_get(uint8_t pin)
{
    uint8_t port = 0;
    if (GPIOEXP_readPort(&port) == GPIOEXP_ERR_NONE)
    {
        return (port & GPIOEXP_SET_BIT(pin));
    }

    return (GPIOEXP_ERR_READ);
}
