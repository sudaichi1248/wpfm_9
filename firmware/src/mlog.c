/*
 * File:    mlog.c
 * Author:  Interark Corp.
 * Summary: Measure log implementation file.
 * Date:    2022/08/18 (R0)
 *          2022/09/09 (R0.1) Support temporary SRAM log
 *          2022/10/08 (R0.3) fix bug related to return error value of findLogBySN()
 *          2022/10/19 (R0.4) fix MLOG_checkLogs() as release mode
 * Note:
 *          Use 2KB of SRAM for temporary SRAM log (R1)
 */

// build configuration
#define DEBUG_UART           // Debug with UART

#include <string.h>
#include <stdio.h>
#include "app.h"
#include "w25q128jv.h"
#include "mlog.h"
#include "debug.h"
// 測定logリングバッファ試験用
#include "rtc.h"
#include "wpfm.h"

/*
*   Macros
*/
#define IS_NOT_USED_SN(sn)      ((sn) == ~(uint32_t)0)          // sequential number "sn" is not used ?

/*
*   Symbols
*/
#define BAD_MLOG_ADDRESS        (MLOG_ADDRESS_MLOG_LAST+1)      // use as bad address(=error)

/*
*   Local(static) variables and functions
*/
static uint32_t     _MLOG_headAddress    = 0;           // address of head log (point next address)
static uint32_t     _MLOG_tailAddress    = 0;           // address of tail log for upload
static uint32_t     _MLOG_oldestAddress  = 0;           // oldest log address in chip
static uint32_t     _MLOG_latestAddress  = 0;           // latest log address in chip
static uint32_t     _MLOG_lastSequentialNumber = 0;     // last sequentila number (1..MAX_UINT32-1)
static uint32_t     _MLOG_oldestSequentialNumber = 0;   // oldest sequentila number in flash-memory
  // SRAM
static bool         _MLOG_switchToSRAM   = false;       // is the storage destination SRAM ?
static uint8_t      _MLOG_storages[MLOG_SRAM_SIZE];     // log buffer on SRAM (not ring buffer)
static uint32_t     _MLOG_headAddressOnSRAM= 0;         // address of head log (point next address) on SRAM
static uint32_t     _MLOG_tailAddressOnSRAM= 0;         // address of tail log for upload on SRAM
  // for work
static uint8_t      _MLOG_pageBuffer[W25Q128JV_PAGE_SIZE];  // Working buffer(on SRAM)

static void dumpLog(char const *prefix, MLOG_ID_T mlogId, MLOG_T *log_p);
static uint32_t findLogBySN(uint32_t sn);
static int _MLOG_getLogOnSRAM(MLOG_T *log_p);


int MLOG_begin(bool fullScan)
{
    // Check IDs
    uint8_t manufactureID, deviceID;
    if (W25Q128JV_readManufactureDeviceID(&manufactureID, &deviceID) != W25Q128JV_ERR_NONE)
    {
        return (MLOG_ERR_READ_ID);
    }
    if (manufactureID != W25Q128JV_MANUFACTURE_ID || deviceID != W25Q128JV_DEVICE_ID)
    {
        return (MLOG_ERR_BAD_ID);
    }

    // Set up temporaly SRAM buffer
    _MLOG_headAddressOnSRAM = _MLOG_tailAddressOnSRAM = (uint32_t)_MLOG_storages;

    // Check all logs
    if (fullScan)
    {
        return (MLOG_checkLogs(false));
    }

    return (MLOG_ERR_NONE);
}

