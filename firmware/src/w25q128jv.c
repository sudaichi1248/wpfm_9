/*
 * File:    w25q128jv.c
 * Author:  Interark Corp.
 * Summary: Serial Flash Memory (W25Q128JV*) driver implementation file.
 * Date:    2022/06/19 (R0)
 * Note:    Refer to W25Q128JV datasheet(27/Mar/2018 Rev.F)
 */

#include <string.h>
#include "w25q128jv.h"

// Instructions(commands)
  // Write control
#define CMD_WRITE_ENABLE                0x06
#define CMD_VOLATILE_SR_WRITE_ENABLE    0x50
#define CMD_WRITE_DISABLE               0x04
  // ID
#define CMD_RELEASE_POWER_DOWN          0xab
#define CMD_MANUFACTURE_DEVICE_ID       0x90
#define CMD_JEDEC_ID                    0x9f
#define CMD_READ_UNIQUE_ID              0x4b
  // Read
#define CMD_READ_DATA                   0x03
#define CMD_FAST_READ                   0x0b
  // Program(Write)
#define CMD_PAGE_PROGRAM                0x02
  // Erase
#define CMD_SECTOR_ERASE                0x20
#define CMD_BLOCK32_ERASE               0x52    // Not implemented
#define CMD_BLOCK64_ERASE               0xd8
#define CMD_CHIP_ERASE                  0xc7
  // Status registers
#define CMD_READ_STATUS_REG1            0x05
#define CMD_WRITE_STATUS_REG1           0x01
#define CMD_READ_STATUS_REG2            0x35
#define CMD_WRITE_STATUS_REG2           0x31
#define CMD_READ_STATUS_REG3            0x15
#define CMD_WRITE_STATUS_REG3           0x11
  // Security
#define CMD_READ_SFDP_REG               0x5a    // Not implemented
#define CMD_ERASE_SECURITY_REG          0x44    // Not implemented
#define CMD_PROGRAM_SECURITY_REG        0x42    // Not implemented
#define CMD_READ_SECURITY_REG           0x48    // Not implemented
  // Lock/Unlock
#define CMD_GLOBAL_BLOCK_LOCK           0x7e
#define CMD_GLOBAL_BLOCK_UNLOCK         0x98
#define CMD_READ_BLOCK_SECTOR_LOCK      0x3d
#define CMD_INDIVIDUAL_BLOCK_LOCK       0x36
#define CMD_INDIVIDUAL_BLOCK_UNLOCK     0x39
  // Control
#define CMD_ERASE_PROGRAM_SUSPEND       0x75    // Not implemented
#define CMD_ERASE_PROGRAM_RESUME        0x7a    // Not implemented
#define CMD_POWER_DOWN                  0xb9
  // Reset
#define CMD_ENBALE_RESET                0x66
#define CMD_RESET_DEVICE                0x99

// Macros (@important this macro support PA** only, can't use PB**)
#define selectChip()                    (PORT_REGS->GROUP[0].PORT_OUTCLR = ((uint32_t)1U << (_csPin)))
#define deselectChip()                  (PORT_REGS->GROUP[0].PORT_OUTSET = ((uint32_t)1U << (_csPin)))

/*
*   local(statis) variables
*/
uint32_t _csPin = -1;           // CS(Chip Select) pin, active low

/*
*   Functions
*/
int W25Q128JV_begin(uint32_t csPin)
{
    _csPin = csPin;
    deselectChip();

    return (W25Q128JV_ERR_NONE);
}

int W25Q128JV_end(void)
{
    W25Q128JV_powerDown();
    deselectChip();

    return (W25Q128JV_ERR_NONE);
}

int W25Q128JV_writeEnable(void)
{
    uint8_t txData[1];
    txData[0] = CMD_WRITE_ENABLE;

    selectChip();
    bool stat = SERCOM1_SPI_Write((void *)txData, 1);
    if (! stat)
    {
        return (W25Q128JV_ERR_SPI);
    }
    while (SERCOM1_SPI_IsBusy())
        ;
    deselectChip();

    return (W25Q128JV_ERR_NONE);
}

