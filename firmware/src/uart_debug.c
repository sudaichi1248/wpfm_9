/*
 * File:    uart_debug.c
 * Author:  Interark Corp.
 * Summary: Utility functions for UART(SERCOM0)
 * Date:    2022/08/06 (R0)
 * Note:    This UART(SERCOM0) is used for debugging.
 */


#include "uart_debug.h"

// Local variables
static uint32_t _UART_DEBUG_timeout = UART_DEBUG_DEFAULT_TIMEOUT;

void UART_DEBUG_begin(void)
{
    // do nothing
}

void UART_DEBUG_end(void)
{
    // do nothing
}

uint32_t UART_DEBUG_setTimeout(uint32_t timeout)
{
    if (timeout > UART_DEBUG_MAX_TIMEOUT)
    {
        timeout = UART_DEBUG_MAX_TIMEOUT;
    }

    uint32_t oldTimeout = _UART_DEBUG_timeout;
    _UART_DEBUG_timeout = timeout;

    return (oldTimeout);
}

int UART_DEBUG_read(void)
{
    char c = 0;
    if (SERCOM0_USART_Read((void *)&c, (size_t)1) == 1)
    {
        return ((int)c);
    }

    return (UART_DEBUG_ERR_NO_DATA);
}

int UART_DEBUG_readBytes(char *buffer, int length)
{
    if (buffer == (char *)NULL || length < 1)
    {
        return (UART_DEBUG_ERR_PARAM);
    }

    return (SERCOM0_USART_Read((void *)buffer, (size_t)length));
}

int UART_DEBUG_readBytesUntil(char terminatedChar, char *buffer, int length)
{
    if (buffer == (char *)NULL || length < 1)
    {
        return (UART_DEBUG_ERR_PARAM);
    }

    int nbytes = 0;
    uint32_t start = SYS_mSec;
    while (SYS_mSec - start <= _UART_DEBUG_timeout && length > 0)
    {
        char c = 0;
        if (SERCOM0_USART_Read((void *)&c, (size_t)1) == 1)
        {
            *buffer++ = c;
            length--;
            nbytes++;
            if (c == terminatedChar)
            {
                break;      // found terminatedChar!
            }
        }
    }

    return (nbytes);
}

int UART_DEBUG_write(char c)
{
    return (SERCOM0_USART_Write((void *)&c, (size_t)1));
}

int UART_DEBUG_writeBytes(const char *buffer, int length)
{
    if (buffer == (char *)NULL || length < 1)
    {
        return (UART_DEBUG_ERR_PARAM);
    }

    return (SERCOM0_USART_Write((void *)buffer, (size_t)length));
}