int MLOG_putLog(MLOG_T *log_p, bool specifySN)
{
    DEBUG_UART_printlnFormat("_MLOG_headAddress=%06x,%d", (unsigned int)_MLOG_headAddress, specifySN); APP_delay(2);
    if ((_MLOG_headAddress & 0xfff) == 0)
    {
        // if page number and offset are zero - first log in current sector
        DEBUG_UART_printlnFormat("head=%06Xh", (unsigned int)_MLOG_headAddress);
        uint16_t sectorNo = (_MLOG_headAddress >> 12) & 0x0fff;
        DEBUG_UART_printlnFormat("eraseSector(%04Xh)", (unsigned int)sectorNo);
        if (W25Q128JV_eraseSctor(sectorNo, true) != W25Q128JV_ERR_NONE)
        {
            return (MLOG_ERR_ERASE);
        }
        DEBUG_UART_printlnFormat("eraseSector(%04Xh): done", (unsigned int)sectorNo);
    }
    uint16_t pageNo = _MLOG_headAddress >> 8;
    uint8_t offset = _MLOG_headAddress & 0xff;
    if (! specifySN)
    {
        _MLOG_lastSequentialNumber++;       // Increment sequential number
        if (_MLOG_lastSequentialNumber == 0)
        {
            // Overflow sequential number
            DEBUG_UART_printlnString("MLOG_putLog(): Overflow sequential number");
        }
        log_p->sequentialNumber = _MLOG_lastSequentialNumber;
    }
    DEBUG_UART_printlnFormat("programPage(%04Xh,%02Xh):", (unsigned int)pageNo, (unsigned int)offset);
    if (W25Q128JV_programPage(pageNo, offset, (uint8_t *)log_p, MLOG_RECORD_SIZE, true) != W25Q128JV_ERR_NONE)
    {
        return (MLOG_ERR_PROGRAM_PAGE);
    }
    MLOG_ID_T mlogID = (pageNo << 8) + offset;
    dumpLog(">", mlogID, log_p);

    // update _MLOG_headAddress for next use
    if (offset < MLOG_RECORD_SIZE * (MLOG_LOGS_PER_PAGE - 1))
    {
        offset += MLOG_RECORD_SIZE;
    }
    else
    {
        offset = 0;
        if (++pageNo > (MLOG_ADDRESS_MLOG_LAST >> 8))
        {
            pageNo = 0;     // back to top
        }
    }
    _MLOG_headAddress = ((uint32_t)pageNo << 8) + offset;
    //DEBUG_UART_printlnFormat("_MLOG_headAddress=%06x", (unsigned int)_MLOG_headAddress);

    return ((int)mlogID);       // return mlog ID when succeed
}

int MLOG_getLog(MLOG_T *log_p)
{
    if (_MLOG_headAddress == _MLOG_tailAddress)
    {
        return (MLOG_ERR_EMPTY);
    }

    if (W25Q128JV_readData(_MLOG_tailAddress, (uint8_t *)log_p, MLOG_RECORD_SIZE) != W25Q128JV_ERR_NONE)
    {
        return (MLOG_ERR_READ);
    }
    MLOG_ID_T mlogID = _MLOG_tailAddress;
    //dumpLog("<", mlogID, log_p);

    // update _MLOG_tailAddress for next use
    uint16_t pageNo = _MLOG_tailAddress >> 8;
    uint8_t offset = _MLOG_tailAddress & 0xff;
    if (offset < MLOG_RECORD_SIZE * (MLOG_LOGS_PER_PAGE - 1))
    {
        offset += MLOG_RECORD_SIZE;
    }
    else
    {
        // mark as uploaded
        offset = W25Q128JV_PAGE_SIZE - 1;   // uploaded flag at last offset in the page
        uint8_t flag = 0x00;
        if (W25Q128JV_programPage(pageNo, offset, (uint8_t *)&flag, 1, true) != W25Q128JV_ERR_NONE)
        {
            return (MLOG_ERR_PROGRAM_PAGE);
        }
        DEBUG_UART_printlnFormat("MARK %04X%02X AS %02Xh", (unsigned int)pageNo, (unsigned int)offset, flag);

        // turn the page
        offset = 0;
        if (++pageNo > (MLOG_ADDRESS_MLOG_LAST >> 8))
        {
            pageNo = 0;     // back to top
        }
    }
    _MLOG_tailAddress = ((uint32_t)pageNo << 8) + offset;

    return (mlogID);
}

uint32_t MLOG_countUploadableLog(void)
{
    uint32_t headAddress = _MLOG_headAddress;
    if (headAddress == _MLOG_tailAddress)
    {
        return (0);     // empty
    }
    else if (headAddress < _MLOG_tailAddress)
    {
        headAddress += MLOG_ADDRESS_MLOG_LAST + 1;
    }

    uint16_t headPageNo = headAddress >> 8;
    uint16_t tailPageNo = _MLOG_tailAddress >> 8;
    uint8_t headFraction = (headAddress & 0xff) / MLOG_RECORD_SIZE;
    uint8_t tailFraction = (_MLOG_tailAddress & 0xff) / MLOG_RECORD_SIZE;
    uint32_t count = ((headPageNo - tailPageNo) * MLOG_LOGS_PER_PAGE) + (headFraction - tailFraction);

    return (count);
}

