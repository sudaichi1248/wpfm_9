/*******************************************************************************
  MPLAB Harmony Application Source File

  Company:
    Microchip Technology Inc.

  File Name:
    app.c

  Date:
    2022/08/13  Interark Corp.

  Summary:
    This file contains the source code for the MPLAB Harmony application.

  Description:
    This file contains the source code for the MPLAB Harmony application.  It
    implements the logic of the application's state machine and it may call
    API routines of other MPLAB Harmony modules in the system, such as drivers,
    system services, and middleware.  However, it does not call any of the
    system interfaces (such as the "Initialize" and "Tasks" functions) of any of
    the modules in the system or make any assumptions about when those functions
    are called.  That is the responsibility of the configuration-specific system
    files.
 *******************************************************************************/

// DOM-IGNORE-BEGIN
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
// DOM-IGNORE-END

// *****************************************************************************
// *****************************************************************************
// Section: Included Files
// *****************************************************************************
// *****************************************************************************

#include <string.h>
#include "app.h"
#include "wpfm.h"
#include "Moni.h"
int DLCMatTmChk();
// *****************************************************************************
// *****************************************************************************
// Section: Symbol Definitions
// *****************************************************************************
// *****************************************************************************

#define APP_USB_BUFFER_SIZE     512         // Ring buffer size [Bytes]

// *****************************************************************************
// *****************************************************************************
// Section: Local Data and Function Definitions
// *****************************************************************************
// *****************************************************************************

// CDC Buffer
static uint8_t CACHE_ALIGN cdcReadBuffer[APP_CDC_BUFFER_SIZE];
static uint8_t CACHE_ALIGN cdcWriteBuffer[APP_CDC_BUFFER_SIZE];

// Ring Buffer for wrapper functions
static uint8_t CACHE_ALIGN _APP_ReadBuffer[APP_USB_BUFFER_SIZE];
//static uint8_t CACHE_ALIGN _APP_WriteBuffer[APP_USB_BUFFER_SIZE];
static int _APP_ReadBufferHead = 0, _APP_ReadBufferTail = 0;
//static int _APP_WriteBufferHead = 0, _APP_WriteBufferTail = 0;

static bool _APP_getReadBuffer(uint8_t *data_p);
static bool _APP_putReadBuffer(uint8_t data);


// *****************************************************************************
/* Application Data

  Summary:
    Holds application data

  Description:
    This structure holds the application's data.

  Remarks:
    This structure should be initialized by the APP_Initialize function.

    Application strings and buffers are be defined outside this structure.
*/

APP_DATA appData;

volatile uint32_t SYS_mSec = 0;     // Sys Tick Counter with reset every second (count up every milli seconds)
volatile uint32_t SYS_tick = 0;     // Sys Tick Counter without reset (count up every milli seconds)


// *****************************************************************************
// *****************************************************************************
// Section: Application Callback Functions
// *****************************************************************************
// *****************************************************************************



/*******************************************************
 * USB CDC Device Events - Application Event Handler
 *******************************************************/

