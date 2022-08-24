/*
 * File:    w25q128jv.h
 * Author:  Interark Corp.
 * Summary: Serial Flash Memory (W25Q128JV*) driver header file.
 * Date:    2022/06/23 (R0)
 * Note:    Refer to W25Q128JV datasheet(27/Mar/2018 Rev.F)
 */

#ifndef W25Q128JV_H
#define	W25Q128JV_H

#ifdef	__cplusplus
extern "C" {
#endif

#include "definitions.h"

/***
*   Flash memory W25Q128JV structure:
*       PAGE * 16(4-bit) -> SECTOR * 16(4-bit) -> BLOCK64 * 256(8-bit) -> CHIP
*
*   address:
*       XX0000  .. Block(64k) address
*       XXS000  .. Sector(4k) address
*       XXSP00  .. Page(256) address
*       XXSP**  .. address pointo to a byte (** is offset in page)
***/

/*
*   Symbols
*/
  // Metrics
#define W25Q128JV_PAGE_SIZE             256         // Size per page [bytes]
#define W25Q128JV_SECTOR_SIZE           4096        // Size per sector [bytes]
#define W25Q128JV_BLOCK64_SIZE          65536       // Seize per block(64) [bytes]
#define W25Q128JV_NUM_PAGE              16          // number of pages per sector
#define W25Q128JV_NUM_SECTOR            16          // number of secors per block64
#define W25Q128JV_NUM_BLOCK64           256         // number of block64s per chip
  // ID
#define W25Q128JV_MANUFACTURE_ID        0xef        // Winbond Serial Flash
#define W25Q128JV_DEVICE_ID             0x17        // W25Q128JV-IM
  // Misc. constants
#define W25Q128JV_MAX_READ_SIZE         65535       // Maximum size that can be read at one time [bytes]
#define W25Q128JV_UNIQUE_ID_LENGTH      8           // Unique ID length [bytes]
  // STATUS REGISTER #1 bit
#define W25Q128JV_STATUS1_SRP           0x80        // Status register protect
#define W25Q128JV_STATUS1_SEC           0x40        // Sector protect
#define W25Q128JV_STATUS1_TB            0x20        // Top/Bottom protect
#define W25Q128JV_STATUS1_BP2           0x10        // Block protect bit #2
#define W25Q128JV_STATUS1_BP1           0x08        // Block protect bit #1
#define W25Q128JV_STATUS1_BP0           0x04        // Block protect bit #0
#define W25Q128JV_STATUS1_WEL           0x02        // Write enable latch(read-only)
#define W25Q128JV_STATUS1_BUSY          0x01        // Write in progress(read-only)
  // STATUS REGISTER #2 bit
#define W25Q128JV_STATUS2_SUS           0x80        // Suspend status
#define W25Q128JV_STATUS2_CMP           0x40        // Complement protect(read-only)
#define W25Q128JV_STATUS2_LB3           0x20        // Security register lock bit #3
#define W25Q128JV_STATUS2_LB2           0x10        // Security register lock bit #2
#define W25Q128JV_STATUS2_LB1           0x08        // Security register lock bit #1
#define W25Q128JV_STATUS2_QE            0x02        // Quad enbale
#define W25Q128JV_STATUS2_SRL           0x01        // Status register lock
// STATUS REGISTER #3 bit
#define W25Q128JV_STATUS3_DRV1          0x40        // Output driver strength #1
#define W25Q128JV_STATUS3_DRV2          0x20        // Output driver strength #2
#define W25Q128JV_STATUS3_WPS           0x04        // Write protect selection

/*
*   Error codes
*/
#define W25Q128JV_ERR_NONE              0           // success(no error)
#define W25Q128JV_ERR_PARAM             (-1)        // parameter error
#define W25Q128JV_ERR_SPI               (-2)        // SPI error
#define W25Q128JV_ERR_SIZE              (-3)        // Invalid size
#define W25Q128JV_ERR_BUSY              (-4)        // In progress
#define W25Q128JV_ERR_WRITE             (-10)       // Can't set writable

/*
*   Functions
*/
// Control functions
extern int W25Q128JV_begin(uint32_t csPin);
extern int W25Q128JV_end(void);
extern int W25Q128JV_writeEnable(void);
extern int W25Q128JV_writeVolatileSREnable(void);
extern int W25Q128JV_writeDisable(void);
extern bool W25Q128JV_isBusy(void);
extern int W25Q128JV_powerDown(void);
extern int W25Q128JV_releasePowerDown(void);
// ID functions
extern int W25Q128JV_readManufactureDeviceID(uint8_t *manufactureID_p, uint8_t *deviceID_p);
extern int W25Q128JV_readJEDECID(uint8_t *manufactureID_p, uint16_t *jedecID_p);
extern int W25Q128JV_readUniqueID(uint8_t uid[]);
// Lock/unlock functions
extern int W25Q128JV_lockGlobalBlock(void);
extern int W25Q128JV_unlockGlobalLock(void);
extern int W25Q128JV_readBlockOrSectorLock(uint32_t addr, bool *locked_p);
extern int W25Q128JV_lockBlockOrSector(uint32_t addr);
extern int W25Q128JV_unlockBlockOrSector(uint32_t addr);
// Read functions
extern int W25Q128JV_readData(uint32_t addr, uint8_t *buf, uint16_t length);
extern int W25Q128JV_readDataFaster(uint32_t addr, uint8_t *buf, uint16_t length);
// Program and erase functions
extern int W25Q128JV_programPage(uint16_t pageNo, uint8_t offset, uint8_t *data, uint16_t dataSize, bool wait);
extern int W25Q128JV_eraseSctor(uint16_t sectorNo, bool wait);
extern int W25Q128JV_eraseBlock64(uint8_t blockNo, bool wait);
extern int W25Q128JV_eraseChip(bool wait);
// low level functions
extern int W25Q128JV_readStatusRegister(uint8_t registerNo, uint8_t *data_p);
extern int W25Q128JV_writeStatusRegister(uint8_t registerNo, uint8_t data);
// Soft reset function
extern int W25Q128JV_resetDevice(void);

#ifdef	__cplusplus
}
#endif

#endif	/* W25Q128JV_H */