int MLOG_findLog(uint32_t sn, MLOG_T *log_p)
{
    static uint32_t lastSequentialNumber = MLOG_MAX_SEQUENTIAL_NUMBER;
    static uint32_t lastAddress = 0;
    MLOG_T mlog;

    if (sn == 0)
    {
        DEBUG_UART_printlnFormat("MLOG_findLog(): oldestSN");
        lastAddress = _MLOG_oldestAddress;
        if (W25Q128JV_readData(lastAddress, (uint8_t *)&mlog, (uint16_t)sizeof(mlog)) != W25Q128JV_ERR_NONE)
        {
            return (MLOG_ERR_READ);
        }
        *log_p = mlog;
    }
    else if (sn == lastSequentialNumber + 1)
    {
        DEBUG_UART_printlnFormat("MLOG_findLog(): lastSN+1=%ld", sn); APP_delay(20);
        uint16_t pageNo = lastAddress >> 8;
        uint8_t offset = lastAddress & 0xff;
        if (offset < MLOG_RECORD_SIZE * (MLOG_LOGS_PER_PAGE - 1))
        {
            offset += MLOG_RECORD_SIZE;
        }
        else
        {
            offset = 0;
            if (++pageNo > (MLOG_ADDRESS_MLOG_LAST >> 8))
            {
                pageNo = 0;     // back to top
            }
        }
        lastAddress = ((uint32_t)pageNo << 8) + offset;
        DEBUG_UART_printlnFormat("lastAddress=%06lXh", lastAddress); APP_delay(20);

        if (W25Q128JV_readData(lastAddress, (uint8_t *)&mlog, (uint16_t)sizeof(mlog)) != W25Q128JV_ERR_NONE)
        {
            return (MLOG_ERR_READ);
        }
        if (IS_NOT_USED_SN(mlog.sequentialNumber))
        {
            DEBUG_UART_printlnString("NO MORE LOGS"); APP_delay(10);
            return (MLOG_ERR_NOT_EXIST);     // Not found
        }
        *log_p = mlog;
    }
    else if (sn >= MLOG_MAX_SEQUENTIAL_NUMBER)
    {
        DEBUG_UART_printFormat("MLOG_findLog(): SN=%ld - ", sn); APP_delay(10);
        return (MLOG_ERR_NOT_EXIST);
    }
    else
    {
        DEBUG_UART_printFormat("MLOG_findLog(): unknown SN=%ld - ", sn); APP_delay(30);
        lastAddress = findLogBySN(sn);
        if (lastAddress == BAD_MLOG_ADDRESS)
        {
            DEBUG_UART_printlnString("NOT FOUND"); APP_delay(10);
            return (MLOG_ERR_NOT_EXIST);     // Not found
        }
        if (W25Q128JV_readData(lastAddress, (uint8_t *)&mlog, (uint16_t)sizeof(mlog)) != W25Q128JV_ERR_NONE)
        {
            return (MLOG_ERR_READ);
        }
        *log_p = mlog;
        DEBUG_UART_printlnFormat("FOUND: %06lXh", lastAddress); APP_delay(10);
    }

    lastSequentialNumber = mlog.sequentialNumber;   // cache last sequential number for fast find

    return (MLOG_ERR_NONE);
}

int MLOG_format(void)
{
    DEBUG_UART_printlnFormat(">MLOG_format(): %lu", SYS_tick);

    // erase mlog data region in chip
    for (uint8_t blockNo = (MLOG_ADDRESS_MLOG_TOP >> 16); blockNo <= (MLOG_ADDRESS_MLOG_LAST >> 16) ; blockNo++) {
        DEBUG_UART_printlnFormat("eraseBlock64(%02Xh): %lu", (unsigned int)blockNo, SYS_tick);
        if (W25Q128JV_eraseBlock64(blockNo, true) != W25Q128JV_ERR_NONE)
        {
            return (MLOG_ERR_ERASE);
        }
    }

    DEBUG_UART_printlnFormat("<MLOG_format() OK: %lu", SYS_tick);
    return (MLOG_ERR_NONE);
}

