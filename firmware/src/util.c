/*
 * File:    util.c
 * Author:  Interark Corp.
 * Summary: WPFM(code name "DLC_04") project utility implementation file.
 * Date:    2022/08/13 (R0)
 * Note:    use TC3 for LED1 blinking, use TC4 for EXT1_LED and EXT2_LED blinking
 */

#define DEBUG_UART

#include <stdio.h>
#include "debug.h"
#include "util.h"
#include "wpfm.h"
#include "gpioexp.h"

// Local variables
static volatile uint32_t _UTIL_blinkCountLED1 = 0;
static volatile uint32_t _UTIL_blinkCountEXT1LED = 0;
static volatile uint32_t _UTIL_blinkCountEXT2LED = 0;

// Local functions
static void _UTIL_ISR_toggleLED1(TC_TIMER_STATUS status, uintptr_t context);
static void _UTIL_ISR_toggleEXT1LED(TC_TIMER_STATUS status, uintptr_t context);
static void _UTIL_ISR_toggleEXT2LED(TC_TIMER_STATUS status, uintptr_t context);
static void _UTIL_ISR_toggleEXT1AND2LED(TC_TIMER_STATUS status, uintptr_t context);


void UTIL_delayMicros(uint32_t time)
{
    static uint16_t dummy[4];
    volatile int i;

    while (time > 0)
    {
        for (i = 0; i < 3; i++)
            dummy[i % 4] = (uint8_t)i;
        time--;
    }
    (void)dummy[0];
}

float UTIL_map(float value, float lowerFrom, float upperFrom, float lowerTo, float upperTo)
{
    if (value > upperFrom)
        value = upperFrom;
    else if (value < lowerFrom)
        value = lowerFrom;

    float mappedValue = (((upperTo - lowerTo) / (upperFrom - lowerFrom)) * value);

    return (mappedValue);
}

void UTIL_setLED1(void)
{
    uint8_t port = 0;
    GPIOEXP_readPort(&port);
    port |= GPIOEXP_SET_BIT(WPFM_GPIO_LED1);
    GPIOEXP_writePort(port);
}

void UTIL_clearLED1(void)
{
    uint8_t port = 0;
    GPIOEXP_readPort(&port);
    port &= GPIOEXP_CLEAR_BIT(WPFM_GPIO_LED1);
    GPIOEXP_writePort(port);
}

void UTIL_toggleLED1(void)
{
    uint8_t port = 0;
    GPIOEXP_readPort(&port);
    port ^= GPIOEXP_SET_BIT(WPFM_GPIO_LED1);
    GPIOEXP_writePort(port);
}

void UTIL_startBlinkLED1(uint32_t count)
{
    _UTIL_blinkCountLED1 = count * 2;
    TC3_TimerCallbackRegister(_UTIL_ISR_toggleLED1, (uintptr_t)0);
    TC3_TimerStart();
}

void UTIL_stopBlinkLED1(void)
{
    TC3_TimerStop();
}

void UTIL_setEXT1LED(void)
{
    uint8_t port = 0;
    GPIOEXP_readPort(&port);
    port |= GPIOEXP_SET_BIT(WPFM_GPIO_EXT1_LED);
    GPIOEXP_writePort(port);
}

void UTIL_clearEXT1LED(void)
{
    uint8_t port = 0;
    GPIOEXP_readPort(&port);
    port &= GPIOEXP_CLEAR_BIT(WPFM_GPIO_EXT1_LED);
    GPIOEXP_writePort(port);
}

void UTIL_toggleEXT1LED(void)
{
    uint8_t port = 0;
    GPIOEXP_readPort(&port);
    port ^= GPIOEXP_SET_BIT(WPFM_GPIO_EXT1_LED);
    GPIOEXP_writePort(port);
}

void UTIL_startBlinkEXT1LED(void)
{
    _UTIL_blinkCountEXT1LED = 0;
    TC4_TimerCallbackRegister(_UTIL_ISR_toggleEXT1LED, (uintptr_t)0);
    TC4_TimerStart();
}

void UTIL_stopBlinkEXT1LED(void)
{
    TC4_TimerStop();
    UTIL_setEXT1LED();
}

void UTIL_setEXT2LED(void)
{
    uint8_t port = 0;
    GPIOEXP_readPort(&port);
    port |= GPIOEXP_SET_BIT(WPFM_GPIO_EXT2_LED);
    GPIOEXP_writePort(port);
}

