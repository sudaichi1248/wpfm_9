/*
 * File:    uart_debug.h
 * Author:  Interark Corp.
 * Summary: Utility functions for UART(SERCOM0)
 * Date:    2022/08/06 (R0)
 * Note:    This UART(SERCOM0) is used for debugging.
 */

#ifndef UART_DEBUG_H
#define	UART_DEBUG_H

#ifdef	__cplusplus
extern "C" {
#endif

#include "definitions.h"

// Symbols
#define UART_DEBUG_DEFAULT_TIMEOUT        1000          // default timeout in UART_DEBUG_readBytesUntil() [mS]
#define UART_DEBUG_MAX_TIMEOUT            100000        // Maximum timeout value[mS]
#define UART_DEBUG_MAX_READ_LENGTH        128           // Maximum size to read at once [bytes]
#define UART_DEBUG_MAX_WRITE_LENGTH       128           // Maximum size to write at once [bytes]

// Error codes
#define UART_DEBUG_ERR_NONE               0             // success, no error
#define UART_DEBUG_ERR_NO_DATA            (-1)          // no data received
#define UART_DEBUG_ERR_PARAM              (-2)          // parameter error
#define UART_DEBUG_ERR_WRITE              (-3)          // uart write error
#define UART_DEBUG_ERR_READ               (-4)          // uart read error

extern void UART_DEBUG_begin(void);
extern void UART_DEBUG_end(void);
extern uint32_t UART_DEBUG_setTimeout(uint32_t timeout);

extern int UART_DEBUG_read(void);
extern int UART_DEBUG_readBytes(char *buffer, int length);
extern int UART_DEBUG_readBytesUntil(char terminatedChar, char *buffer, int length);

extern int UART_DEBUG_write(char c);
extern int UART_DEBUG_writeBytes(const char *buffer, int length);


#ifdef	__cplusplus
}
#endif

#endif	/* UART_DEBUG_DEBUG_H */
