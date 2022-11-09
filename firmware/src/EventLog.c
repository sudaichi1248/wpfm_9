/*
	EventLog関数
*/
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
	int				i,sec,block;
	_EventLog		*log;
	log = (_EventLog*)EVENT_LOG_AREA_ADDRESS_END;
	log--;
	if( log->second & 0x80000000 )															/* 最終レコードが書き込み済みなら１周済 */
		;
	else
		DLC_EventFull = 1;
	log = (_EventLog*)EVENT_LOG_AREA_ADDRESS_START;
	DLC_EventIdx = 0;
	for( i = 0; i < EVENT_LOG_NUMOF_ITEM; i++ ){
		if( (uint)log > EVENT_LOG_AREA_ADDRESS_END )
			break;
		if( (uint)log < EVENT_LOG_AREA_ADDRESS_START )
			break;
		if( log->second & 0x80000000 )
			return;
		DLC_EventIdx++;
		sec = log->second;
		++log;
	}
	DLC_EventIdx = 0;
	log = (_EventLog*)EVENT_LOG_AREA_ADDRESS_START;
	for( i = 0; i < EVENT_LOG_NUMOF_ITEM; i++ ){
		if( sec > log->second ){
			block = (uint)log & EVENT_LOG_AREA_BLOCK_MSK;
			NVMCTRL_RowErase( block );puthxw( block );putst("deleted!\r\n");
			return;
		}
		DLC_EventIdx++;
		sec = log->second;
		++log;
	}

}
/*****
* TITLE		：DLC イベントログの保存
* RETURN	：
* 機能 		：最初だけ、DLC_EventIdxで空いてるまで探す、２回目からは、DLC_EventIdxで直書く
*****/
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
void DLCEventLogWrite( ushort ID1,uint ID2,uint ID3 )
{
	_EventLog	*log;
	uchar		flg=0;
	DLC_EventLog.second = RTC_now;															/* 現時刻 Get!秒 */
	DLC_EventLog.mSecond = SYS_mSec;														/* 現時刻 Get!m秒 */
	DLC_EventLog.ID1 = ID1;
	DLC_EventLog.ID2 = ID2;
	DLC_EventLog.ID3 = ID3;
Retry:
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
	case _ID1_MAT_VERSION:
		strcat( str,"MATVer ");
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
	case _ID1_ONLINE_UPD_B_START:
		strcat( str,"Boot更新開始 ");
		break;
	case _ID1_ONLINE_UPD_B_END:
		strcat( str,"Boot更新終了 ");
		break;
	case _ID1_BATTERY:
		strcat( str,"BATTRY ");
		break;
	case _ID1_CONNECT:
		strcat( str,"CNNECT ");
		break;
	case _ID1_CONFIGRET:
		strcat( str,"CNFRET ");
		break;
	case _ID1_REPORT:
		strcat( str,"REPORT ");
		break;
	case _ID1_WATCHDOG_START:
		strcat( str,"WDT    ");
		break;
	case _ID1_SOMETHING:
		strcat( str,"ERR    ");
		break;
	case _ID1_SEREAL_NOISE:
		strcat( str,"NOISE  ");
		break;
	case _ID1_MANTE_START:
		strcat( str,"MNT    ");
		break;
	case _ID1_INIT_ALL:
		strcat( str,"INIT   ");
		break;
	case 0:
		strcat( str,"       ");
		break;
	default:
		sprintf( tmp,"%08X ",log->ID1 );
		break;
	}
	sprintf( tmp,"%08X ",log->ID2 );
	strcat( str, tmp );
	sprintf( tmp,"%08X ",log->ID3 );
	strcat( str, tmp );
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
}
void DLCMatEventLog()
{
	int				i;
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
		NcuEventLogPrint( log,1 );
		++log;
		DLC_delay(40);
	}
}
/*****
* ﾀｲﾄﾙ		：Flashのログ領域を削除する。
* ﾘﾀｰﾝ		：
* ﾊﾟﾗﾒｰﾀ	：
* 機能 		：イベントログ領域の削除
* 更新記録	：14/04/22			新規
*/
void DLCEventLogClr()
{
#if 1
	NVMCTRL_RowErase( EVENT_LOG_AREA_ADDRESS_START );puthxw( EVENT_LOG_AREA_ADDRESS_START );putst("deleted!\r\n");
#else
	int		address;

	for(address=EVENT_LOG_AREA_ADDRESS_START;address<EVENT_LOG_AREA_ADDRESS_END;address+=EVENT_LOG_AREA_ERASE_SZ){
		NVMCTRL_RowErase( address );puthxw( address );putst("deleted!\r\n");
	}
#endif
	DLC_EventIdx = 0;
}