USB_DEVICE_CDC_EVENT_RESPONSE APP_USBDeviceCDCEventHandler
(
    USB_DEVICE_CDC_INDEX index,
    USB_DEVICE_CDC_EVENT event,
    void * pData,
    uintptr_t userData
)
{
    APP_DATA * appDataObject;
    USB_CDC_CONTROL_LINE_STATE * controlLineStateData;
    USB_DEVICE_CDC_EVENT_DATA_READ_COMPLETE * eventDataRead;

    appDataObject = (APP_DATA *)userData;

    switch(event)
    {
        case USB_DEVICE_CDC_EVENT_GET_LINE_CODING:

            /* This means the host wants to know the current line
             * coding. This is a control transfer request. Use the
             * USB_DEVICE_ControlSend() function to send the data to
             * host.  */

            USB_DEVICE_ControlSend(appDataObject->deviceHandle,
                    &appDataObject->getLineCodingData, sizeof(USB_CDC_LINE_CODING));

            break;

        case USB_DEVICE_CDC_EVENT_SET_LINE_CODING:

            /* This means the host wants to set the line coding.
             * This is a control transfer request. Use the
             * USB_DEVICE_ControlReceive() function to receive the
             * data from the host */

            USB_DEVICE_ControlReceive(appDataObject->deviceHandle,
                    &appDataObject->setLineCodingData, sizeof(USB_CDC_LINE_CODING));

            break;

        case USB_DEVICE_CDC_EVENT_SET_CONTROL_LINE_STATE:

            /* This means the host is setting the control line state.
             * Read the control line state. We will accept this request
             * for now. */

            controlLineStateData = (USB_CDC_CONTROL_LINE_STATE *)pData;
            appDataObject->controlLineStateData.dtr = controlLineStateData->dtr;
            appDataObject->controlLineStateData.carrier = controlLineStateData->carrier;

            USB_DEVICE_ControlStatus(appDataObject->deviceHandle, USB_DEVICE_CONTROL_STATUS_OK);

            break;

        case USB_DEVICE_CDC_EVENT_SEND_BREAK:

            /* This means that the host is requesting that a break of the
             * specified duration be sent. Read the break duration */

            appDataObject->breakData = ((USB_DEVICE_CDC_EVENT_DATA_SEND_BREAK *)pData)->breakDuration;

            /* Complete the control transfer by sending a ZLP  */
            USB_DEVICE_ControlStatus(appDataObject->deviceHandle, USB_DEVICE_CONTROL_STATUS_OK);

            break;

        case USB_DEVICE_CDC_EVENT_READ_COMPLETE:

            /* This means that the host has sent some data*/
            eventDataRead = (USB_DEVICE_CDC_EVENT_DATA_READ_COMPLETE *)pData;

            if (eventDataRead->status != USB_DEVICE_CDC_RESULT_ERROR)
            {
                appDataObject->isReadComplete = true;

                appDataObject->numBytesRead = eventDataRead->length;
            }
            break;

        case USB_DEVICE_CDC_EVENT_CONTROL_TRANSFER_DATA_RECEIVED:

            /* The data stage of the last control transfer is
             * complete. For now we accept all the data */

            USB_DEVICE_ControlStatus(appDataObject->deviceHandle, USB_DEVICE_CONTROL_STATUS_OK);
            break;

        case USB_DEVICE_CDC_EVENT_CONTROL_TRANSFER_DATA_SENT:

            /* This means the GET LINE CODING function data is valid. We don't
             * do much with this data in this demo. */
            break;

        case USB_DEVICE_CDC_EVENT_WRITE_COMPLETE:

            /* This means that the data write got completed. We can schedule
             * the next read. */

            appDataObject->isWriteComplete = true;
            break;

        default:
            break;
    }

    return USB_DEVICE_CDC_EVENT_RESPONSE_NONE;
}

/***********************************************
 * Application USB Device Layer Event Handler.
 ***********************************************/
void APP_USBDeviceEventHandler
(
    USB_DEVICE_EVENT event,
    void * eventData,
    uintptr_t context
)
{
    USB_DEVICE_EVENT_DATA_CONFIGURED *configuredEventData;

    switch(event)
    {
        case USB_DEVICE_EVENT_SOF:

            /* This event is used for switch debounce. This flag is reset
             * by the switch process routine. */
            appData.sofEventHasOccurred = true;

            break;

        case USB_DEVICE_EVENT_RESET:

            appData.isConfigured = false;

            break;

        case USB_DEVICE_EVENT_CONFIGURED:

            /* Check the configuration. We only support configuration 1 */
            configuredEventData = (USB_DEVICE_EVENT_DATA_CONFIGURED*)eventData;

            if ( configuredEventData->configurationValue == 1)
            {
                /* Register the CDC Device application event handler here.
                 * Note how the appData object pointer is passed as the
                 * user data */

                USB_DEVICE_CDC_EventHandlerSet(USB_DEVICE_CDC_INDEX_0, APP_USBDeviceCDCEventHandler, (uintptr_t)&appData);

                /* Mark that the device is now configured */
                appData.isConfigured = true;
            }

            break;

        case USB_DEVICE_EVENT_POWER_DETECTED:

            /* VBUS was detected. We can attach the device */
            USB_DEVICE_Attach(appData.deviceHandle);
            WPFM_isConnectingUSB = true;     // @add

            break;

        case USB_DEVICE_EVENT_POWER_REMOVED:

            /* VBUS is not available. We can detach the device */
            USB_DEVICE_Detach(appData.deviceHandle);
            appData.isConfigured = false;
            WPFM_isConnectingUSB = false;    // @add

            break;

        case USB_DEVICE_EVENT_SUSPENDED:

            break;

        case USB_DEVICE_EVENT_RESUMED:
        case USB_DEVICE_EVENT_ERROR:
        default:

            break;
    }
}

