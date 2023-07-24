/*
	EventLog関数
*/

#define EVENTLOG_SPI

#include <stdio.h>
#include <stddef.h>                     // Defines NULL
#include <stdbool.h>                    // Defines true
#include <stdlib.h>                     // Defines EXIT_FAILURE
#include <ctype.h>
#include <string.h>                     // Defines EXIT_FAILURE
#include "definitions.h"                // SYS function prototypes
#include "moni.h" 
#include "gpioexp.h" 
#include "rtc.h" 
#include "w25q128jv.h"
#include "mlog.h"
#include "util.h"
#include "wpfm.h"
#include "DLCpara.h"
#include "Eventlog.h"
_EventLog	DLC_EventLog;
int			DLC_EventIdx;
uchar		DLC_EventFull;
void DLC_delay( int msec );
/*****
* TITLE		：DLC イベントログの再構築
* RETURN	：
* 機能 		：DLC_EventIdxで空いてるまで探す、空きなければ時刻の逆順のセクタを消して、そこ
*****/
void DLCEventLogInit()
{
	int				i,sec;
#ifdef EVENTLOG_SPI
	_EventLog	log;
	uint32_t	readAddress;
	W25Q128JV_readData(EVENT_LOG_AREA_ADDRESS_END - EVENT_LOG_AREA_WRITE_SZ, (uint8_t *)&log, EVENT_LOG_AREA_WRITE_SZ);
	if( log.second & 0x80000000 )															/* 最終レコードが書き込み済みなら１周済 */
		;
	else
		DLC_EventFull = 1;
	readAddress = EVENT_LOG_AREA_ADDRESS_START;
	W25Q128JV_readData(readAddress, (uint8_t *)&log, EVENT_LOG_AREA_WRITE_SZ);
	DLC_EventIdx = 0;
	for( i = 0; i < EVENT_LOG_NUMOF_ITEM; i++ ){
		WDT_Clear();
		if( readAddress > EVENT_LOG_AREA_ADDRESS_END )
			break;
		if( readAddress < EVENT_LOG_AREA_ADDRESS_START )
			break;
		if( log.second & 0x80000000 )
			goto FinFin;
		DLC_EventIdx++;
		sec = log.second;
		readAddress += EVENT_LOG_AREA_WRITE_SZ;
		W25Q128JV_readData(readAddress, (uint8_t *)&log, EVENT_LOG_AREA_WRITE_SZ);
	}
	DLC_EventIdx = 0;
	readAddress = EVENT_LOG_AREA_ADDRESS_START;
	W25Q128JV_readData(readAddress, (uint8_t *)&log, EVENT_LOG_AREA_WRITE_SZ);
	for( i = 0; i < EVENT_LOG_NUMOF_ITEM; i++ ){
//		puthxw( log.second );putcrlf();
		WDT_Clear();
		if( log.second < 100 ){
			readAddress += EVENT_LOG_AREA_WRITE_SZ;
			W25Q128JV_readData(readAddress, (uint8_t *)&log, EVENT_LOG_AREA_WRITE_SZ);
			continue;
		}
		if( sec > log.second ){
			W25Q128JV_eraseSctor(readAddress/EVENT_LOG_AREA_ERASE_SZ, true);
			puthxw( readAddress );putst("deleted!\r\n");
			goto FinFin;
		}
		DLC_EventIdx++;
		sec = log.second;
		readAddress += EVENT_LOG_AREA_WRITE_SZ;
		W25Q128JV_readData(readAddress, (uint8_t *)&log, EVENT_LOG_AREA_WRITE_SZ);
	}
#else
	int				block;
	_EventLog		*log;
	log = (_EventLog*)EVENT_LOG_AREA_ADDRESS_END;
	log--;
	if( log->second & 0x80000000 )															/* 最終レコードが書き込み済みなら１周済 */
		;
	else
		DLC_EventFull = 1;
	log = (_EventLog*)EVENT_LOG_AREA_ADDRESS_START;
	DLC_EventIdx = 0;
	for( i = 0; i < EVENT_LOG_NUMOF_ITEM; i++,++log ){
		if( (uint)log > EVENT_LOG_AREA_ADDRESS_END )
			break;
		if( (uint)log < EVENT_LOG_AREA_ADDRESS_START )
			break;
		if( log->second & 0x80000000 )
			goto FinFin;
		DLC_EventIdx++;
		sec = log->second;
	}
	DLC_EventIdx = 0;
	log = (_EventLog*)EVENT_LOG_AREA_ADDRESS_START;
	for( i = 0; i < EVENT_LOG_NUMOF_ITEM; i++ ,++log){
//		puthxw( log->second );putcrlf();
		if( log->second < 100 )
			continue;
		if( sec > log->second ){
			block = (uint)log & EVENT_LOG_AREA_BLOCK_MSK;
			NVMCTRL_RowErase( block );
			//puthxw( block );putst("deleted!\r\n");
			goto FinFin;
		}
		DLC_EventIdx++;
		sec = log->second;
	}
#endif
FinFin:
	putst("EventLog:" );putdecw( i );putst(" Recodes!\r\n");
}
/*****
* TITLE		：DLC イベントログの保存
* RETURN	：
* 機能 		：最初だけ、DLC_EventIdxで空いてるまで探す、２回目からは、DLC_EventIdxで直書く
*****/
#ifndef EVENTLOG_SPI
void DLCLogWrite(int address,uchar *data )
{
	uchar	tmp[64];
	int		block;
	uchar	offset;
	block = address & EVENT_LOG_AREA_BLOCK_MSK;
	offset = (uchar)(address % EVENT_LOG_AREA_WRITE_SZ);
	memcpy( tmp,(uchar*)block,sizeof( tmp ));
	memcpy( &tmp[offset],data,sizeof( DLC_EventLog ));
	NVMCTRL_PageWrite( (uint32_t*)tmp,(const uint32_t)block );
//	puthxw( block );puthxb( offset );putst("  wrote!\r\n");
}
#endif
void DLCEventLogWrite( ushort ID1,uint ID2,uint ID3 )
{
#ifdef EVENTLOG_SPI
	_EventLog	log;
	uint32_t	writeAddress;
	uint16_t	pageNo;
	uint8_t		offset;
#else
	_EventLog	*log;
#endif
	uchar		flg=0;
	DLC_EventLog.second = RTC_now;															/* 現時刻 Get!秒 */
	DLC_EventLog.mSecond = SYS_mSec;														/* 現時刻 Get!m秒 */
	DLC_EventLog.ID1 = ID1;
	DLC_EventLog.ID2 = ID2;
	DLC_EventLog.ID3 = ID3;
Retry:
#ifdef EVENTLOG_SPI
	writeAddress = EVENT_LOG_AREA_ADDRESS_START + (DLC_EventIdx * EVENT_LOG_AREA_WRITE_SZ);
	W25Q128JV_readData(writeAddress, (uint8_t *)&log, EVENT_LOG_AREA_WRITE_SZ);
	if( log.second & 0x80000000 ){															/* 空きレコードでない */
		pageNo = writeAddress >> 8;
		offset = writeAddress & 0xff;
		W25Q128JV_programPage(pageNo, offset, (uint8_t*)&DLC_EventLog, EVENT_LOG_AREA_WRITE_SZ, true);
		DLC_EventIdx++;
		if( DLC_EventIdx == EVENT_LOG_NUMOF_ITEM ){
			DLC_EventIdx = 0;
			DLC_EventFull = 1;
			W25Q128JV_eraseSctor(EVENT_LOG_AREA_ADDRESS_START/EVENT_LOG_AREA_ERASE_SZ, true);
		}
	}
#else
	log = (_EventLog*)EVENT_LOG_AREA_ADDRESS_START;
	log += DLC_EventIdx;																	/* 開始アドレス */
	if( log->second & 0x80000000 ){															/* 空きレコードでない */
		DLCLogWrite( (int)log,(uchar*)&DLC_EventLog );
		DLC_EventIdx++;
		if( DLC_EventIdx == EVENT_LOG_NUMOF_ITEM ){
			DLC_EventIdx = 0;
			DLC_EventFull = 1;
			NVMCTRL_RowErase( EVENT_LOG_AREA_ADDRESS_START );
		}
	}
#endif
	else {
		DLCEventLogInit();
		++flg;
		if( flg > 2 ){
			putst("●Err●");
			return;
		}
		goto Retry;
	}
}
void NcuEventLogPrint( _EventLog *log,int forword )
{
	char	str[64],tmp[10];
//	puthxw( log->.second );puthxs( log->mSecond );putch(':');
	RTC_DATETIME dt;
	RTC_convertToDateTime(log->second,&dt);
	sprintf( str,"%02d-%02d-%02d %02d:%02d:%02d ",(int)dt.year,(int)dt.month,(int)dt.day,(int)dt.hour,(int)dt.minute,(int)dt.second );
	switch( log->ID1 ){
	case _ID1_POWER_START:
		strcat( str,"PWR    ");
		break;
	case _ID1_SYS_START:
		strcat( str,"SYSTEM ");
		break;
	case _ID1_SYS_ERROR:
		strcat( str,"S ERR  ");
		break;
	case _ID1_MAT_VERSION:
		strcat( str,"MATVer ");
		break;
	case _ID1_PUSH_SW:
		strcat( str,"PUSH   ");
		break;
	case _ID1_OPEN_OK:
		strcat( str,"OPEN   ");
		break;
	case _ID1_FACTORY_TEST:
		strcat( str,"FACTOY ");
		break;
	case _ID1_FLASH_ERROR_W:
		strcat( str,"Flash  ");
		break;
	case _ID1_SYS_SUSPEND:
		strcat( str,"SUSPND ");
		break;
	case _ID1_SYS_RESUME:
		strcat( str,"RESUM  ");
		break;
	case _ID1_USIM_STS:
		strcat( str,"USIM S ");
		break;
	case _ID1_USIM_CNUM:
		strcat( str,"CNUM   ");
		break;
	case _ID1_USB_CMD_OKNG:
		strcat( str,"COMND  ");
		break;
	case _ID1_FOTA_START:
		strcat( str,"FOTA S ");
		break;
	case _ID1_FOTA_END:
		strcat( str,"FOTA F ");
		break;
	case _ID1_FOTA_FAIL:
		strcat( str,"FOTAng ");
		break;
	case _ID1_ONLINE_UPD_B_START:
		strcat( str,"Boot更新開始 ");
		break;
	case _ID1_ONLINE_UPD_B_END:
		strcat( str,"Boot更新終了 ");
		break;
	case _ID1_ALERT1:
		strcat( str,"ALERT1 ");
		break;
	case _ID1_ALERT2:
		strcat( str,"ALERT2 ");
		break;
	case _ID1_CONNECT:
		strcat( str,"CNNECT ");
		break;
	case _ID1_CONN_NG:
		strcat( str,"CNN NG ");
		break;
	case _ID1_REPORTRET:
		strcat( str,"RPTRET ");
		break;
	case _ID1_REPORT:
		strcat( str,"REPORT ");
		break;
	case _ID1_HTTP_OK:
		strcat( str,"HTTPok ");
		break;
	case _ID1_HTTP_RES:
		strcat( str,"HTTP=  ");
		break;
	case _ID1_SLEEP:
		strcat( str,"SLEEP  ");
		break;
	case _ID1_WAKE:
		strcat( str,"WAKE   ");
		break;
	case _ID1_WATCHDOG_START:
		strcat( str,"WDT    ");
		break;
	case _ID1_POWER_OFF:
		strcat( str,"OFF    ");
		break;
	case _ID1_ERROR:
		strcat( str,"ERR    ");
		break;
	case _ID1_SEREAL_NOISE:
		strcat( str,"NOISE  ");
		break;
	case _ID1_MANTE_START:
		strcat( str,"USB    ");
		break;
	case _ID1_CELLACT:
		strcat( str,"CELL   ");
		break;
	case _ID1_BATTRY:
		strcat( str,"BATT   ");
		break;
	case _ID1_INIT_ALL:
		strcat( str,"ROM CLR");
		break;
	case _ID1_VBAT_DRIVE:
		strcat( str,"VBAT   ");
		break;
	case _ID1_ALERT_STATE:
		strcat( str,"ALERT  ");
		break;
	case _ID1_MAT_ERR:
		strcat( str,"MatErr ");
		break;
	case _ID1_MAT_TO:
		strcat( str,"MatTO  ");
		break;
	case _ID1_MAT_RESET:
		strcat( str,"MatRST ");
		break;
	case _ID1_TIME:
		strcat( str,"TIME   ");
		break;
	case 0:
		strcat( str,"       ");
		break;
	default:
		sprintf( tmp,"%08X ",log->ID1 );
		break;
	}
	if( log->ID2 | log->ID3 ){
		sprintf( tmp,"%08X ",log->ID2 );
		strcat( str, tmp );
		sprintf( tmp,"%08X ",log->ID3 );
		strcat( str, tmp );
	}
	strcat( str, "\r\n" );
	if( forword )
		APP_printUSB( str );
	else{
		putst( str );
	}
}
void DLCEventLogDisplay()
{
	int				i;
#ifdef EVENTLOG_SPI
	_EventLog	log;
	uint32_t	printAddress;
	printAddress = EVENT_LOG_AREA_ADDRESS_START;
	W25Q128JV_readData(printAddress, (uint8_t *)&log, EVENT_LOG_AREA_WRITE_SZ);
	putcrlf();
	for( i = 0; i < EVENT_LOG_NUMOF_ITEM; i++ ){
		if( printAddress > EVENT_LOG_AREA_ADDRESS_END )
			break;
		if( printAddress < EVENT_LOG_AREA_ADDRESS_START )
			break;
		if(( log.second & 0x80000000 )&&( DLC_EventFull == 0))
			break;
		/* イベントログ表示 */
		NcuEventLogPrint( &log,0 );
		printAddress += EVENT_LOG_AREA_WRITE_SZ;
		W25Q128JV_readData(printAddress, (uint8_t *)&log, EVENT_LOG_AREA_WRITE_SZ);
		DLC_delay(50);
	}
#else
	_EventLog		*log;
	log = (_EventLog*)EVENT_LOG_AREA_ADDRESS_START;
	putcrlf();
	for( i = 0; i < EVENT_LOG_NUMOF_ITEM; i++ ){
		if( (uint)log > EVENT_LOG_AREA_ADDRESS_END )
			break;
		if( (uint)log < EVENT_LOG_AREA_ADDRESS_START )
			break;
		if(( log->second & 0x80000000 )&&( DLC_EventFull == 0))
			break;
		/* イベントログ表示 */
		NcuEventLogPrint( log,0 );
		++log;
		DLC_delay(40);
	}
#endif
}
void DLCMatEventLog(const char *param, char *resp)
{
	int			i,from=0,to;
#ifdef EVENTLOG_SPI
	_EventLog	log;
	uint32_t	printAddress;
	printAddress = EVENT_LOG_AREA_ADDRESS_START;
	if( strchr( param,'-' ) ){
		sscanf( param,"%d-%d",&from,&to );
//		putst("from=");puthxw( from );
//		putst(" to=");puthxw( to );
	}
	else {
		if( param[0] )
			sscanf( param,"%d",&to );
		else {
			to = EVENT_LOG_NUMOF_ITEM;
//			putst(" to=");puthxw( to );
		}
	}
	W25Q128JV_readData(printAddress, (uint8_t *)&log, EVENT_LOG_AREA_WRITE_SZ);
	putcrlf();
	for( i = from; i < to; i++ ){
		if( printAddress > EVENT_LOG_AREA_ADDRESS_END )
			break;
		if( printAddress < EVENT_LOG_AREA_ADDRESS_START )
			break;
		if(( log.second & 0x80000000 )&&( DLC_EventFull == 0))
			break;
		/* イベントログ表示 */
		NcuEventLogPrint( &log,1 );
		printAddress += EVENT_LOG_AREA_WRITE_SZ;
		W25Q128JV_readData(printAddress, (uint8_t *)&log, EVENT_LOG_AREA_WRITE_SZ);
		DLC_delay(40);
	}
#else
	_EventLog		*log;
	log = (_EventLog*)EVENT_LOG_AREA_ADDRESS_START;
	putcrlf();
	for( i = from; i < to; i++ ){
		if( (uint)log > EVENT_LOG_AREA_ADDRESS_END )
			break;
		if( (uint)log < EVENT_LOG_AREA_ADDRESS_START )
			break;
		if(( log->second & 0x80000000 )&&( DLC_EventFull == 0))
			break;
		/* イベントログ表示 */
		NcuEventLogPrint( log,1 );
		++log;
		DLC_delay(40);
	}
#endif
	APP_printUSB( "--Finish--\r\n" );
}
/*****
* ﾀｲﾄﾙ		：Flashのログ領域を削除する。
* ﾘﾀｰﾝ		：
* ﾊﾟﾗﾒｰﾀ	：
* 機能 		：イベントログ領域の削除
* 更新記録	：14/04/22			新規
*/
void DLCEventLogClr(int flg)
{
#ifdef EVENTLOG_SPI
	int		address;
	if( flg ){
		W25Q128JV_eraseSctor(EVENT_LOG_AREA_ADDRESS_START/EVENT_LOG_AREA_ERASE_SZ, true);
		puthxw( EVENT_LOG_AREA_ADDRESS_START );putst("deleted!\r\n");
	}
	else {
		for(address=EVENT_LOG_AREA_ADDRESS_START;address<EVENT_LOG_AREA_ADDRESS_END;address+=EVENT_LOG_AREA_BLOCK_SZ){
			W25Q128JV_eraseBlock64(address/EVENT_LOG_AREA_BLOCK_SZ, true);
			WDT_Clear();
			puthxw( address );putst("deleted!\r\n");
		}
	}
#else
	if( flg ){
		NVMCTRL_RowErase( EVENT_LOG_AREA_ADDRESS_START );puthxw( EVENT_LOG_AREA_ADDRESS_START );putst("deleted!\r\n");
	}
	else {
		int		address;
		for(address=EVENT_LOG_AREA_ADDRESS_START;address<EVENT_LOG_AREA_ADDRESS_END;address+=EVENT_LOG_AREA_ERASE_SZ){
			NVMCTRL_RowErase( address );puthxw( address );putst("deleted!\r\n");
		}
	}
#endif
	DLC_EventIdx = 0;
	DLC_EventFull = 0;
}