int MLOG_checkLogs(bool oldestOnly)
{
    DEBUG_UART_printlnFormat(">MLOG_checkLogs(): %lu", SYS_tick);

    uint32_t latestSN = 0, oldestSN = MLOG_MAX_SEQUENTIAL_NUMBER, latestSN2 = 0;
    uint32_t latestAddr = 0, oldestAddr = 0, latestAddr2 = 0;

    for (uint32_t blockNo = 0; blockNo < (MLOG_ADDRESS_MLOG_LAST >> 16) + 1; blockNo++)
    {
        for (uint32_t sectorNo = 0; sectorNo < W25Q128JV_NUM_SECTOR; sectorNo++)
        {
            for (uint32_t pageNo = 0; pageNo < W25Q128JV_NUM_PAGE; pageNo++)
            {
                uint32_t addr = (blockNo << 16) + (sectorNo << 12) + (pageNo << 8);

                // find head (find the most recent page)
                uint32_t sn;
                uint8_t buf[4];
                if (W25Q128JV_readData(addr, buf, (uint16_t)sizeof(buf)) != W25Q128JV_ERR_NONE)
                {
                    return (MLOG_ERR_READ);
                }
                memcpy((void *)&sn, (void *)buf, sizeof(sn));
                if (IS_NOT_USED_SN(sn))
                {
                    continue;       // skip unused page
                }
                if (sn < oldestSN)
                {
                    oldestSN = sn;
                    oldestAddr = addr;
                }
                else if (latestSN < sn)
                {
                    latestSN = sn;
                    latestAddr = addr;
                }
                // find tail (find the most recent not-uploaded page)
                uint8_t flag;   // 0xff: not used or not uploaded/0x00: uploaded this page
                if (W25Q128JV_readData(addr + (W25Q128JV_PAGE_SIZE-1), &flag, 1) != W25Q128JV_ERR_NONE)
                {
                    return (MLOG_ERR_READ);
                }
				if (flag == 0) {	// 起動時高速化
					continue;       // skip uploaded page
				}
                DEBUG_UART_printlnFormat("READ FLAG %06lX: %02Xh", addr + (W25Q128JV_PAGE_SIZE-1), flag);
//                APP_delay(20);
                APP_delay(2);	// 起動時高速化
                if (flag == 0x00)
                {
                    // when this page was uploaded
                    if (latestSN2 < sn)
                    {
                        latestSN2 = sn + MLOG_LOGS_PER_PAGE;
                        latestAddr2 = addr;
                    }
                }
            }
        }
        //DEBUG_UART_printFormat("blockNo=%02x ", (unsigned int)blockNo);
    }
    if (oldestSN == MLOG_MAX_SEQUENTIAL_NUMBER)
    {
        oldestSN = 0;
        oldestAddr = 0;
    }
    if (latestSN == 0)
    {
        latestSN = 0;
        latestAddr = 0;
    }

    DEBUG_UART_printlnString("\n-- 1st --");
    DEBUG_UART_printlnFormat("oldestSN=%08lu,oldestAddr=%06Xh", oldestSN, (unsigned int)oldestAddr);
    DEBUG_UART_printlnFormat("latestSN=%08lu,latestAddr=%06Xh", latestSN, (unsigned int)latestAddr);
    DEBUG_UART_printlnFormat("latestSN2=%08lu,latestAddr2=%06Xh", latestSN2, (unsigned int)latestAddr2);
    APP_delay(30);

    // latest
    uint8_t buf[W25Q128JV_PAGE_SIZE];
    if (W25Q128JV_readData(latestAddr, buf, (uint16_t)W25Q128JV_PAGE_SIZE) == W25Q128JV_ERR_NONE)
    {
        bool found = false;
        MLOG_T *p = (MLOG_T *)buf;
        for (uint32_t addr = latestAddr; addr < latestAddr + (MLOG_RECORD_SIZE * MLOG_LOGS_PER_PAGE); addr += MLOG_RECORD_SIZE, p++)
        {
            if (IS_NOT_USED_SN(p->sequentialNumber))
            {
                DEBUG_UART_printlnFormat(">>> addr=%06lXh", addr);
                if (latestAddr < MLOG_ADDRESS_MLOG_TOP + MLOG_RECORD_SIZE)
                {
                    latestAddr = 0;
                    //latestSN = ((MLOG_T *)buf)->sequentialNumber;
                    latestSN = 0;
                }
                else
                {
                    latestAddr = addr - MLOG_RECORD_SIZE;
                }
                found = true;
                break;
            }
            latestSN = p->sequentialNumber;
        }
        if (! found)
        {
            latestAddr += MLOG_RECORD_SIZE * (MLOG_LOGS_PER_PAGE - 1);
            //latestSN = (p + (MLOG_LOGS_PER_PAGE - 1))->sequentialNumber;
        }
    }
    else
    {
        return (MLOG_ERR_READ);
    }

    DEBUG_UART_printlnString("\n-- 2nd --");
    DEBUG_UART_printlnFormat("oldestSN=%08lu,oldestAddr=%06Xh", oldestSN, (unsigned int)oldestAddr);
    DEBUG_UART_printlnFormat("latestSN=%08lu,latestAddr=%06Xh", latestSN, (unsigned int)latestAddr);
    DEBUG_UART_printlnFormat("latestSN2=%08lu,latestAddr2=%06Xh", latestSN2, (unsigned int)latestAddr2);
    APP_delay(30);

    _MLOG_lastSequentialNumber = latestSN;
    _MLOG_oldestSequentialNumber = oldestSN;
    DEBUG_UART_printlnFormat("_MLOG_lastSequentialNumber=%lu", _MLOG_lastSequentialNumber);
    DEBUG_UART_printlnFormat("_MLOG_oldestSequentialNumber=%lu", _MLOG_oldestSequentialNumber);
    APP_delay(20);

    // set oldest page
    _MLOG_oldestAddress = oldestAddr;
    _MLOG_latestAddress = latestAddr;

    if (! oldestOnly)
    {
        // set tail pointer
        if (latestAddr2 == 0 && latestAddr < MLOG_ADDRESS_MLOG_TOP + MLOG_RECORD_SIZE)
        {
            _MLOG_tailAddress = 0;
        }
        else if (latestAddr2 == latestAddr)
        {
            _MLOG_tailAddress = latestAddr2;
        }
        else
        {
            latestAddr2 += W25Q128JV_PAGE_SIZE;
            if (latestAddr2 >= (MLOG_ADDRESS_MLOG_LAST & 0xffff00))
            {
                latestAddr2 = 0;
            }
            _MLOG_tailAddress = latestAddr2;
        }
        DEBUG_UART_printlnFormat("_MLOG_tailAddress=%06Xh", (unsigned int)_MLOG_tailAddress);
        APP_delay(20);

        // set head pointer for next use
        uint16_t pageNo = latestAddr >> 8;
        uint8_t offset = latestAddr & 0xff;
        if (latestAddr > 0)
        {
            if (offset < MLOG_RECORD_SIZE * (MLOG_LOGS_PER_PAGE - 1))
            {
                offset += MLOG_RECORD_SIZE;
            }
            else
            {
                offset = 0;
                if (++pageNo > (MLOG_ADDRESS_MLOG_LAST >> 8))
                {
                    pageNo = 0;     // back to top
                }
            }
        }
        _MLOG_headAddress = ((uint32_t)pageNo << 8) + offset;
        DEBUG_UART_printlnFormat("_MLOG_headAddress=%06Xh", (unsigned int)_MLOG_headAddress);
    }

    DEBUG_UART_printlnFormat("<MLOG_checkLogs() OK: %lu", SYS_tick);
    return (MLOG_ERR_NONE);
}