// *****************************************************************************
// *****************************************************************************
// Section: Application Local Functions
// *****************************************************************************
// *****************************************************************************

/*****************************************************
 * This function is called in every step of the
 * application state machine.
 *****************************************************/

bool APP_StateReset(void)
{
    /* This function returns true if the device
     * was reset  */

    bool retVal;

    if (! appData.isConfigured)
    {
        appData.state = APP_STATE_WAIT_FOR_CONFIGURATION;
        appData.readTransferHandle = USB_DEVICE_CDC_TRANSFER_HANDLE_INVALID;
        appData.writeTransferHandle = USB_DEVICE_CDC_TRANSFER_HANDLE_INVALID;
        appData.isReadComplete = true;
        appData.isWriteComplete = true;
        retVal = true;
    }
    else
    {
        retVal = false;
    }

    return(retVal);
}

// *****************************************************************************
// *****************************************************************************
// Section: Application Initialization and State Machine Functions
// *****************************************************************************
// *****************************************************************************

/*******************************************************************************
  Function:
    void APP_Initialize(void)

  Remarks:
    See prototype in app.h.
 */

void APP_Initialize(void)
{
    /* Place the App state machine in its initial state. */
    appData.state = APP_STATE_INIT;

    /* Device Layer Handle  */
    appData.deviceHandle = USB_DEVICE_HANDLE_INVALID ;

    /* Device configured status */
    appData.isConfigured = false;

    /* Initial get line coding state */
    appData.getLineCodingData.dwDTERate = 9600;
    appData.getLineCodingData.bParityType = 0;
    appData.getLineCodingData.bCharFormat= 0;
    appData.getLineCodingData.bDataBits = 8;

    /* Read Transfer Handle */
    appData.readTransferHandle = USB_DEVICE_CDC_TRANSFER_HANDLE_INVALID;

    /* Write Transfer Handle */
    appData.writeTransferHandle = USB_DEVICE_CDC_TRANSFER_HANDLE_INVALID;

    /* Initialize the read complete flag */
    appData.isReadComplete = true;

    /*Initialize the write complete flag*/
    appData.isWriteComplete = true;

    /* Initialize Ignore switch flag */
    appData.ignoreSwitchPress = false;

    /* Reset the switch debounce counter */
    appData.switchDebounceTimer = 0;

    /* Reset other flags */
    appData.sofEventHasOccurred = false;

    /* To know status of Switch */
    appData.isSwitchPressed = false;

    /* Set up the read buffer */
    appData.cdcReadBuffer = &cdcReadBuffer[0];

    /* Set up the read buffer */
    appData.cdcWriteBuffer = &cdcWriteBuffer[0];
}


/******************************************************************************
  Function:
    void APP_Tasks(void)

  Remarks:
    See prototype in app.h.
 */