int W25Q128JV_writeVolatileSREnable(void)
{
    uint8_t txData[1];
    txData[0] = CMD_VOLATILE_SR_WRITE_ENABLE;

    selectChip();
    bool stat = SERCOM1_SPI_Write((void *)txData, 1);
    if (! stat)
    {
        return (W25Q128JV_ERR_SPI);
    }
    while (SERCOM1_SPI_IsBusy())
        ;
    deselectChip();

    return (W25Q128JV_ERR_NONE);
}

int W25Q128JV_writeDisable(void)
{
    uint8_t txData[1];
    txData[0] = CMD_WRITE_DISABLE;

    selectChip();
    bool stat = SERCOM1_SPI_Write((void *)txData, 1);
    if (! stat)
    {
        return (W25Q128JV_ERR_SPI);
    }
    while (SERCOM1_SPI_IsBusy())
        ;
    deselectChip();

    return (W25Q128JV_ERR_NONE);
}

int W25Q128JV_powerDown(void)
{
    uint8_t txData[1];
    txData[0] = CMD_POWER_DOWN;

    selectChip();
    bool stat = SERCOM1_SPI_Write((void *)txData, 1);
    if (! stat)
    {
        return (W25Q128JV_ERR_SPI);
    }
    while (SERCOM1_SPI_IsBusy())
        ;
    deselectChip();

    return (W25Q128JV_ERR_NONE);
}

int W25Q128JV_releasePowerDown(void)
{
    uint8_t txData[4], rxData[1];
    memset(txData, 0, sizeof(txData));
    memset(rxData, 0, sizeof(rxData));
    txData[0] = CMD_RELEASE_POWER_DOWN;

    selectChip();
    bool stat = SERCOM1_SPI_Write((void *)txData, 4);
    if (! stat)
    {
        return (W25Q128JV_ERR_SPI);
    }
    while (SERCOM1_SPI_IsBusy())
        ;

    stat = SERCOM1_SPI_Read((void *)rxData, 1);
    if (! stat)
    {
        return (W25Q128JV_ERR_SPI);
    }
    while (SERCOM1_SPI_IsBusy())
        ;
    deselectChip();

    return (W25Q128JV_ERR_NONE);
}

int W25Q128JV_readManufactureDeviceID(uint8_t *manufactureID_p, uint8_t *deviceID_p)
{
    uint8_t txData[4], rxData[2];
    memset(txData, 0, sizeof(txData));
    memset(rxData, 0, sizeof(rxData));
    txData[0] = CMD_MANUFACTURE_DEVICE_ID;

    selectChip();
    bool stat = SERCOM1_SPI_Write((void *)txData, 4);
    if (! stat)
    {
        return (W25Q128JV_ERR_SPI);
    }
    while (SERCOM1_SPI_IsBusy())
        ;

    stat = SERCOM1_SPI_Read((void *)rxData, 2);
    if (! stat)
    {
        return (W25Q128JV_ERR_SPI);
    }
    while (SERCOM1_SPI_IsBusy())
        ;
    deselectChip();

    *manufactureID_p = rxData[0];   // 0x17 (winbond)
    *deviceID_p = rxData[1];

    return (W25Q128JV_ERR_NONE);
}

int W25Q128JV_readJEDECID(uint8_t *manufactureID_p, uint16_t *jedecID_p)
{
    uint8_t txData[1], rxData[3];
    memset(rxData, 0, sizeof(rxData));
    txData[0] = CMD_JEDEC_ID;

    selectChip();
    bool stat = SERCOM1_SPI_Write((void *)txData, 1);
    if (! stat)
    {
        return (W25Q128JV_ERR_SPI);
    }
    while (SERCOM1_SPI_IsBusy())
        ;

    stat = SERCOM1_SPI_Read((void *)rxData, 3);
    if (! stat)
    {
        return (W25Q128JV_ERR_SPI);
    }
    while (SERCOM1_SPI_IsBusy())
        ;
    deselectChip();

    *manufactureID_p = rxData[0];   // 0x17 (winbond)
    *jedecID_p = ((uint16_t)rxData[1] << 8) | rxData[2];

    return (W25Q128JV_ERR_NONE);
}

