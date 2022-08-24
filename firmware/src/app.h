/*******************************************************************************
  MPLAB Harmony Application Header File

  Company:
    Microchip Technology Inc.

  File Name:
    app.h

  Date:
    2022/08/06  Interark Corp.

  Summary:
    This header file provides prototypes and definitions for the application.

  Description:
    This header file provides function prototypes and data type definitions for
    the application.  Some of these are required by the system (such as the
    "APP_Initialize" and "APP_Tasks" prototypes) and some of them are only used
    internally by the application (such as the "APP_STATES" definition).  Both
    are defined here for convenience.
*******************************************************************************/

//DOM-IGNORE-BEGIN
/*******************************************************************************
* Copyright (C) 2018 Microchip Technology Inc. and its subsidiaries.
*
* Subject to your compliance with these terms, you may use Microchip software
* and any derivatives exclusively with Microchip products. It is your
* responsibility to comply with third party license terms applicable to your
* use of third party software (including open source software) that may
* accompany Microchip software.
*
* THIS SOFTWARE IS SUPPLIED BY MICROCHIP "AS IS". NO WARRANTIES, WHETHER
* EXPRESS, IMPLIED OR STATUTORY, APPLY TO THIS SOFTWARE, INCLUDING ANY IMPLIED
* WARRANTIES OF NON-INFRINGEMENT, MERCHANTABILITY, AND FITNESS FOR A
* PARTICULAR PURPOSE.
*
* IN NO EVENT WILL MICROCHIP BE LIABLE FOR ANY INDIRECT, SPECIAL, PUNITIVE,
* INCIDENTAL OR CONSEQUENTIAL LOSS, DAMAGE, COST OR EXPENSE OF ANY KIND
* WHATSOEVER RELATED TO THE SOFTWARE, HOWEVER CAUSED, EVEN IF MICROCHIP HAS
* BEEN ADVISED OF THE POSSIBILITY OR THE DAMAGES ARE FORESEEABLE. TO THE
* FULLEST EXTENT ALLOWED BY LAW, MICROCHIP'S TOTAL LIABILITY ON ALL CLAIMS IN
* ANY WAY RELATED TO THIS SOFTWARE WILL NOT EXCEED THE AMOUNT OF FEES, IF ANY,
* THAT YOU HAVE PAID DIRECTLY TO MICROCHIP FOR THIS SOFTWARE.
 *******************************************************************************/
//DOM-IGNORE-END

#ifndef _APP_H
#define _APP_H


// *****************************************************************************
// *****************************************************************************
// Section: Included Files
// *****************************************************************************
// *****************************************************************************

#include <stdint.h>
#include <stdbool.h>
#include <stddef.h>
#include <stdlib.h>
#include "configuration.h"
#include "definitions.h"

// *****************************************************************************
// *****************************************************************************
// Section: Symbol Definitions
// *****************************************************************************
// *****************************************************************************

// Constants
#define APP_CDC_BUFFER_SIZE                 512

// Error codes
#define APP_ERR_NONE                        0
#define APP_ERR_PARAM                       (-1)


// *****************************************************************************
/* Application States

  Summary:
    Application states enumeration

  Description:
    This enumeration defines the valid application states.  These states
    determine the behavior of the application at various times.
*/

typedef enum
{
    /* Application's state machine's initial state. */
    APP_STATE_INIT = 0,

    /* Application waits for device configuration*/
    APP_STATE_WAIT_FOR_CONFIGURATION,

    /* Wait for a character receive */
    APP_STATE_SCHEDULE_READ,

    /* A character is received from host */
    APP_STATE_WAIT_FOR_READ_COMPLETE,

    /* Wait for the TX to get completed */
    APP_STATE_SCHEDULE_WRITE,

    /* Wait for the write to complete */
    APP_STATE_WAIT_FOR_WRITE_COMPLETE,

    /* Application Error state*/
    APP_STATE_ERROR

} APP_STATES;


// *****************************************************************************
/* Application Data

  Summary:
    Holds application data

  Description:
    This structure holds the application's data.

  Remarks:
    Application strings and buffers are be defined outside this structure.
 */

