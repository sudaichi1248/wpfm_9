/*
 * File:    battery.h
 * Author:  Interark Corp.
 * Summary: WPFM(code name "DLC_04") project battery control header file.
 * Date:    2022/07/24 (R0)
 * Note:
 */

#ifndef BATTERY_H
#define	BATTERY_H

#ifdef	__cplusplus
extern "C" {
#endif

#include "wpfm.h"

#define BATTERY_ERR_NONE            0
#define BATTERY_ERR_HALT            (-99)
#define BATTERY_ERR_EXCHANGE        (-1)
#define BATTERY_ERR_NOT_NECESSARY   (-2)    // No battery replacement required
#define BATTERY_ERR_TIMEOUT         (-3)
#define BATTERY_ERR_LOW_VOLTAGE     (-4)

extern int BATTERY_checkAndSwitchBattery(void);
extern int BATTERY_enterReplaceBattery(void);
extern int BATTERY_leaveReplaceBattery(void);
extern void BATTERY_turnOffExtLed(void);
extern void BATTERY_shutdown(void);

#ifdef	__cplusplus
}
#endif

#endif	/* BATTERY_H */