int W25Q128JV_readUniqueID(uint8_t uid[])
{
    uint8_t txData[5], rxData[W25Q128JV_UNIQUE_ID_LENGTH];
    memset(txData, 0, sizeof(txData));
    memset(rxData, 0, sizeof(rxData));
    txData[0] = CMD_READ_UNIQUE_ID;

    selectChip();
    bool stat = SERCOM1_SPI_Write((void *)txData, 5);
    if (! stat)
    {
        return (W25Q128JV_ERR_SPI);
    }
    while (SERCOM1_SPI_IsBusy())
        ;

    stat = SERCOM1_SPI_Read((void *)rxData, W25Q128JV_UNIQUE_ID_LENGTH);
    if (! stat)
    {
        return (W25Q128JV_ERR_SPI);
    }
    while (SERCOM1_SPI_IsBusy())
        ;
    deselectChip();

    memcpy(uid, rxData, W25Q128JV_UNIQUE_ID_LENGTH);

    return (W25Q128JV_ERR_NONE);
}

int W25Q128JV_readData(uint32_t addr, uint8_t *buf, uint16_t length)
{
    if (length > W25Q128JV_MAX_READ_SIZE)
        return (W25Q128JV_ERR_SIZE);

    uint8_t txData[4];
    txData[0] = CMD_READ_DATA;
    txData[1] = (addr >> 16) & 0xFF;
    txData[2] = (addr >> 8) & 0xFF;
    txData[3] = addr & 0xFF;

    selectChip();
    bool stat = SERCOM1_SPI_Write((void *)txData, 4);
    if (! stat)
    {
        return (W25Q128JV_ERR_SPI);
    }
    while (SERCOM1_SPI_IsBusy())
        ;

    stat = SERCOM1_SPI_Read((void *)buf, length);
    if (! stat)
    {
        return (W25Q128JV_ERR_SPI);
    }
    while (SERCOM1_SPI_IsBusy())
        ;
    deselectChip();

    return (W25Q128JV_ERR_NONE);
}

int W25Q128JV_readDataFaster(uint32_t addr, uint8_t *buf, uint16_t length)
{
    if (length > W25Q128JV_MAX_READ_SIZE)
        return (W25Q128JV_ERR_SIZE);

    uint8_t txData[4];
    txData[0] = CMD_FAST_READ;
    txData[1] = (addr >> 16) & 0xFF;
    txData[2] = (addr >> 8) & 0xFF;
    txData[3] = addr & 0xFF;

    selectChip();
    bool stat = SERCOM1_SPI_Write((void *)txData, 4);
    if (! stat)
    {
        return (W25Q128JV_ERR_SPI);
    }
    while (SERCOM1_SPI_IsBusy())
        ;

    // generate dummy clock
    uint8_t dummy;
    stat = SERCOM1_SPI_Read((void *)&dummy, 1);
    if (! stat)
    {
        return (W25Q128JV_ERR_SPI);
    }
    while (SERCOM1_SPI_IsBusy())
        ;
    stat = SERCOM1_SPI_Read((void *)buf, length);
    // read data realy
    if (! stat)
    {
        return (W25Q128JV_ERR_SPI);
    }
    while (SERCOM1_SPI_IsBusy())
        ;
    deselectChip();

    return (W25Q128JV_ERR_NONE);
}

bool W25Q128JV_isBusy(void)
{
    uint8_t value;
    if (W25Q128JV_readStatusRegister(1, &value) == W25Q128JV_ERR_NONE)
    {
        return (value & W25Q128JV_STATUS1_BUSY);
    }

    return (false);
}

int W25Q128JV_programPage(uint16_t pageNo, uint8_t offset, uint8_t *data, uint16_t dataSize, bool wait)
{
    if ((uint16_t)offset + dataSize > W25Q128JV_PAGE_SIZE)
    {
        return (W25Q128JV_ERR_SIZE);
    }

    W25Q128JV_writeEnable();

    uint8_t txData[4];
    txData[0] = CMD_PAGE_PROGRAM;
    txData[1] = (pageNo >> 8) & 0xFF;
    txData[2] = pageNo & 0xFF;
    txData[3] = offset;

    selectChip();
    bool stat = SERCOM1_SPI_Write((void *)txData, 4);
    if (! stat)
    {
        return (W25Q128JV_ERR_SPI);
    }
    while (SERCOM1_SPI_IsBusy())
        ;
    stat = SERCOM1_SPI_Write((void *)data, dataSize);
    if (! stat)
    {
        return (W25Q128JV_ERR_SPI);
    }
    while (SERCOM1_SPI_IsBusy())
        ;
    deselectChip();

    if (wait)
    {
        // Wait until programming is done
        while (W25Q128JV_isBusy())
            ;
    }

    return (W25Q128JV_ERR_NONE);
}