int MLOG_switchToSRAM(void)
{
    DEBUG_UART_printlnFormat(">MLOG_switchToSRAM(): %lu", SYS_tick); APP_delay(10);

    _MLOG_switchToSRAM = true;

    return (MLOG_ERR_NONE);
}

int MLOG_returnToFlash(void)
{
    DEBUG_UART_printlnFormat(">MLOG_returnToFlash(): %lu", SYS_tick); APP_delay(10);

    _MLOG_switchToSRAM = false;

    // log data on SRAM write to Flash
    int stat, errorCount = 0;
    MLOG_T mlog;
    while ((stat = _MLOG_getLogOnSRAM(&mlog)) > 0)
    {
        if ((stat = MLOG_putLog(&mlog, true)) < 0)
        {
            DEBUG_UART_printlnFormat("MLOG_putLog() error: %d", stat); APP_delay(10);
            errorCount++;
        }
    }


    if (stat != MLOG_ERR_EMPTY)
    {
        DEBUG_UART_printlnFormat("MLOG_getLogOnSRAM() error: %d", stat);
        DEBUG_UART_printlnFormat("<MLOG_returnToFlash() error"); APP_delay(10);
        return (MLOG_ERR_NONE);
    }
    if (errorCount > 0)
    {
        DEBUG_UART_printlnFormat("<MLOG_returnToFlash() error"); APP_delay(10);
        return (MLOG_ERR_NONE);
    }

    DEBUG_UART_printlnFormat("<MLOG_returnToFlash() OK: %lu", SYS_tick); APP_delay(10);
    return (MLOG_ERR_NONE);
}