void UTIL_clearEXT2LED(void)
{
    uint8_t port = 0;
    GPIOEXP_readPort(&port);
    port &= GPIOEXP_CLEAR_BIT(WPFM_GPIO_EXT2_LED);
    GPIOEXP_writePort(port);
}

void UTIL_toggleEXT2LED(void)
{
    uint8_t port = 0;
    GPIOEXP_readPort(&port);
    port ^= GPIOEXP_SET_BIT(WPFM_GPIO_EXT2_LED);
    GPIOEXP_writePort(port);
}

void UTIL_startBlinkEXT2LED(void)
{
    _UTIL_blinkCountEXT2LED = 0;
    TC4_TimerCallbackRegister(_UTIL_ISR_toggleEXT2LED, (uintptr_t)0);
    TC4_TimerStart();
}

void UTIL_stopBlinkEXT2LED(void)
{
    TC4_TimerStop();
    UTIL_setEXT2LED();
}

void UTIL_startBlinkEXT1AND2LED(void)
{
    _UTIL_blinkCountEXT2LED = 0;
    TC4_TimerCallbackRegister(_UTIL_ISR_toggleEXT1AND2LED, (uintptr_t)0);
    TC4_TimerStart();
}

void UTIL_stopBlinkEXT1AND2LED(void)
{
    TC4_TimerStop();
    UTIL_setEXT1LED();
    UTIL_setEXT2LED();
}

bool UTIL_hasConnectedUSB(void)
{
    return (VBUS_CHECK_Get());
}

int UTIL_checkblinkCountLED1(void)
{
    return (_UTIL_blinkCountLED1);
}

void fatal(const char *fmt, int info)
{
    DEBUG_UART_printlnFormat(fmt, info);

    uint32_t start = SYS_mSec;
    while (SYS_mSec - start < UTIL_FATAL_BLINK_TIME)
    {
        UTIL_clearLED1();
        UTIL_delayMicros(200000);
        UTIL_setLED1();
        UTIL_delayMicros(200000);
    }
}

WPFM_OPERATION_MODE UTIL_getPowerModeSW(void)
{
    WPFM_OPERATION_MODE mode;
    if (PWR_MODE_Get() == 1)
    {
        mode = WPFM_OPERATION_MODE_MEASUREMENT;
    }
#ifdef BOARD_PROTOTYPE2
    else if (nV2GD_Get() == 1)
    {
        mode = WPFM_OPERATION_MODE_NON_MEASUREMENT;
    }
    else
    {
        mode = WPFM_POWEROFF_MODE;
    }
#else
    else
    {
        mode = WPFM_OPERATION_MODE_NON_MEASUREMENT;
    }
#endif

    return (mode);
}

static void _UTIL_ISR_toggleLED1(TC_TIMER_STATUS status, uintptr_t context)
{
    UTIL_toggleLED1();
    if (--_UTIL_blinkCountLED1 == 0)
    {
        TC3_TimerStop();
    }
}

static void _UTIL_ISR_toggleEXT1LED(TC_TIMER_STATUS status, uintptr_t context)
{
    switch (_UTIL_blinkCountEXT1LED)
    {
        case 0:
        case 1:
        case 2:
        case 3:
            UTIL_toggleEXT1LED();
            break;
        default:
            break;
    }
    _UTIL_blinkCountEXT1LED = (_UTIL_blinkCountEXT1LED + 1) % 8;
}

static void _UTIL_ISR_toggleEXT2LED(TC_TIMER_STATUS status, uintptr_t context)
{
    switch (_UTIL_blinkCountEXT2LED)
    {
        case 0:
        case 1:
        case 2:
        case 3:
            UTIL_toggleEXT2LED();
            break;
        default:
            break;
    }
    _UTIL_blinkCountEXT2LED = (_UTIL_blinkCountEXT2LED + 1) % 8;
}

static void _UTIL_ISR_toggleEXT1AND2LED(TC_TIMER_STATUS status, uintptr_t context)
{
    switch (_UTIL_blinkCountEXT1LED)
    {
        case 0:
        case 1:
        case 2:
        case 3:
            UTIL_toggleEXT1LED();
            UTIL_toggleEXT2LED();
            break;
        default:
            break;
    }
    _UTIL_blinkCountEXT1LED = (_UTIL_blinkCountEXT1LED + 1) % 8;
}