int W25Q128JV_eraseSctor(uint16_t sectorNo, bool wait)
{
    uint8_t txData[4];
    txData[0] = CMD_SECTOR_ERASE;
    txData[1] = (sectorNo >> 4) & 0xFF;
    txData[2] = (sectorNo << 4) & 0xFF;
    txData[3] = 0;

    W25Q128JV_writeEnable();

    selectChip();
    bool stat = SERCOM1_SPI_Write((void *)txData, 4);
    if (! stat)
    {
        return (W25Q128JV_ERR_SPI);
    }
    while (SERCOM1_SPI_IsBusy())
        ;
    deselectChip();

    if (wait)
    {
        // Wait until erasing is done
        while (W25Q128JV_isBusy())
            ;
    }

    return (W25Q128JV_ERR_NONE);
}

int W25Q128JV_eraseBlock64(uint8_t blockNo, bool wait)
{
    uint8_t txData[4];
    txData[0] = CMD_BLOCK64_ERASE;
    txData[1] = blockNo;
    txData[2] = 0;
    txData[3] = 0;

    W25Q128JV_writeEnable();

    selectChip();
    bool stat = SERCOM1_SPI_Write((void *)txData, 4);
    if (! stat)
    {
        return (W25Q128JV_ERR_SPI);
    }
    while (SERCOM1_SPI_IsBusy())
        ;
    deselectChip();

    if (wait)
    {
        // Wait until erasing is done
        while (W25Q128JV_isBusy())
            ;
    }

    return (W25Q128JV_ERR_NONE);
}

int W25Q128JV_eraseChip(bool wait)
{
    uint8_t txData[1];
    txData[0] = CMD_CHIP_ERASE;

    W25Q128JV_writeEnable();

    selectChip();
    bool stat = SERCOM1_SPI_Write((void *)txData, 1);
    if (! stat)
    {
        return (W25Q128JV_ERR_SPI);
    }
    while (SERCOM1_SPI_IsBusy())
        ;
    deselectChip();

    if (wait)
    {
        // Wait until erasing is done
        while (W25Q128JV_isBusy())
            ;
    }

    return (W25Q128JV_ERR_NONE);
}

int W25Q128JV_readStatusRegister(uint8_t registerNo, uint8_t *reg_p)
{
    uint8_t txData[1], rxData[1];
    memset(rxData, 0, sizeof(rxData));
    switch (registerNo) {
        case 1:
            txData[0] = CMD_READ_STATUS_REG1;
            break;
        case 2:
            txData[0] = CMD_READ_STATUS_REG2;
            break;
        case 3:
            txData[0] = CMD_READ_STATUS_REG3;
            break;
        default:
            return (W25Q128JV_ERR_PARAM);
    }

    selectChip();
    bool stat = SERCOM1_SPI_Write((void *)txData, 1);
    if (! stat)
    {
        return (W25Q128JV_ERR_SPI);
    }
    while (SERCOM1_SPI_IsBusy())
        ;

    stat = SERCOM1_SPI_Read((void *)rxData, 1);
    if (! stat)
    {
        return (W25Q128JV_ERR_SPI);
    }
    while (SERCOM1_SPI_IsBusy())
        ;
    deselectChip();

    *reg_p = rxData[0];

    return (W25Q128JV_ERR_NONE);
}

int W25Q128JV_writeStatusRegister(uint8_t registerNo, uint8_t data)
{
    uint8_t txData[2];
    txData[1] = data;
    switch (registerNo) {
        case 1:
            txData[0] = CMD_WRITE_STATUS_REG1;
            break;
        case 2:
            txData[0] = CMD_WRITE_STATUS_REG2;
            break;
        case 3:
            txData[0] = CMD_WRITE_STATUS_REG3;
            break;
        default:
            return (W25Q128JV_ERR_PARAM);
    }

    selectChip();
    bool stat = SERCOM1_SPI_Write((void *)txData, 2);
    if (! stat)
    {
        return (W25Q128JV_ERR_SPI);
    }
    while (SERCOM1_SPI_IsBusy())
        ;
    deselectChip();

    return (W25Q128JV_ERR_NONE);
}

