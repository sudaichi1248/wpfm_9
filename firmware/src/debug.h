/*
 * File:    debug.h
 * Author:  Interark Corp.
 * Summary: Debug macro header file.
 * Date:    2022/07/31 (R0)
 * Note:
 */

#ifndef DEBUG_H
#define	DEBUG_H

#ifdef	__cplusplus
extern "C" {
#endif

#include <string.h>
#include <stdio.h>


#define DEBUG_TIMESTAMP     // Add a timestamp to each print statement

/*
*   Macros & symbols
*/
//#define DEBUG_HALT()                        while (true)
#define DEBUG_HALT()                          DLC_Halt()

#ifdef DEBUG_USB
#   include "app.h"
#   define DEBUG_USB_printString(s)         { APP_printUSB((s)); }
#   define DEBUG_USB_printlnString(s)       { APP_printlnUSB((s)); }
#   define DEBUG_USB_printFormat(...)       { char _line[80]; snprintf(_line, sizeof(_line),  __VA_ARGS__); APP_printUSB(_line); }
#   define DEBUG_USB_printlnFormat(...)     { char _line[80]; snprintf(_line, sizeof(_line),  __VA_ARGS__); APP_printlnUSB(_line); }
#else
#   define DEBUG_USB_printString(s)
#   define DEBUG_USB_printlnString(s)
#   define DEBUG_USB_printFormat(...)
#   define DEBUG_USB_printlnFormat(...)
#endif // DEBUG_USB

#ifdef DEBUG_UART
#   include "uart_debug.h"
#   ifdef DEBUG_TIMESTAMP
#       define DEBUG_UART_printString(s)        { UART_DEBUG_writeBytes((s), strlen(s)); }
#       define DEBUG_UART_printlnString(s)      { UART_DEBUG_writeBytes((s), strlen(s)); UART_DEBUG_writeBytes("\n", 1); }
#       define DEBUG_UART_printFormat(...)      { char _line[80]; snprintf(_line, sizeof(_line),  __VA_ARGS__); UART_DEBUG_writeBytes(_line, strlen(_line)); }
#       define DEBUG_UART_printlnFormat(...)    { char _line[80]; snprintf(_line, sizeof(_line),  __VA_ARGS__); UART_DEBUG_writeBytes(_line, strlen(_line)); UART_DEBUG_writeBytes("\n", 1); }
#       define DEBUG_UART_FLUSH()               { while (SERCOM0_USART_WriteFreeBufferCountGet() < SERCOM0_USART_WriteBufferSizeGet()) SYS_Tasks(); }
#   else
#       define DEBUG_UART_printString(s)        { UART_DEBUG_writeBytes((s), strlen(s)); }
#       define DEBUG_UART_printlnString(s)      { UART_DEBUG_writeBytes((s), strlen(s)); UART_DEBUG_writeBytes("\n", 1); }
#       define DEBUG_UART_printFormat(...)      { char _line[80]; snprintf(_line, sizeof(_line),  __VA_ARGS__); UART_DEBUG_writeBytes(_line, strlen(_line)); }
#       define DEBUG_UART_printlnFormat(...)    { char _line[80]; snprintf(_line, sizeof(_line),  __VA_ARGS__); UART_DEBUG_writeBytes(_line, strlen(_line)); UART_DEBUG_writeBytes("\n", 1); }
#       define DEBUG_UART_FLUSH()               { while (SERCOM0_USART_WriteFreeBufferCountGet() < SERCOM0_USART_WriteBufferSizeGet()) SYS_Tasks(); }
#   endif // DEBUG_TIMESTAMP
#else
#   define DEBUG_UART_printString(s)
#   define DEBUG_UART_printlnString(s)
#   define DEBUG_UART_printFormat(...)
#   define DEBUG_UART_printlnFormat(...)
#   define DEBUG_UART_FLUSH()
#endif // DEBUG_UART

#ifdef	__cplusplus
}
#endif

#endif	/* DEBUG_H */