bool MLOG_IsSwitchedSRAM(void)
{
    return (_MLOG_switchToSRAM);
}

int MLOG_putLogOnSRAM(MLOG_T *log_p)
{
    DEBUG_UART_printlnFormat("_MLOG_headAddressOnSRAM=%06lx", _MLOG_headAddressOnSRAM);

    _MLOG_lastSequentialNumber++;       // Increment sequential number
    if (_MLOG_lastSequentialNumber == 0)
    {
        // Overflow sequential number
        DEBUG_UART_printlnString("MLOG_putLogOnSRAM(): Overflow sequential number");
    }
    log_p->sequentialNumber = _MLOG_lastSequentialNumber;

    *((MLOG_T *)_MLOG_headAddressOnSRAM) = *log_p;
    MLOG_ID_T mlogID = _MLOG_headAddressOnSRAM;
    dumpLog(">", mlogID, log_p);

    // update _MLOG_headAddressOnSRAM for next use
    if ((uint8_t *)_MLOG_headAddressOnSRAM < _MLOG_storages + (MLOG_SRAM_SIZE - 1))
    {
        _MLOG_headAddressOnSRAM += MLOG_RECORD_SIZE;
    }
    else
    {
        _MLOG_headAddress = (uint32_t)_MLOG_storages;
    }
    DEBUG_UART_printlnFormat("_MLOG_headAddressOnSRAM=%06lx", _MLOG_headAddressOnSRAM);

    return ((int)mlogID);       // return mlog ID when succeed
}

void MLOG_dump(void)
{
    DEBUG_UART_printlnString("--->");

    for (uint32_t blockNo = 0; blockNo < ((MLOG_ADDRESS_MLOG_LAST + 1) >> 16) + 1; blockNo++)
    {
        for (uint32_t sectorNo = 0; sectorNo < ((MLOG_ADDRESS_MLOG_LAST + 1) >> 12); sectorNo++)
        {
            for (uint32_t pageNo = 0; pageNo < W25Q128JV_NUM_PAGE; pageNo++)
            {
                uint32_t addr = (blockNo << 16) + (sectorNo << 12) + (pageNo << 8);
                if (W25Q128JV_readData(addr, _MLOG_pageBuffer, (uint16_t)sizeof(_MLOG_pageBuffer)) != W25Q128JV_ERR_NONE)
                {
                    DEBUG_UART_printlnFormat("Page read failed: %04lX", pageNo);
                    continue;
                }
                for (int n = 0; n < MLOG_LOGS_PER_PAGE; n++)
                {
                    MLOG_ID_T mlogId = (uint32_t)addr + (MLOG_RECORD_SIZE * n);
                    MLOG_T *mlp = (MLOG_T *)_MLOG_pageBuffer + n;
                    if (IS_NOT_USED_SN(mlp->sequentialNumber))
                    {
                        // Unused entry
                        DEBUG_UART_printlnFormat("%06lX: -", mlogId);
                        DEBUG_UART_FLUSH(); APP_delay(1);
                    }
                    else
                    {
                        // Used entry
                        dumpLog("", mlogId, mlp);
                    }
                }
                // output page mark
                DEBUG_UART_printlnFormat("%04lX: PAGE MARK %02Xh", (blockNo << 4) + pageNo, _MLOG_pageBuffer[W25Q128JV_PAGE_SIZE - 1]);
            }
        }
    }

    DEBUG_UART_printlnString("<---");
}