int W25Q128JV_lockGlobalBlock(void)
{
    uint8_t txData[1];
    txData[0] = CMD_GLOBAL_BLOCK_LOCK;

    W25Q128JV_writeEnable();

    selectChip();
    bool stat = SERCOM1_SPI_Write((void *)txData, 1);
    if (! stat)
    {
        return (W25Q128JV_ERR_SPI);
    }
    while (SERCOM1_SPI_IsBusy())
        ;
    deselectChip();

    return (W25Q128JV_ERR_NONE);
}

int W25Q128JV_unlockGlobalLock(void)
{
    uint8_t txData[1];
    txData[0] = CMD_GLOBAL_BLOCK_UNLOCK;

    W25Q128JV_writeEnable();

    selectChip();
    bool stat = SERCOM1_SPI_Write((void *)txData, 1);
    if (! stat)
    {
        return (W25Q128JV_ERR_SPI);
    }
    while (SERCOM1_SPI_IsBusy())
        ;
    deselectChip();

    return (W25Q128JV_ERR_NONE);
}

int W25Q128JV_resetDevice(void)
{
    uint8_t txData[1];

    // (1) enable reset
    txData[0] = CMD_ENBALE_RESET;
    selectChip();
    bool stat = SERCOM1_SPI_Write((void *)txData, 1);
    if (! stat)
    {
        return (W25Q128JV_ERR_SPI);
    }
    while (SERCOM1_SPI_IsBusy())
        ;
    deselectChip();

    // (2) reset device
    txData[0] = CMD_RESET_DEVICE;
    selectChip();
    stat = SERCOM1_SPI_Write((void *)txData, 1);
    if (! stat)
    {
        return (W25Q128JV_ERR_SPI);
    }
    while (SERCOM1_SPI_IsBusy())
        ;
    deselectChip();

    // will take approximately 30uS to reset device.

    return (W25Q128JV_ERR_NONE);
}

int W25Q128JV_readBlockOrSectorLock(uint32_t addr, bool *locked_p)
{
    uint8_t txData[4];
    txData[0] = CMD_READ_BLOCK_SECTOR_LOCK;
    txData[1] = (addr >> 16) & 0xFF;
    txData[2] = (addr >> 8) & 0xFF;
    txData[3] = 0;

    selectChip();
    bool stat = SERCOM1_SPI_Write((void *)txData, 4);
    if (! stat)
    {
        return (W25Q128JV_ERR_SPI);
    }
    while (SERCOM1_SPI_IsBusy())
        ;

    uint8_t locked;
    stat = SERCOM1_SPI_Read((void *)&locked, 1);
    if (! stat)
    {
        return (W25Q128JV_ERR_SPI);
    }
    while (SERCOM1_SPI_IsBusy())
        ;
    deselectChip();

    *locked_p = locked & 0x01;

    return (W25Q128JV_ERR_NONE);
}

int W25Q128JV_lockBlockOrSector(uint32_t addr)
{
    uint8_t txData[4];
    txData[0] = CMD_INDIVIDUAL_BLOCK_LOCK;
    txData[1] = (addr >> 16) & 0xFF;
    txData[2] = (addr >> 8) & 0xFF;
    txData[3] = 0;

    selectChip();
    bool stat = SERCOM1_SPI_Write((void *)txData, 4);
    if (! stat)
    {
        return (W25Q128JV_ERR_SPI);
    }
    while (SERCOM1_SPI_IsBusy())
        ;

    return (W25Q128JV_ERR_NONE);
}

int W25Q128JV_unlockBlockOrSector(uint32_t addr)
{
    uint8_t txData[4];
    txData[0] = CMD_INDIVIDUAL_BLOCK_UNLOCK;
    txData[1] = (addr >> 16) & 0xFF;
    txData[2] = (addr >> 8) & 0xFF;
    txData[3] = 0;

    selectChip();
    bool stat = SERCOM1_SPI_Write((void *)txData, 4);
    if (! stat)
    {
        return (W25Q128JV_ERR_SPI);
    }
    while (SERCOM1_SPI_IsBusy())
        ;

    return (W25Q128JV_ERR_NONE);
}