void APP_Tasks(void)
{
    /* Update the application state machine based
     * on the current state */

    switch(appData.state)
    {
        case APP_STATE_INIT:

            /* Open the device layer */
            appData.deviceHandle = USB_DEVICE_Open( USB_DEVICE_INDEX_0, DRV_IO_INTENT_READWRITE );

            if (appData.deviceHandle != USB_DEVICE_HANDLE_INVALID)
            {
                /* Register a callback with device layer to get event notification (for end point 0) */
                USB_DEVICE_EventHandlerSet(appData.deviceHandle, APP_USBDeviceEventHandler, 0);

                appData.state = APP_STATE_WAIT_FOR_CONFIGURATION;
            }
            else
            {
                /* The Device Layer is not ready to be opened. We should try
                 * again later. */
            }

            break;

        case APP_STATE_WAIT_FOR_CONFIGURATION:

            /* Check if the device was configured */
            if (appData.isConfigured)
            {
                /* If the device is configured then lets start reading */
                appData.state = APP_STATE_SCHEDULE_READ;
            }

            break;

        case APP_STATE_SCHEDULE_READ:

            if (APP_StateReset())
            {
                break;
            }

            /* If a read is complete, then schedule a read
             * else wait for the current read to complete */

            appData.state = APP_STATE_WAIT_FOR_READ_COMPLETE;
            if (appData.isReadComplete)
            {
                appData.isReadComplete = false;
                appData.readTransferHandle =  USB_DEVICE_CDC_TRANSFER_HANDLE_INVALID;

                USB_DEVICE_CDC_Read (USB_DEVICE_CDC_INDEX_0,
                        &appData.readTransferHandle, appData.cdcReadBuffer,
                        APP_CDC_BUFFER_SIZE);

                if (appData.readTransferHandle == USB_DEVICE_CDC_TRANSFER_HANDLE_INVALID)
                {
                    appData.state = APP_STATE_ERROR;
                    break;
                }
            }

            break;

        case APP_STATE_WAIT_FOR_READ_COMPLETE:

            if (APP_StateReset())
            {
                break;
            }

            /* Check if a character was received or a switch was pressed.
             * The isReadComplete flag gets updated in the CDC event handler. */

            if (appData.isReadComplete)
            {
                for (int i = 0; i < appData.numBytesRead; i++)
                {
                    _APP_putReadBuffer(appData.cdcReadBuffer[i]);
                }
                appData.numBytesRead = 0;

                //appData.state = APP_STATE_SCHEDULE_WRITE;
                appData.state = APP_STATE_SCHEDULE_READ;
            }

            break;


        case APP_STATE_SCHEDULE_WRITE:

            if (APP_StateReset())
            {
                break;
            }

            /* Setup the write */
            appData.writeTransferHandle = USB_DEVICE_CDC_TRANSFER_HANDLE_INVALID;
            appData.isWriteComplete = false;
            appData.state = APP_STATE_WAIT_FOR_WRITE_COMPLETE;
            USB_DEVICE_CDC_Write(USB_DEVICE_CDC_INDEX_0,
                    &appData.writeTransferHandle, appData.cdcWriteBuffer, appData.numBytesWrite,
                    USB_DEVICE_CDC_TRANSFER_FLAGS_DATA_COMPLETE);
            break;

        case APP_STATE_WAIT_FOR_WRITE_COMPLETE:

            if (APP_StateReset())
            {
                break;
            }

            /* Check if a character was sent. The isWriteComplete
             * flag gets updated in the CDC event handler */

            if (appData.isWriteComplete)
            {
                appData.state = APP_STATE_SCHEDULE_READ;
            }

            break;

        case APP_STATE_ERROR:
        default:

            break;
    }
    // Tact switch handling @add
#if _DAIKOKU_ORG
    if (TC5_TimerPeriodHasExpired())
#else
	if( DLCMatTmChk(2))
#endif
    {
		putst("APP_TC5TO!\r\n");
        switch (WPFM_tactSwStatus)
        {
            case WPFM_TACTSW_STATUS_PRESSING:
                WPFM_tactSwStatus = WPFM_TACTSW_STATUS_PRESSED;
                break;
            case WPFM_TACTSW_STATUS_RELEASING:
                WPFM_tactSwStatus = WPFM_TACTSW_STATUS_NORMAL;
                WPFM_wasButtonPressed = true;
                break;
            default:
                break;
        }
    }
}

/******************************************************************************
  Function:
    void APP_delay(uint32_t ms)

  Remarks:
    See prototype in app.h.
 */

void APP_delay(uint32_t ms)
{
    uint32_t start = SYS_tick;
    while (SYS_tick - start < ms)
    {
        SYS_Tasks();
    }
}

/******************************************************************************
  Function:
    void APP_printUSB(char const *s)

  Remarks:
    See prototype in app.h.
 */