int MLOG_getStatus(MLOG_STATUS_T *stat_p)
{
    MLOG_checkLogs(true);   // just get oldest/latest info only

    stat_p->oldestSequentialNumber = _MLOG_oldestSequentialNumber;
    stat_p->latestSequentialNumber = _MLOG_lastSequentialNumber;
    stat_p->oldestAddress = _MLOG_oldestAddress;
    stat_p->latestAddress = _MLOG_latestAddress;

    MLOG_T mlog;
    if (W25Q128JV_readData(_MLOG_oldestAddress, (uint8_t *)&mlog, (uint16_t)sizeof(mlog)) != W25Q128JV_ERR_NONE)
    {
        return (MLOG_ERR_READ);
    }
    stat_p->oldestDatetime = mlog.timestamp.second;
    if (W25Q128JV_readData(_MLOG_latestAddress, (uint8_t *)&mlog, (uint16_t)sizeof(mlog)) != W25Q128JV_ERR_NONE)
    {
        return (MLOG_ERR_READ);
    }
    stat_p->latestDatetime = mlog.timestamp.second;

    return (MLOG_ERR_NONE);
}

/*
*   Local functions
*/
static void dumpLog(char const *prefix, MLOG_ID_T mlogId, MLOG_T *log_p)
{
#ifdef DEBUG_UART
    char line[80];
    snprintf(line, sizeof(line),
            "%s%06X: %08u,%06u.%03u,%.3f/%.3f,%u/%u,%d,%02Xh,%02Xh",
            prefix,
            (unsigned int)mlogId,
            (unsigned int)log_p->sequentialNumber,
            (unsigned int)log_p->timestamp.second, (unsigned int)log_p->timestamp.mSecond,
            log_p->measuredValues[0], log_p->measuredValues[1],
            (unsigned int)log_p->batteryVoltages[0], (unsigned int)log_p->batteryVoltages[1],
            (int)log_p->temperatureOnBoard,
            (unsigned int)log_p->alertStatus,
            (unsigned int)log_p->batteryStatus
    );
    DEBUG_UART_printlnString(line);
    APP_delay(10);
#endif // DEBUG_UART
}

static uint32_t findLogBySN(uint32_t sn)
{
    DEBUG_UART_printlnFormat("> findLogBySN(%ld)", sn); APP_delay(10);

    if (sn >= MLOG_MAX_SEQUENTIAL_NUMBER)
    {
        return (BAD_MLOG_ADDRESS);     // Not found
    }

    for (uint32_t blockNo = 0; blockNo < ((MLOG_ADDRESS_MLOG_LAST + 1) >> 16) + 1; blockNo++)
    {
        for (uint32_t sectorNo = 0; sectorNo < ((MLOG_ADDRESS_MLOG_LAST + 1) >> 12); sectorNo++)
        {
            for (uint32_t pageNo = 0; pageNo < W25Q128JV_NUM_PAGE; pageNo++)
            {
                uint32_t pageTop = (blockNo << 16) + (sectorNo << 12) + (pageNo << 8);
                if (W25Q128JV_readData(pageTop, _MLOG_pageBuffer, (uint16_t)sizeof(_MLOG_pageBuffer)) != W25Q128JV_ERR_NONE)
                {
                    DEBUG_UART_printlnFormat("Page read failed: %04lX", pageNo);
                    continue;
                }
                for (int n = 0; n < MLOG_LOGS_PER_PAGE; n++)
                {
                    uint32_t address = (uint32_t)pageTop + (MLOG_RECORD_SIZE * n);
                    MLOG_T *mlp = (MLOG_T *)_MLOG_pageBuffer + n;
                    if (mlp->sequentialNumber == sn)
                    {
                        DEBUG_UART_printlnFormat("> findLogBySN(%ld) OK: %06lXh", sn, address); APP_delay(10);
                        return (address);
                    }
                }
            }
        }
    }

    DEBUG_UART_printlnFormat("> findLogBySN(%ld) NOT FOUND", sn); APP_delay(10);
    return (BAD_MLOG_ADDRESS);     // Not found
}

