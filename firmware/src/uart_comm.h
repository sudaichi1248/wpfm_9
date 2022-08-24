/*
 * File:    uart_comm.h
 * Author:  Interark Corp.
 * Summary: Utility functions for UART(SERCOM5)
 * Date:    2022/07/15 (R0)
 * Note:    This UART(SERCOM5) is used for communication to MATcore.
 */


#ifndef UART_COMM_H
#define	UART_COMM_H

#ifdef	__cplusplus
extern "C" {
#endif

#include "definitions.h"

// Symbols
#define UART_COMM_DEFAULT_TIMEOUT        1000       // default timeout in UART_COMM_readBytesUntil() [mS]
#define UART_COMM_MAX_TIMEOUT            100000     // Maximum timeout value[mS]
#define UART_COMM_MAX_READ_LENGTH        128        // Maximum size to read at once [bytes]
#define UART_COMM_MAX_WRITE_LENGTH       128        // Maximum size to write at once [bytes]

// Error codes
#define UART_COMM_ERR_NONE               0          // SUccess, no error
#define UART_COMM_ERR_NO_DATA            (-1)       // no data received
#define UART_COMM_ERR_PARAM              (-2)       // Parameter error
#define UART_COMM_ERR_WRITE              (-3)       // uart write error
#define UART_COMM_ERR_READ               (-4)       // uart read error

extern void UART_COMM_begin(void);
extern void UART_COMM_end(void);
extern uint32_t UART_COMM_setTimeout(uint32_t timeout);

extern int UART_COMM_getRemainedBytes(void);
extern int UART_COMM_read(void);
extern int UART_COMM_readBytes(char *buffer, int length);
extern int UART_COMM_readBytesUntil(char terminatedChar, char *buffer, int length);

extern int UART_COMM_write(char c);
extern int UART_COMM_writeBytes(char *buffer, int length);


#ifdef	__cplusplus
}
#endif

#endif	/* UART_COMM_H */