void APP_printUSB(char const *s)
{
    // Wait for previous write operation has completed
    while (! appData.isWriteComplete)
        SYS_Tasks();

    strcpy((char *)appData.cdcWriteBuffer, s);
    appData.numBytesWrite = strlen(s);
    appData.state = APP_STATE_SCHEDULE_WRITE;

    SYS_Tasks();
}

/******************************************************************************
  Function:
    void APP_printlnUSB(char const *s)

  Remarks:
    See prototype in app.h.
 */

void APP_printlnUSB(char const *s)
{
    // Wait for previous write operation has completed
    while (! appData.isWriteComplete)
        SYS_Tasks();

    strcpy((char *)appData.cdcWriteBuffer, s);
    strcat((char *)appData.cdcWriteBuffer, "\n");
    appData.numBytesWrite = strlen(s) + 1;
    appData.state = APP_STATE_SCHEDULE_WRITE;

    SYS_Tasks();
}

/******************************************************************************
  Function:
    void APP_writeUSB(uint8_t const *data, uint16_t size)

  Remarks:
    See prototype in app.h.
 */

int APP_writeUSB(uint8_t const *data, uint16_t size)
{
    // Wait for previous write operation has completed
    while (! appData.isWriteComplete)
        SYS_Tasks();

    int stat = APP_ERR_NONE;
    if (size > APP_CDC_BUFFER_SIZE)
    {
        size = APP_CDC_BUFFER_SIZE;
        stat = APP_ERR_PARAM;
    }
    memcpy((void *)appData.cdcWriteBuffer, (void *)data, size);
    appData.numBytesWrite = size;
    appData.state = APP_STATE_SCHEDULE_WRITE;

    SYS_Tasks();

    return (stat);
}

/******************************************************************************
  Function:
    int APP_readUSB(uint8_t data[], uint16_t size)

  Remarks:
    See prototype in app.h.
 */

int APP_readUSB(uint8_t *data_p, uint16_t size)
{
    int readBytes = 0;
    for ( ; readBytes < (int)size; readBytes++)
    {
        if (! _APP_getReadBuffer(data_p++))
        {
            break;      // exit loop if empty
        }
    }

    return (readBytes);
}

/******************************************************************************
  Function:
    int APP_getRemainedBytesUSB(void)

  Remarks:
    See prototype in app.h.
 */

int APP_getRemainedBytesUSB(void)
{
    int remainedBytes = _APP_ReadBufferHead - _APP_ReadBufferTail;
    if (remainedBytes < 0)
    {
        remainedBytes += APP_USB_BUFFER_SIZE;
    }

    return (remainedBytes);
}

/******************************************************************************
  Function:
    int APP_getByteUSB(void)

  Remarks:
    See prototype in app.h.
 */

uint8_t APP_getByteUSB(void)
{
    char data = 0;
    if (! _APP_getReadBuffer((uint8_t *)&data))
    {
        return (0);     // read buffer empty
    }

    return (data);      // okey
}

/******************************************************************************
  Function:
    int APP_putByteUSB(void)

  Remarks:
    See prototype in app.h.
 */

int APP_putByteUSB(uint8_t data)
{
    if (APP_writeUSB(&data, 1) != APP_ERR_NONE)
    {
        return (0);     // write buffer full
    }

    return (1);     // okey
}

/*******************************************************************************
 Local functions
 */

static bool _APP_getReadBuffer(uint8_t *data_p)
{
    if (_APP_ReadBufferHead == _APP_ReadBufferTail)
    {
        return (false);
    }
    *data_p = _APP_ReadBuffer[_APP_ReadBufferTail++];

    if (_APP_ReadBufferTail >= APP_USB_BUFFER_SIZE)
    {
        _APP_ReadBufferTail = 0;
    }

    return (true);
}

static bool _APP_putReadBuffer(uint8_t data)
{
    if (_APP_ReadBufferHead >= APP_USB_BUFFER_SIZE)
    {
        _APP_ReadBufferHead = 0;
    }
    _APP_ReadBuffer[_APP_ReadBufferHead++] = data;

    return (true);
}

/*******************************************************************************
 End of File
 */