typedef struct
{
    /* Device layer handle returned by device layer open function */
    USB_DEVICE_HANDLE deviceHandle;

    /* Application's current state*/
    APP_STATES state;

    /* Set Line Coding Data */
    USB_CDC_LINE_CODING setLineCodingData;

    /* Device configured state */
    bool isConfigured;

    /* Get Line Coding Data */
    USB_CDC_LINE_CODING getLineCodingData;

    /* Control Line State */
    USB_CDC_CONTROL_LINE_STATE controlLineStateData;

    /* Read transfer handle */
    USB_DEVICE_CDC_TRANSFER_HANDLE readTransferHandle;

    /* Write transfer handle */
    USB_DEVICE_CDC_TRANSFER_HANDLE writeTransferHandle;

    /* True if a character was read */
    bool isReadComplete;

    /* True if a character was written*/
    bool isWriteComplete;

    /* True is switch was pressed */
    bool isSwitchPressed;

    /* True if the switch press needs to be ignored*/
    bool ignoreSwitchPress;

    /* Flag determines SOF event occurrence */
    bool sofEventHasOccurred;

    /* Break data */
    uint16_t breakData;

    /* Switch debounce timer */
    unsigned int switchDebounceTimer;

    /* Switch debounce timer count */
    unsigned int debounceCount;

    /* Application CDC read buffer */
    uint8_t * cdcReadBuffer;

    /* Application CDC Write buffer */
    uint8_t * cdcWriteBuffer;

    /* Number of bytes read from Host */
    uint32_t numBytesRead;

    /* Number of bytes write to Host */
    uint32_t numBytesWrite;
} APP_DATA;

extern APP_DATA appData;

extern volatile uint32_t SYS_mSec;     // Sys Tick Counter (count up every milli seconds)
extern volatile uint32_t SYS_tick;     // Sys Tick Counter without reset.


// *****************************************************************************
// *****************************************************************************
// Section: Application Callback Routines
// *****************************************************************************
// *****************************************************************************
/* These routines are called by drivers when certain events occur.
*/


// *****************************************************************************
// *****************************************************************************
// Section: Application Initialization and State Machine Functions
// *****************************************************************************
// *****************************************************************************

/*******************************************************************************
  Function:
    void APP_Initialize ( void )

  Summary:
     MPLAB Harmony application initialization routine.

  Description:
    This function initializes the Harmony application.  It places the
    application in its initial state and prepares it to run so that its
    APP_Tasks function can be called.

  Precondition:
    All other system initialization routines should be called before calling
    this routine (in "SYS_Initialize").

  Parameters:
    None.

  Returns:
    None.

  Example:
    <code>
    APP_Initialize();
    </code>

  Remarks:
    This routine must be called from the SYS_Initialize function.
*/

void APP_Initialize ( void );


/*******************************************************************************
  Function:
    void APP_Tasks ( void )

  Summary:
    MPLAB Harmony Demo application tasks function

  Description:
    This routine is the Harmony Demo application's tasks function.  It
    defines the application's state machine and core logic.

  Precondition:
    The system and application initialization ("SYS_Initialize") should be
    called before calling this.

  Parameters:
    None.

  Returns:
    None.

  Example:
    <code>
    APP_Tasks();
    </code>

  Remarks:
    This routine must be called from SYS_Tasks() routine.
 */

void APP_Tasks ( void );


/*
*   Application specific (Use code here)
*/

// *****************************************************************************
/* SYS_mSec, SYS_tick

  Summary:
    Ticks the one millisecond that count up only while waked up.

  Description:
    SYS_mSec is reset to ZERO every second.
    SYS_tick is not reset, so keep increasing until it overflows.

  Remarks:
    This global variable has defined in "initialize.c".
*/

extern volatile uint32_t SYS_mSec;
extern volatile uint32_t SYS_tick;

/*******************************************************************************
  Function:
    void APP_delay ( uint32_t ms )

  Summary:
    Delay function that call SYS_Tasks() while watiting.

  Description:

  Precondition:
    Waits for execution for the specified number of milliseconds.
    Call SYS_tasks() while waiting for multi tasking.

  Parameters:
    ms - number of milliseconds for delay [in]

  Returns:
    None.

  Example:
    <code>
    APP_delay(10);  // wait 10 milliseconds
    </code>

  Remarks:
    You must use this function instead of delay().
 */

