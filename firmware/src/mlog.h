/*
 * File:    mlog.h
 * Author:  Interark Corp.
 * Summary: Measure log header file.
 * Date:    2022/08/17 (R0)
 *          2022/09/09 (R1) Support temporary SRAM log
 *			2022/09/13 Bitassign update  Alert status(CH1/CH2)
 * Note:
 *          Use 2KB of SRAM for temporary SRAM log (R1)
 */

#ifndef MLOG_H
#define	MLOG_H

#ifdef	__cplusplus
extern "C" {
#endif

#include "definitions.h"

/*
*   Constants
*/
#define MLOG_RECORD_SIZE                28      // Log size (bytes) - must be same as sizeof(MLOG_T) with padding
#define MLOG_LOGS_PER_PAGE              9       // Number of logs per page
#define MLOG_MAX_RECORDS                (MLOG_LOGS_PER_PAGE * (((MLOG_ADDRESS_MLOG_LAST - MLOG_ADDRESS_MLOG_TOP) >> 8) + 1))
#define MLOG_MAX_SEQUENTIAL_NUMBER      (0xffffffff - 1)

/*
*   Flash memory address
*/
  // (1) Mlog region (12MB)
#define MLOG_ADDRESS_MLOG_TOP           0x000000    // Mlog region top
#define MLOG_ADDRESS_MLOG_LAST          0xAFFFFF    // Mlog region last
//#define MLOG_ADDRESS_MLOG_LAST          0x001FFF    // Mlog region last for test
  // (2) Reserved region (4MB)
#define MLOG_ADDRESS_RESERVED_TOP       0xC00000    // Reserved region top
#define MLOG_ADDRESS_RESERVED_LAST      0xFFFFFF    // Reserved region last
  // (3) SRAM
#define MLOG_SRAM_SIZE                  2048        // Temporary Mlog storage region size on SRAM [bytes]

// Error codes
#define MLOG_ERR_NONE                   0           // Success(no error)
#define MLOG_ERR_PARAM                  (-1)        // bad parameter(s)
#define MLOG_ERR_EMPTY                  (-3)        // buffer empty
#define MLOG_ERR_READ                   (-4)        // error on read operation
#define MLOG_ERR_READ_ID                (-10)       // error on read ID
#define MLOG_ERR_BAD_ID                 (-11)       // Serial Flash chip's ID is invalid
#define MLOG_ERR_ERASE                  (-20)       // error on erase operation
#define MLOG_ERR_PROGRAM_PAGE           (-21)       // error on program page operation
#define MLOG_ERR_FORMAT                 (-30)       // error on format
#define MLOG_ERR_OVERFLOW               (-40)       // SRAM buffer overflow
#define MLOG_ERR_NOT_EXIST              (-100)      // speified sequential number not exist
/*
*   Types
*/
typedef uint32_t    MLOG_ID_T;              // Mlog ID(24-bit) = (page address(16-bit) << 8) + log offset(8-bit)

typedef struct
{
    uint32_t        second;                 // epoch time at JST(not UTC) [sec]
    uint16_t        mSecond;                // millisecond(0..999) [msec]
} MLOG_TIMESTAMP;

typedef struct
{
    uint32_t        sequentialNumber;       // Sequentila number(1..) - Unique, the later the log recording timing, the larger the number.
    MLOG_TIMESTAMP  timestamp;              // Timestamp(Date and time) of measurement
    float           measuredValues[2];      // measured values - index 0: CH1/1: CH2 [MhPa..]
    uint16_t        batteryVoltages[2];     // external battery voltage - index 0: External#1/1: External#2 [mV]
    int16_t         temperatureOnBoard;     // x10 [C]
    uint8_t         alertStatus;            // Alert status (high byte: CH1/low byte:CH2)
    uint8_t         batteryStatus;          // Battery status (high byte: battery#1/low byte: battery#2)
} MLOG_T;               // MLOG record type in flash memory (must be 28 bytes or less)

// Alert status(CH1/CH2)
#define MLOG_ALERT_STATUS_BOTH_NORMAL           0x00    // Both channels Normal status
#define MLOG_ALERT_STATUS_CH1_NORMAL            0x00    // CH1 Normal status
#define MLOG_ALERT_STATUS_CH1_UPPER_WARNING     0x01    // CH1 Warning status(upper-side)
#define MLOG_ALERT_STATUS_CH1_UPPER_ATTENTION   0x02    // CH1 Attention status(upper-side)
#define MLOG_ALERT_STATUS_CH1_LOWER_ATTENTION   0x03    // CH1 Attention status(lower-side)
#define MLOG_ALERT_STATUS_CH1_LOWER_WARNING     0x04    // CH1 Warning status(lower-side)
#define MLOG_ALERT_STATUS_CH2_NORMAL            0x00    // CH2 Normal status
#define MLOG_ALERT_STATUS_CH2_UPPER_WARNING     0x10    // CH2 Warning status(upper-side)
#define MLOG_ALERT_STATUS_CH2_UPPER_ATTENTION   0x20    // CH2 Attention status(upper-side)
#define MLOG_ALERT_STATUS_CH2_LOWER_ATTENTION   0x30    // CH2 Attention status(lower-side)
#define MLOG_ALERT_STATUS_CH2_LOWER_WARNING     0x40    // CH2 Warning status(lower-side)

// Battery status(#1/#2)
#define MLOG_BAT_STATUS_BAT1_NOT_USE            0x00    // Battery #1 not used
#define MLOG_BAT_STATUS_BAT1_IN_USE             0x10    // Battery #1 in used
#define MLOG_BAT_STATUS_BAT1_LOW_VOLTAGE        0x20    // Battery #1 low voltage(should be replaced)
#define MLOG_BAT_STATUS_BAT2_NOT_USE            0x00    // Battery #2 not used
#define MLOG_BAT_STATUS_BAT2_IN_USE             0x01    // Battery #2 in used
#define MLOG_BAT_STATUS_BAT2_LOW_VOLTAGE        0x02    // Battery #2 low voltage(should be replaced)

typedef struct
{
    uint32_t        oldestSequentialNumber;     // Oldest sequential number
    uint32_t        latestSequentialNumber;     // Latest sequential number
    uint32_t        oldestDatetime;             // Timestamp(epoch time) of oldest log
    uint32_t        latestDatetime;             // Timestamp(epoch time) of latest log
    uint32_t        oldestAddress;              // Address of oldest log
    uint32_t        latestAddress;              // Address of latest log
} MLOG_STATUS_T;        // Mlog status info

/*
*   Functions
*/
  // set up function
extern int MLOG_begin(bool checkLogs);          // check chip's ID and check all logs(takes a few seconds)
  // log operations
extern int MLOG_putLog(MLOG_T *log_p, bool specifySN);  // put log in fifo buffer(on Flash)
extern int MLOG_getLog(MLOG_T *log_p);          // get oldest unuploaded log from fifo buffer(on Flash)
extern uint32_t MLOG_countUploadableLog(void);  // count number of unuploaded logs in fifo buffer(on Flash)
extern int MLOG_findLog(uint32_t sn, MLOG_T *log_p);    // find log by seqential number
  // Control functions
extern int MLOG_format(void);                   // format chip(takes a few seconds)
extern int MLOG_checkLogs(bool oldestOnly);     // full scan the chip to restore the head and tail(takes a few seconds)
extern int MLOG_getStatus(MLOG_STATUS_T *stat_p);   // get log status
  // Switch buffer on Flash <-> SRAM
extern int MLOG_switchToSRAM(void);             // temporarily switch the log storage to SRAM
extern int MLOG_returnToFlash(void);            // return the log storage to Flash memory
extern bool MLOG_IsSwitchedSRAM(void);          // Has the log storage destination been switched to SRAM?
extern int MLOG_putLogOnSRAM(MLOG_T *log_p);    // put log in fifo buffer(on SRAM)
  // Debug function
extern void MLOG_dump(void);                    // Dump all logs in Mlog region to debug uart port

#ifdef	__cplusplus
}
#endif

#endif	/* MLOG_H */
