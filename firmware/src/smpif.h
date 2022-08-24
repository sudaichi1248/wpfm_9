/*
 * File:    smpif.h
 * Author:  Interark Corp.
 * Summary: WPFM(code name "DLC_04") project Smartphone interface header file.
 * Date:    2022/08/16 (R0)
 * Note:
 */

#ifndef SMPIF_H
#define	SMPIF_H

#ifdef	__cplusplus
extern "C" {
#endif

/*
*   Symbols
*/
#define SMPIF_MAX_RESPONSE_LENGTH           1024
#define SMPIF_MAX_PARAMETER_LENGTH          192
#define SMPIF_MAX_LOGS_PER_RESPONSE         20          // Maximum number of logs in "DG" response

// control code
#define SMPIF_STX                           0x02
#define SMPIF_ETX                           0x03
//#define SMPIF_ETX                           0x00


// error codes
#define SMPIF_ERR_NONE                      0
#define SMPIF_ERR_NO_MESSAGE                (-1)
#define SMPIF_ERR_BAD_MSGID                 (-100)
#define SMPIF_ERR_BAD_FORMAT                (-101)
#define SMPIF_ERR_BAD_PARAMETER             (-102)
#define SMPIF_ERR_FLASH                     (-900)
#define SMPIF_ERR_WAIT_FOR_COMMAND          (-1000)

/*
*   Globals
*/
extern int SMPIF_errorColumn;               // Column number where error occurred in parameter
extern int SMPIF_errorPosition;             // Position(byte offset) where error occurred in parameter


// defind in smpif.c
extern int SMPIF_readMessage(void);
extern int SMPIF_handleMessage(void);
extern void SMPIF_dumpMessage(const char *prefix, const char *message);
// defind in smpif1.c
extern void SMPIF_getOperationalCondition(const char *param, char *resp);
extern void SMPIF_setOperationalCondition(const char *param, char *resp);
// defind in smpif2.c
extern void SMPIF_startSendRegularly(const char *param, char *resp);
extern void SMPIF_endSendRegularly(const char *param, char *resp);
extern void SMPIF_sendRegularly(void);
// defind in sipif3.c
extern void SMPIF_getStatus(const char *param, char *resp);
extern void SMPIF_getData(const char *param, char *resp);
// defind in smpif4.c
extern void SMPIF_getCallibrationValues(const char *param, char *resp);
extern void SMPIF_setCallibrationValues(const char *param, char *resp);
extern void SMPIF_notifyCallibrationTarget(const char *param, char *resp);
extern void SMPIF_readCallibrationValues(const char *param, char *resp);


#ifdef	__cplusplus
}
#endif

#endif	/* SMPIF_H */
