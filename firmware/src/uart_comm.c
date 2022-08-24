/*
 * File:    uart_comm.c
 * Author:  Interark Corp.
 * Summary: Utility functions for UART(SERCOM5)
 * Date:    2022/07/16 (R0)
 * Note:    This UART(SERCOM5) is used for communication to MATcore.
 *          UART(SERCOM5) use hardware flow-control(RTS/CTS)
 */


#include "uart_comm.h"

// Local variables
static uint32_t _UART_COMM_timeout = UART_COMM_DEFAULT_TIMEOUT;


void UART_COMM_begin(void)
{
    // do nothing
}

void UART_COMM_end(void)
{
    // do nothing
}

uint32_t UART_COMM_setTimeout(uint32_t timeout)
{
    if (timeout > UART_COMM_MAX_TIMEOUT)
    {
        timeout = UART_COMM_MAX_TIMEOUT;
    }

    uint32_t oldTimeout = _UART_COMM_timeout;
    _UART_COMM_timeout = timeout;

    return (oldTimeout);
}

int UART_COMM_getRemainedBytes(void)
{
    return (SERCOM5_USART_ReadCountGet());
}

int UART_COMM_read(void)
{
    char c = 0;
    if (SERCOM5_USART_Read((uint8_t *)&c, (size_t)1) == 1)
    {
        return ((int)c);
    }

    return (UART_COMM_ERR_NO_DATA);
}

int UART_COMM_readBytes(char *buffer, int length)
{
    if (buffer == (char *)NULL || length < 1)
    {
        return (UART_COMM_ERR_PARAM);
    }

    return (SERCOM5_USART_Read((uint8_t *)buffer, (size_t)length));
}

int UART_COMM_readBytesUntil(char terminatedChar, char *buffer, int length)
{
    if (buffer == (char *)NULL || length < 1)
    {
        return (UART_COMM_ERR_PARAM);
    }

    int nbytes = 0;
    uint32_t start = SYS_mSec;
    while (SYS_mSec - start <= _UART_COMM_timeout && length > 0)
    {
        char c = 0;
        if (SERCOM5_USART_Read((uint8_t *)&c, (size_t)1) == 1)
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

int UART_COMM_write(char c)
{
    return (SERCOM5_USART_Write((uint8_t *)&c, (size_t)1));
}

int UART_COMM_writeBytes(char *buffer, int length)
{
    if (buffer == (char *)NULL || length < 1)
    {
        return (UART_COMM_ERR_PARAM);
    }

    return (SERCOM5_USART_Write((uint8_t *)buffer, (size_t)length));
}