extern void APP_delay(uint32_t ms);         //

/*******************************************************************************
  Function:
    void APP_printUSB ( char const *s )

  Summary:
    Output specified string "s" to USB CDC Port.

  Description:

  Precondition:
    The initialization process in the main() function has been completed.

  Parameters:
    s - string(nul-terminated char array) to output [in]

  Returns:
    None.

  Example:
    <code>
      APP_printUSB("Hello,world.");
    </code>

  Remarks:

 */

extern void APP_printUSB(char const *s);    //

/*******************************************************************************
  Function:
    void APP_printlnUSB ( char const *s )

  Summary:
    Output specified string "s" to USB CDC Port with new-line.

  Description:

  Precondition:
    The initialization process in the main() function has been completed.

  Parameters:
    s - string(nul-terminated char array) to output [in]

  Returns:
    None.

  Example:
    <code>
      APP_printlnUSB("Hello,world.");
    </code>

  Remarks:

 */

extern void APP_printlnUSB(char const *s);  //

/*******************************************************************************
  Function:
    int APP_writeUSB(uint8_t const *data_p, uint16_t size)

  Summary:
    Output binary data to USB CDC Port.

  Description:

  Precondition:
    The initialization process in the main() function has been completed.

  Parameters:
    data_p - binary data to output [in]
    size - data size(bytes) [in]

  Returns:
    APP_ERR_NONE - no error
    APP_ERR_PARAM - too big size

  Example:
    <code>
      uint8_t data[10] = { 1, 2, 3, 4, 5, 6 7, 8. 9, 0 };
      APP_writeUSB(data, sizeof(data));
    </code>

  Remarks:

 */

extern int APP_writeUSB(uint8_t const *data_p, uint16_t size);

/*******************************************************************************
  Function:
    int APP_readUSB(uint8_t const *data_p, uint16_t size)

  Summary:
    Read data from USB CDC Port.

  Description:

  Precondition:
    The initialization process in the main() function has been completed.

  Parameters:
    data_p - binary data to output [out]
    size - data space size(bytes) [in]

  Returns:
    0: no date
    1..size: read data size(bytes)

  Example:
    <code>
      uint8_t data[10];
      int size = APP_readUSB(data, sizeof(data));
      if (size > 0)
      {
        // process read data
      }
    </code>

  Remarks:

 */

extern int APP_readUSB(uint8_t *data_p, uint16_t size);

/*******************************************************************************
  Function:
    int APP_getRemainedBytesUSB(void)

  Summary:
    Get received data size from USB CDC Port.

  Description:

  Precondition:
    The initialization process in the main() function has been completed.

  Parameters:
    None.

  Returns:
    received data size from USB CDC Port(bytes)

  Example:
    <code>
      while (APP_getRemainedBytesUSB() > 0)
      {
        // process read data
      }
    </code>

  Remarks:

 */

extern int APP_getRemainedBytesUSB(void);

/*******************************************************************************
  Function:
    int APP_getByteUSB(void)

  Summary:
    Get one byte data from USB CDC Port.

  Description:

  Precondition:
    The initialization process in the main() function has been completed.

  Parameters:
    None.

  Returns:
    received data size from USB CDC Port(bytes)

  Example:
    <code>
      while (APP_getByteUSB() != 0)
      {
        // process got a byte data
      }
    </code>

  Remarks:
    non-blocking
 */

extern uint8_t APP_getByteUSB(void);

/*******************************************************************************
  Function:
    int APP_putByteUSB(void)

  Summary:
    Put one byte data to USB CDC Port.

  Description:

  Precondition:
    The initialization process in the main() function has been completed.

  Parameters:
    None.

  Returns:
    Put data size to USB CDC port(1: OK/0: Error)

  Example:
    <code>
    uint8_t data = 0x20;
      if (APP_putByteUSB(data) != 0)
      {
        // error handling
      }
    </code>

  Remarks:
    non-blocking
 */

extern int APP_putByteUSB(uint8_t data);

#endif /* _APP_H */
/*******************************************************************************
 End of File
 */