static int _MLOG_getLogOnSRAM(MLOG_T *log_p)
{
    if (_MLOG_headAddressOnSRAM == _MLOG_tailAddressOnSRAM)
    {
        return (MLOG_ERR_EMPTY);
    }

    MLOG_ID_T mlogID = _MLOG_tailAddressOnSRAM;
    *log_p = *((MLOG_T *)_MLOG_tailAddressOnSRAM);
    //dumpLog("<", mlogID, log_p);

    // update _MLOG_tailAddressOnSRAM for next use
    if ((uint8_t *)_MLOG_tailAddressOnSRAM < _MLOG_storages + (MLOG_SRAM_SIZE - 1))
    {
        _MLOG_tailAddressOnSRAM += MLOG_RECORD_SIZE;
    }
    else
    {
        _MLOG_tailAddressOnSRAM = (uint32_t)_MLOG_storages;
    }

    return (mlogID);
}

// 測定logリングバッファ試験用
int MLOG_putLogtest(MLOG_T *log_p, bool specifySN)
{
    bool Flg=false;
    DEBUG_UART_printlnFormat("_MLOG_headAddress=%06x,%d", (unsigned int)_MLOG_headAddress, specifySN); APP_delay(2);
    if ((_MLOG_headAddress & 0xfff) == 0)
    {
        // if page number and offset are zero - first log in current sector
        DEBUG_UART_printlnFormat("head=%06Xh", (unsigned int)_MLOG_headAddress);
        uint16_t sectorNo = (_MLOG_headAddress >> 12) & 0x0fff;
        DEBUG_UART_printlnFormat("eraseSector(%04Xh)", (unsigned int)sectorNo);
        if (W25Q128JV_eraseSctor(sectorNo, true) != W25Q128JV_ERR_NONE)
        {
            return (MLOG_ERR_ERASE);
        }
        DEBUG_UART_printlnFormat("eraseSector(%04Xh): done", (unsigned int)sectorNo);
    }
    uint16_t pageNo = _MLOG_headAddress >> 8;
    uint8_t offset = _MLOG_headAddress & 0xff;
    if (! specifySN)
    {
        _MLOG_lastSequentialNumber++;       // Increment sequential number
        if (_MLOG_lastSequentialNumber == 0)
        {
            // Overflow sequential number
            DEBUG_UART_printlnString("MLOG_putLog(): Overflow sequential number");
        }
        log_p->sequentialNumber = _MLOG_lastSequentialNumber;
    }
    DEBUG_UART_printlnFormat("programPage(%04Xh,%02Xh):", (unsigned int)pageNo, (unsigned int)offset);
    if (W25Q128JV_programPage(pageNo, offset, (uint8_t *)log_p, MLOG_RECORD_SIZE, true) != W25Q128JV_ERR_NONE)
    {
        return (MLOG_ERR_PROGRAM_PAGE);
    }
    MLOG_ID_T mlogID = (pageNo << 8) + offset;
    dumpLog(">", mlogID, log_p);

    // update _MLOG_headAddress for next use
    if (offset < MLOG_RECORD_SIZE * (MLOG_LOGS_PER_PAGE - 1))
    {
        offset += MLOG_RECORD_SIZE;
    }
    else
    {
        offset = 0;
        if (++pageNo > ((MLOG_ADDRESS_MLOG_LAST - 0x100) >> 8))
//        if (++pageNo > ((0x93b00 - 0x100) >> 8))	// 測定：4秒、通知：1日の場合の未通知log最大
        {
			Flg = true;
        }
    }
    _MLOG_headAddress = ((uint32_t)pageNo << 8) + offset;
    //DEBUG_UART_printlnFormat("_MLOG_headAddress=%06x", (unsigned int)_MLOG_headAddress);

    if (Flg == true) {
		return 0;
	} else {
		return 1;
	}
}
int mlogdumywrite(uint32_t logtime)
{
    MLOG_T mlog;
    mlog.timestamp.second = logtime;
    mlog.timestamp.mSecond = 0;
    mlog.measuredValues[0] = WPFM_lastMeasuredValues[0];
    mlog.measuredValues[1] = WPFM_lastMeasuredValues[1];
    mlog.batteryVoltages[0] = WPFM_lastBatteryVoltages[0];
    mlog.batteryVoltages[1] = WPFM_lastBatteryVoltages[1];
    mlog.temperatureOnBoard = WPFM_lastTemperatureOnBoard;
    mlog.alertStatus = WPFM_lastAlertStatusSuppressed;
    mlog.batteryStatus = WPFM_batteryStatus;

    int stat;
    // Store log into Flash
    stat = MLOG_putLogtest(&mlog, false);

	return stat;
}
