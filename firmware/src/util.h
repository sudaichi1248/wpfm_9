/*
 * File:   util.h
 * Author:  Interark Corp.
 * Summary: WPFM(code name "DLC_04") project utility header file.
 * Date:    2022/08/06 (R0)
 * Note:
 */

#ifndef UTIL_H
#define	UTIL_H

#ifdef	__cplusplus
extern "C" {
#endif

#include "app.h"
#include "wpfm.h"

/*
*   Symbol
*/
#define UTIL_FATAL_BLINK_TIME           10000       //

/*
*   Macros
*/
  // GPIO control
#define UTIL_GPIO_set(pin)              (PORT_REGS->GROUP[0].PORT_OUTSET = ((uint32_t)1U << (pin)))
#define UTIL_GPIO_clear(pin)            (PORT_REGS->GROUP[0].PORT_OUTCLR = ((uint32_t)1U << (pin)))
#define UTIL_GPIO_toggle(pin)           (PORT_REGS->GROUP[0].PORT_OUTTGL = ((uint32_t)1U << (pin)))
#define UTIL_GPIO_get(pin)              (((PORT_REGS->GROUP[0].PORT_IN >> (pin))) & 0x01U)
  // Led control
#define UTIL_LED1_ON()                  UTIL_clearLED1()
#define UTIL_LED1_OFF()                 UTIL_setLED1()
#define UTIL_LED1_ONESHOT()             UTIL_startBlinkLED1(1)
#define UTIL_EXT1LED_ON()               UTIL_clearEXT1LED()
#define UTIL_EXT1LED_OFF()              UTIL_setEXT1LED()
#define UTIL_EXT2LED_ON()               UTIL_clearEXT2LED()
#define UTIL_EXT2LED_OFF()              UTIL_setEXT2LED()


// LED functions
  // LED1
extern void UTIL_setLED1(void);
extern void UTIL_clearLED1(void);
extern void UTIL_toggleLED1(void);
extern void UTIL_startBlinkLED1(uint32_t count);
extern void UTIL_stopBlinkLED1(void);
extern int UTIL_checkblinkCountLED1(void);
  // EXT1_LED
extern void UTIL_setEXT1LED(void);
extern void UTIL_clearEXT1LED(void);
extern void UTIL_toggleEXT1LED(void);
extern void UTIL_startBlinkEXT1LED(void);
extern void UTIL_stopBlinkEXT1LED(void);
  // EXT_LED2
extern void UTIL_setEXT2LED(void);
extern void UTIL_clearEXT2LED(void);
extern void UTIL_toggleEXT2LED(void);
extern void UTIL_startBlinkEXT2LED(void);
extern void UTIL_stopBlinkEXT2LED(void);
  // both EXT1_LED and EXT2_LED
extern void UTIL_startBlinkEXT1AND2LED(void);
extern void UTIL_stopBlinkEXT1AND2LED(void);

// USB functions
extern bool UTIL_hasConnectedUSB(void);

// Check slide-switch
extern WPFM_OPERATION_MODE UTIL_getPowerModeSW(void);

// Utility functions
extern void UTIL_delayMicros(uint32_t time);
extern float UTIL_map(float value, float lowerFrom, float upperFrom, float lowerTo, float upperTo);

// Error handling
extern void fatal(const char *fmt, int info);       // no return

#ifdef	__cplusplus
}
#endif

#endif	/* UTIL_H */
