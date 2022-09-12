//#define	__DAIKOKU
/*
	通信タスク
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
void DLCMatTimerInt();
void DLCMatState();
void IDLEputch();
void command_main();
//void _GO_IDLE(){command_main();DLCMatState();}
void _GO_IDLE(){DLCMatState();IDLEputch();}
void Moni();
void DLCMatConfigDefault(),DLCMatStatusDefault(),DLCMatReortDefault();
void DLCMatPostConfig(),DLCMatPostStatus(),DLCMatPostSndSub(),DLCMatPostReport();
void DLCMatTimerset(int tmid,int cnt );
void DLCMatWgetFile();	// fota FOTAファイルwget
extern	char _Main_version[];
int DLCMatRecvDisp();
int DLCMatRecvWriteFota();	// fota FOTAデータ書込み処理
char 	zLogOn=1;
char	DLC_MatVer[8];
char 	DLC_MatResBuf[1050];
int	 	DLC_MatResIdx;
uchar	DLC_MatLineBuf[2100];
int		DLC_MatLineIdx;
uchar	DLC_Matfact,DLC_MatState;
char	DLC_MatDateTime[32];
char	DLC_MatRadioDensty[64];
char	DLC_MatNUM[16] = "812001003404286";
char	DLC_MatIMEI[16];
int		DLC_MatTmid;
uchar	DLC_BigState,DLC_Matknd;
uchar	DLC_MatRetry;
char	DLC_MatConfigItem[32];
uchar	DLC_MatTxType;

bool	DLC_MatFotaExe=false;	// fota FOTA実行フラグ
// bool	DLC_MatFotaExe=true;	// fota FOTA実行フラグ
bool	DLC_MatFotaWriteNG=false;	// fota FOTA書込みNGフラグ
int	 	DLC_MatSPIFlashPage=256;	// fota SPIフラッシュ1ページbyte数
int	 	DLC_MatSPIRemaindataFota;	// fota 1ページ未満の半端byte数→保持して次回書込み
int	 	DLC_MatSPIWritePageFota;	// fota SPI書込みページインデックス
char	DLC_MatSPIRemainbufFota[256];	// fota 1ページ未満の半端byte保持バッファ
char	DLC_MatSPICheckbufFota[256];	// fota ベリファイ用バッファ
static	char wget_Head[] = "GET /wpfm.bin HTTP/1.1\r\nHost:harvest-files.soracom.io\r\nUser-Agent: Wget\r\nConnection: close\r\n\r\n";	// fota FOTAデータ指定
// static char wget_Head[] = "GET /2048.bin HTTP/1.1\r\nHost:harvest-files.soracom.io\r\nUser-Agent: Wget\r\nConnection: close\r\n\r\n";	// fota
// static char wget_Head[] = "GET /256.bin HTTP/1.1\r\nHost:harvest-files.soracom.io\r\nUser-Agent: Wget\r\nConnection: close\r\n\r\n";	// fota
#define	 	DLC_MatSPIFlashAddrFota		0xE00000;	// fota SPIフラッシュ書込みアドレス
char getkey()
{
	char	c;
	if( SERCOM0_USART_Read( (unsigned char*)&c,1 ) ){
		putch(c);
		return c;
	}
	return 0;
}
char getch()
{
	char	c;
	while(1){
		if( SERCOM0_USART_Read( (unsigned char*)&c,1 ) ){
			putch(c);
			return c;
		}
		_GO_IDLE();
	}
}
#define	_DEBUG_PUTCH_SZ_MAX		0x0800
#define	_DEBUG_PUTCH_SZ_MSK		0x07FF
struct {
	int	wx;
	int	rx;
	char	buff[_DEBUG_PUTCH_SZ_MAX];
} DLC_Matdebug;
void putch( char c )
{
	DLC_Matdebug.buff[DLC_Matdebug.wx++] = c;
	DLC_Matdebug.wx &= _DEBUG_PUTCH_SZ_MSK;
}
void IDLEputch( )
{
	char	c;
	if( DLC_Matdebug.wx != DLC_Matdebug.rx ){
		c = DLC_Matdebug.buff[DLC_Matdebug.rx];
		if( SERCOM0_USART_Write( (unsigned char*)&c,1 ) == 1 ){
			DLC_Matdebug.rx++;
			DLC_Matdebug.rx &= _DEBUG_PUTCH_SZ_MSK;
			return;
		}
	}
}
/*
	Function:通信タスクのタイマー登録
*/
#define		TIMER_1000ms	1000
#define		TIMER_3000ms	3000
#define		TIMER_5000ms	5000
#define		TIMER_7000ms	7000
#define		TIMER_12s		12000
#define		TIMER_15s		15000
#define		TIMER_30s		30000
#define		TIMER_NUM		5
struct {
	int		cnt;
	uchar	TO;
} DLC_MatTimer[TIMER_NUM];
void DLCMatTimerset(int tmid,int cnt )
{
	DLC_MatTimer[tmid].cnt = cnt;
}
void DLCMatTimerClr(int tmid )
{
	DLC_MatTimer[tmid].cnt = 0;
	DLC_MatTimer[tmid].TO = 0;
}
/*
	Function:通信タスクのTO通知の確認
*/
int	DLCMatTmChk(int tmid)
{
	if( DLC_MatTimer[tmid].TO ){
		if( DLC_MatTimer[tmid].cnt == 0 ){
			DLC_MatTimer[tmid].TO = 0;
			return 1;
		}
	}
	return 0;
}
void DLCMatTimerInt()
{
	for(int i=0;i<TIMER_NUM;i++ ){
		if( DLC_MatTimer[i].cnt != 0 ){
			DLC_MatTimer[i].cnt--;
			if( DLC_MatTimer[i].cnt == 0 )
				DLC_MatTimer[i].TO = 1;
		}
	}
//	putch('t');
}
/*
	MATcoreをWAKEUPさせる処理
*/
void DLCMatWake()
{
	int		i;
	PORT_GroupWrite( PORT_GROUP_1,0x1<<10,-1 );						/* Wake! */
	for(i=0;i<1000;i++){
		APP_delay(1);
		if( PORT_GroupRead( PORT_GROUP_1 ) & (0x1<<11))
			break;
		PORT_GroupWrite( PORT_GROUP_1,0x1<<10,0 );
		APP_delay(1);
		PORT_GroupWrite( PORT_GROUP_1,0x1<<10,-1 );
	}
	if( i == 1000 )
		putst("MATcore Wake Err!\r\n");
}
/* 
	Function:通信タスクの変数初期化、TC5(内部タイマー)のコールバック登録
*/
void DLCMatInit()
{
    TC5_TimerCallbackRegister( (TC_TIMER_CALLBACK)DLCMatTimerInt, (uintptr_t)0 );
 	TC5_TimerStart();
	DLCMatTimerset( 0,TIMER_5000ms );
	PORT_GroupWrite( PORT_GROUP_1,0x1<<10,-1 );						/* Wake! */
}
void DLCMatLog(int len)
{
	uchar	c;
	if( zLogOn ){
		for(int i=0;i<len;i++){
			c = DLC_MatLineBuf[DLC_MatLineIdx+i];
			putch( c );
			if( c == '\r')
				putch('\n');
		}
	}
}
void DLCMatSend( char *s )
{
	int i,sz,blk,rmn;
	sz = strlen( s );
	if( sz < 64 ){
		putst( s );putch('\n');
	}
	blk = sz/64;
	rmn = sz%64;
	for( i=0;i<blk;i++){
		SERCOM5_USART_Write( (uint8_t*)&s[i*64],64 );
		APP_delay(57);
	}
	if( rmn ){
		SERCOM5_USART_Write( (uint8_t*)&s[i*64],rmn );
	}
}
int	DLCMatCharInt( char *p,char *title )
{
	char	*q;
	int		len,wk=0;
	len = strlen(title);
	p = strstr( p,title );
	if( p ){
		if( p[len] == '-' ){															/* マイナス */
			q = strchr( p,'\r' );
			if( q ){
				str2int( &p[len+1],&wk );
				wk *= -1;
			}
		}
		else {
			q = strchr( p,'\r' );
			if( q ){
				str2int( &p[len+1],&wk );
			}
		}
	}
	return wk;
}
/* 要因 */
#define		MATC_FACT_RDY	0
#define		MATC_FACT_ERR	1
#define		MATC_FACT_VER	2
#define		MATC_FACT_NUM	3
#define		MATC_FACT_OK	4
#define		MATC_FACT_CON	5
#define		MATC_FACT_TIM	6
#define		MATC_FACT_RSR	7
#define		MATC_FACT_OPN	8
#define		MATC_FACT_CLS	9
#define		MATC_FACT_DATA	10
#define		MATC_FACT_DSC	11
#define		MATC_FACT_TO1	12
#define		MATC_FACT_WUP	13
#define		MATC_FACT_FOTA	14
#define		MATC_FACT_FTP	15
#define		MATC_FACT_SLP	16
#define		MATC_FACT_TO2	17
/* 状態 */
#define		MATC_STATE_INIT	0
#define		MATC_STATE_IDLE	1
#define		MATC_STATE_IMEI	2
#define		MATC_STATE_APN	3
#define		MATC_STATE_SVR	4
#define		MATC_STATE_CONN	5
#define		MATC_STATE_COND	6
#define		MATC_STATE_OPN1	7
#define		MATC_STATE_CNFG	8
#define		MATC_STATE_OPN2	9
#define		MATC_STATE_STAT	10
#define		MATC_STATE_OPN3	11
#define		MATC_STATE_RPT 	12
#define		MATC_STATE_SLP 	13
#define		MATC_STATE_FOTA	14
#define		MATC_STATE_FCON	15
#define		MATC_STATE_FTP  16
#define		MATC_STATE_MNT 	17
#define		MATC_STATE_ERR 	18
void ______(){	DLC_MatLineIdx = 0;};
void MTRdy()
{
	DLC_MatLineIdx = 0;
	DLCMatSend( "AT$VER\r" );
	DLCMatTimerset( 0,TIMER_3000ms );
	DLC_MatState = MATC_STATE_IDLE;
}
void MTVrT()
{
	DLC_MatLineIdx = 0;
	DLCMatSend( "AT$VER\r" );
	DLCMatTimerset( 0,TIMER_3000ms );
}
void MTVer()
{
	DLC_MatLineIdx = 0;
	DLCMatSend( "AT$IMEI\r" );
	if( strstr( DLC_MatVer,"01.04" ) )
		;
	else
		DLCMatSend( "AT$NUM\r" );
	DLCMatTimerset( 0,TIMER_5000ms );
	DLC_MatState = MATC_STATE_IMEI;
}
void MTimei()
{
	DLC_MatLineIdx = 0;
	DLCMatSend( "AT$SETAPN,soracom.io,sora,sora,PAP\r" );
	DLCMatTimerset( 0,TIMER_5000ms );
	DLC_MatState = MATC_STATE_APN;
}
void MTapn()
{
	DLC_MatLineIdx = 0;
	if (DLC_MatFotaExe == false) {	// fota 運用時
#ifdef __DAIKOKU
		DLCMatSend( "AT$SETSERVER,karugamosoft.ddo.jp,9999\r" );
#else
		DLCMatSend( "AT$SETSERVER,beam.soracom.io,8888\r" );
#endif
	} else {	// FOTA実行時
		DLCMatSend( "AT$SETSERVER,harvest-files.soracom.io,80\r" );	// fota soracom harvest指定
	}
	DLCMatTimerset( 0,TIMER_5000ms );
	DLC_MatState = MATC_STATE_SVR;
}
void MTserv()
{
	void MTdisc();
	DLC_MatLineIdx = 0;
	if( DLC_Matknd ){													/* 発呼要求保持 */
		DLCMatSend( "AT$CONNECT\r" );
		DLCMatTimerset( 0,TIMER_12s );
		DLC_MatState = MATC_STATE_CONN;
	}
	else {
		MTdisc();
	}
}
void MTconn()
{
	DLC_MatLineIdx = 0;
	DLCMatSend( "AT$CONNECT?\r" );
	DLCMatTimerset( 0,TIMER_30s );
	if (DLC_MatFotaExe == false) {	// fota 運用時
		DLC_MatState = MATC_STATE_COND;
	} else {	//  FOTA実行時
		DLC_MatState = MATC_STATE_FOTA;	// fota FOTA stateへ
	}
}
void MTtime()
{
	memcpy( DLC_MatDateTime,DLC_MatLineBuf,DLC_MatLineIdx );
	DLC_MatLineIdx = 0;
	DLCMatSend( "AT$TIME\r" );
	DLCMatTimerset( 0,TIMER_3000ms );
}
void MTrsrp()
{
	DLC_MatLineIdx = 0;
	if( strstr( DLC_MatVer,"01.04" ) )
		;
	else
		DLCMatSend( "AT$CELLID\rAT$EARFCN\r" );
	DLCMatSend( "AT$RSRP\rAT$RSRQ\rAT$RSSI\rAT$SINR\r" );
}
void MTopn1()
{
	memcpy( DLC_MatRadioDensty,DLC_MatLineBuf,DLC_MatLineIdx );
	DLC_MatLineIdx = 0;
	DLCMatSend( "AT$OPEN\r" );
	DLCMatTimerset( 0,TIMER_15s );
	DLC_MatState = MATC_STATE_OPN1;
}
void MTopnF()	// fota
{
	DLC_MatLineIdx = 0;
	DLCMatSend( "AT$OPEN\r" );
	DLCMatTimerset( 0,TIMER_15s );
}
void MTOpen()
{
	memcpy( DLC_MatRadioDensty,DLC_MatLineBuf,DLC_MatLineIdx );
	DLC_MatLineIdx = 0;
	DLCMatSend( "AT$OPEN\r" );
	DLCMatTimerset( 0,TIMER_15s );
	DLC_MatState = MATC_STATE_OPN1;
}
void MTcnfg()
{
	DLC_MatLineIdx = 0;
	DLCMatPostConfig();
	DLC_MatState = MATC_STATE_CNFG;
	DLCMatTimerset( 0,TIMER_30s );
}
void MTwget()	// fota
{
	DLC_MatLineIdx = 0;
	DLCMatWgetFile();
	DLCMatTimerset( 0,TIMER_30s );
}
void MTrrcv()
{
	putst("★");
	DLCMatTimerset( 0,TIMER_7000ms );
}
void MTrvTO()
{
	DLC_MatLineIdx = 0;
	DLCMatSend( "AT$CLOSE\r" );
	DLCMatTimerset( 0,TIMER_3000ms );
}
void MTdata()
{
	int	rt;
	DLCMatTimerClr( 3 );									/* AT$RECV,1024リトライタイマークリア */
	rt = DLCMatRecvDisp();
	putst("RecvRet=");puthxs( rt );putcrlf();
	DLC_MatLineIdx = 0;
	if( rt == 0 ){
		zLogOn = 1;
		DLCMatTimerset( 0,TIMER_12s);
	}
	else {
		DLCMatSend( "AT$RECV,1024\r" );
	}
}
void MTfirm()	// fota
{
	int	rt;
	if (DLC_MatFotaWriteNG == false) {	/* 書込みNGなし */
		DLCMatTimerset( 0,TIMER_12s);
	}
	rt = DLCMatRecvWriteFota();			/* 内部Flashへ受信データ書込み処理 */
	putst("RecvRet=");puthxs( rt );putcrlf();
	if( rt == 0 ){
		DLC_MatLineIdx = 0;
		zLogOn = 1;
	}
	else {
		DLC_MatLineIdx = 0;
		DLCMatSend( "AT$RECV,1024\r" );
//		DLCMatSend( "AT$RECV,512\r" );
	}
}
void MTcls1()
{
	DLC_MatLineIdx = 0;
	DLCMatSend( "AT$OPEN\r" );
	DLC_MatState = MATC_STATE_OPN2;
}
void MTstst()
{
	DLC_MatLineIdx = 0;
	DLCMatPostStatus();
	DLCMatTimerset( 0,TIMER_30s );
	DLC_MatState = MATC_STATE_STAT;
}
void MTcls2()
{
	DLC_MatLineIdx = 0;
	DLCMatSend( "AT$OPEN\r" );
	DLCMatTimerset( 0,TIMER_15s );
	DLC_MatState = MATC_STATE_OPN3;
}
void MTrprt()
{
	DLC_MatLineIdx = 0;
	DLCMatPostReport();
	DLCMatTimerset( 0,TIMER_30s );
	DLC_MatState = MATC_STATE_RPT;
}
void MTrpOk()
{
	DLC_MatLineIdx = 0;
	DLCMatPostSndSub();
	DLCMatTimerset( 0,TIMER_3000ms );
	DLC_MatState = MATC_STATE_RPT;
}
void MTdisc()
{
	DLC_MatLineIdx = 0;
	DLCMatTimerset( 0,TIMER_12s );
	PORT_GroupWrite( PORT_GROUP_1,0x1<<10,0 );						/* Sleep! */
	DLC_MatState = MATC_STATE_SLP;
}
void MTcls3()
{
	DLC_MatLineIdx = 0;
	if( ++DLC_MatRetry > 3 ){
		MTdisc();
		return;
	}
	DLC_Matknd = 0;
	DLCMatSend( "AT$DISCONNECT\r" );
	DLCMatTimerset( 0,TIMER_3000ms );
}
void MTclsF()	// fota
{
	int		fotaaddress=DLC_MatSPIFlashAddrFota;	/* FOTAデータ保存番地 */
	DLC_MatLineIdx = 0;
	putst("RecvData2:\r\n");
// putst("DLC_MatSPIRemaindataFota:");puthxw(DLC_MatSPIRemaindataFota);putcrlf();
	fotaaddress /= DLC_MatSPIFlashPage;
	if (DLC_MatSPIRemaindataFota != 0) {	/* 半端byteありの場合 */
		if (W25Q128JV_programPage(fotaaddress + DLC_MatSPIWritePageFota, 0, (uint8_t*)DLC_MatSPIRemainbufFota, DLC_MatSPIFlashPage, true) == W25Q128JV_ERR_NONE ){	/* 256byte書込む */
			puthxw(DLC_MatSPIFlashPage * (fotaaddress + DLC_MatSPIWritePageFota));
			putst("_R:OK");putcrlf();
			memset(DLC_MatSPICheckbufFota, 0xFF, sizeof(DLC_MatSPICheckbufFota));
			if (W25Q128JV_readData(DLC_MatSPIFlashPage * (fotaaddress + DLC_MatSPIWritePageFota), (uint8_t*)DLC_MatSPICheckbufFota, DLC_MatSPIFlashPage) == W25Q128JV_ERR_NONE) {
				if (memcmp(DLC_MatSPICheckbufFota, DLC_MatSPIRemainbufFota, DLC_MatSPIFlashPage) == 0) {
					putst("VERFY OK\r\n");
				} else {
					DLC_MatFotaWriteNG = true;
					putst("VERFY NG\r\n");
				}
			} else {
				DLC_MatFotaWriteNG = true;
				putst("READ NG\r\n");
			}
		} else {
			DLC_MatFotaWriteNG = true;
			putst("PROG NG\r\n");
		}
		putst("BufData2:\r\n");Dump(DLC_MatSPIRemainbufFota, sizeof(DLC_MatSPIRemainbufFota));putcrlf();
	}
	if (DLC_MatFotaWriteNG == false) {	/* 書込みNGなし */
		memset(DLC_MatSPICheckbufFota, 0xFF, sizeof(DLC_MatSPICheckbufFota));
		DLC_MatSPICheckbufFota[0xFC] = 0x04;
		DLC_MatSPICheckbufFota[0xFD] = 0x03;
		DLC_MatSPICheckbufFota[0xFE] = 0x02;
		DLC_MatSPICheckbufFota[0xFF] = 0x01;
		putst("CheckData:\r\n");Dump(DLC_MatSPICheckbufFota, DLC_MatSPIFlashPage);putcrlf();
		if (W25Q128JV_programPage(fotaaddress + 0x35F, 0, (uint8_t*)DLC_MatSPICheckbufFota, DLC_MatSPIFlashPage, true) == W25Q128JV_ERR_NONE ){	/* チェック用256byte書込む */
			DLCMatTimerClr( 0 );	/* タイマークリア */
			putst("FOTA timer CLR\r\n");
// putst("address:");puthxw(fotaaddress + 0x35F);putcrlf();
		}
	}
}
void MTRSlp()
{
	DLC_MatLineIdx = 0;
	if( PORT_GroupRead( PORT_GROUP_1 ) & (0x1<<11))
		putst("MATcore can't Sleep(ToT)\r\n");
	else {
		putst("【Sleep】\r\n");
	}
	if( DLC_Matknd ){
		DLCMatWake();
	}
}
void MTslep()
{
	DLC_MatLineIdx = 0;
	putst("【Sleep】\r\n");
	DLCMatTimerClr( 0 );
	DLC_MatState = MATC_STATE_SLP;
	if( DLC_Matknd ){
		DLCMatWake();
	}
}
void MTslp1()
{
	PORT_GroupWrite( PORT_GROUP_1,0x1<<10,-1 );						/* Wake! */
}
void MTwake()
{
	putst("【Wake】\r\n");
	DLCMatWake();
	DLC_MatLineIdx = 0;
	DLCMatSend( "AT$CONNECT\r" );
	DLCMatTimerset( 0,TIMER_12s );
	DLC_MatState = MATC_STATE_CONN;
}
void MTtoF()	// fota T/O
{
	int		fotaaddress=DLC_MatSPIFlashAddrFota;	/* FOTAデータ保存番地 */
	// 実行フラグそのままでリセットしリトライ?
	W25Q128JV_eraseSctor(((fotaaddress + 0x36000) / 0x1000) - 1, true);	/* 失敗なのでFOTAデータ最終セクタ消去(SPI Flash) */
}
struct {
	uchar	wx;
	uchar	rx;
	int		msg[0x20];
} DLC_MatMsg;
#define		MSGID_TIMER		1
#define		MSGID_WAKEUP	2
int	 MatGetMsgStack()
{
	int msg;
	if( DLC_MatMsg.wx != DLC_MatMsg.rx ){
		msg = DLC_MatMsg.msg[DLC_MatMsg.rx++];
		DLC_MatMsg.rx &= 0x1F;
		return msg;
	}
	return -1;
}
void MatMsgSend( int msg )
{
	DLC_MatMsg.msg[DLC_MatMsg.wx++] = msg;
	DLC_MatMsg.wx &= 0x1F;
}
void DLCMatClockDisplay(char *s)
{
	RTC_DATETIME dt;
	RTC_getDatetime( &dt );
	sprintf( s,"%02d/%02d/%02d %02d:%02d:%02d",(int)dt.year,(int)dt.month,(int)dt.day,(int)dt.hour,(int)dt.minute,(int)dt.second );
}
void DLCMatClockGet(MLOG_T *log_p,char *s)
{
	RTC_DATETIME dt;
	RTC_convertToDateTime(log_p->timestamp.second,&dt);
	sprintf( s,"20%02d-%02d-%02d %02d:%02d:%02d",(int)dt.year,(int)dt.month,(int)dt.day,(int)dt.hour,(int)dt.minute,(int)dt.second );
}
/*
	計測からCallされて、通信を行う 通信タスクをWAKEUPさせると通信は勝手に走って、終わるとSleepへ行く
*/
void DLCMatCall(int knd )
{
	if( DLC_Matknd )
		putst("Stacked TheCall..\r\n" );
	DLC_Matknd = knd;
	switch( DLC_Matknd ){
	case 1:
		putst("●CALL!\r\n");										/* Constant */
		break;
	case 2:	
		putst("■CALL!\r\n");										/* Push */
		break;
	case 3:
		putst("★CALL!\r\n");										/* Alert */
		break;
	}
	MatMsgSend( MSGID_WAKEUP );
}
void DLCMatSleepWait()
{
	for(int i=0;i<6000;i++){
		_GO_IDLE();
		if( DLC_MatState == MATC_STATE_SLP ){
			return;
		}
		APP_delay(10);
	}
	putst("MATcore Startup Err\r\n");
}
uchar	DLC_MatLedTest;
void MTtim2()
{
	if( DLC_MatLedTest ){
		DLCMatTimerset( 1,500 );
		if( DLC_MatLedTest & 0x10 ){
			if( DLC_MatLedTest & 0x01 ){
				DLC_MatLedTest &= ~0x01;
				GPIOEXP_set(0);
			}
			else {
				DLC_MatLedTest |= 0x01;
				GPIOEXP_clear(0);
			}
		}
		if( DLC_MatLedTest & 0x20 ){
			if( DLC_MatLedTest & 0x02 ){
				DLC_MatLedTest &= ~0x02;
				GPIOEXP_set(1);
			}
			else {
				DLC_MatLedTest |= 0x02;
				GPIOEXP_clear(1);
			}
		}
		if( DLC_MatLedTest & 0x40 ){
			if( DLC_MatLedTest & 0x04 ){
				DLC_MatLedTest &= ~0x04;
				GPIOEXP_set(2);
			}
			else {
				DLC_MatLedTest |= 0x04;
				GPIOEXP_clear(2);
			}
		}
	}
}
void	 (*MTjmp[18][19])() = {
/*					  0         1       2      3       4       5       6       7       8       9       10      11      12      13      14      15      16      17   18     */
/*				  	 INIT    IDLE    IMEI    APN     SVR     CONN    COND    OPN1    CNFG    OPN2    STAT    OPN3    REPT    SLEEP   FOTA    FCON    FTP     MNT     ERR   */
/* MATCORE RDY 0 */{ MTRdy,  MTRdy,  MTRdy,  MTRdy,  MTRdy,  MTRdy,  MTRdy,  MTRdy,  MTRdy,  MTRdy,  MTRdy,  MTRdy,  MTRdy,  MTRdy,  MTRdy,  MTRdy,  MTRdy,  MTRdy,  MTRdy  },
/* ERROR       1 */{ ______, MTVrT,  ______, ______, ______, ______, ______, MTopn1, ______, ______, ______, ______, MTcls3, ______, ______, ______, ______, ______, ______ },
/* $VER		   2 */{ ______, MTVer,  ______, ______, ______, ______, ______, ______, ______, ______, ______, ______, ______, ______, ______, ______, ______, ______, ______ },
/* $NUM		   3 */{ ______, ______, MTimei, ______, ______, ______, ______, ______, ______, ______, ______, ______, ______, ______, ______, ______, ______, ______, ______ },
/* OK          4 */{ ______, ______, ______, MTapn,  MTserv, MTconn, ______, ______, MTrrcv, ______, MTrrcv, ______, MTrpOk, ______, ______, ______, ______, ______, ______ },
/* $CONNECT:1  5 */{ ______, ______, ______, ______, ______, ______, MTtime, ______, ______, ______, ______, ______, ______, ______, MTopnF, ______, ______, ______, ______ },
/* $TIME       6 */{ ______, ______, ______, ______, ______, ______, MTrsrp, ______, ______, ______, ______, ______, ______, ______, ______, ______, ______, ______, ______ },
/* $RSRP       7 */{ ______, ______, ______, ______, ______, ______, MTOpen, ______, ______, ______, ______, ______, ______, ______, ______, ______, ______, ______, ______ },
/* $OPEN/$WAKE 8 */{ ______, ______, ______, ______, ______, ______, ______, MTcnfg, ______, MTstst, ______, MTrprt, ______, MTwake, MTwget, ______, ______, ______, ______ },
/* $CLOSE      9 */{ ______, ______, ______, ______, ______, ______, ______, ______, MTcls1, ______, MTcls2, ______, MTcls3, ______, MTclsF, ______, ______, ______, ______ },
/* $RECVDATA  10 */{ ______, ______, ______, ______, ______, ______, ______, ______, MTdata, ______, MTdata, ______, MTdata, ______, MTfirm, ______, ______, ______, ______ },
/* $CONNECT:0 11 */{ ______, ______, ______, ______, ______, ______, ______, ______, ______, ______, ______, ______, MTdisc, ______, ______, ______, ______, ______, ______ },
/* TimOut1    12 */{ MTRdy,  MTVrT,  MTVer,  MTimei, MTserv, MTserv, ______,______, MTrvTO, ______, MTrvTO, MTcls2, MTcls3, MTRSlp, MTtoF,  ______, ______, ______, ______ },
/* WAKEUP     13 */{ ______, ______, ______, ______, ______, ______, ______, ______, ______, ______, ______, ______, ______, MTwake, ______, ______, ______, ______, ______ },
/* FOTA       14 */{ ______, ______, ______, ______, ______, ______, ______, ______, ______, ______, ______, ______, ______, ______, ______, ______, ______, ______, ______ },
/* FTP        15 */{ ______, ______, ______, ______, ______, ______, ______, ______, ______, ______, ______, ______, ______, ______, ______, ______, ______, ______, ______ },
/* $SLEEP     16 */{ ______, ______, ______, ______, ______, ______, ______, ______, ______, ______, ______, ______, ______, MTslep, ______, ______, ______, ______, ______ },
/* TimeOut2   17 */{ MTtim2, MTtim2, MTtim2, MTtim2, MTtim2, MTtim2, MTtim2, MTtim2, MTtim2, MTtim2, MTtim2, MTtim2, MTtim2, MTtim2, MTtim2, MTtim2, MTtim2, MTtim2, MTtim2 },
							};
void DLCMatState()
{
	char	*p,*q;
	int 	len;
	len = SERCOM5_USART_Read( (uint8_t*)&DLC_MatLineBuf[DLC_MatLineIdx],sizeof( DLC_MatLineBuf) );				/* MATcoreから入力 */
	DLCMatLog( len );
	DLC_MatLineIdx += len;
	DLC_Matfact = 0xff;
	if( DLC_MatLineIdx == 6 ){
		if( strstr( (char*)DLC_MatLineBuf,"ERROR\r" )){
			DLC_Matfact = MATC_FACT_ERR;
		}
	}
	if( DLC_MatLineIdx >= 14 ){
		if( strstr( (char*)DLC_MatLineBuf,"MATCORE READY\r" )){
			DLC_Matfact = MATC_FACT_RDY;
		}
	}
	if( DLC_MatLineIdx >= 11 ){								/* $VER:01.04 */
		p = strstr( (char*)DLC_MatLineBuf,"$VER:" );
		if( p ){
			q = strchr( p,'\r' );							/* <cr>まで受信済み */
			if( q ){
				*q = 0;
				strcpy( DLC_MatVer,p+5 );
    			DLC_Matfact = MATC_FACT_VER;
            }
		}
	}
	if( DLC_MatLineIdx >= 21 ){								/* $NUM:022001004788412 */
		p = strstr( (char*)DLC_MatLineBuf,"$NUM:" );
		if( p ){
			q = strchr( p,'\r' );							/* <cr>まで受信済み */
			if( q ){
				*q = 0;
				strcpy( DLC_MatNUM,"81" );
				strcat( DLC_MatNUM, &p[6] );
				DLC_Matfact = MATC_FACT_NUM;
			}
		}
	}
	if( DLC_MatLineIdx >= 22 ){								/* $IMEI:356766100967880 */
		p = strstr( (char*)DLC_MatLineBuf,"$IMEI:" );
		if( p ){
			q = strchr( p,'\r' );							/* <cr>まで受信済み */
			if( q ){
				*q = 0;
				strcpy( DLC_MatIMEI,&p[6] );
				DLC_Matfact = MATC_FACT_NUM;
				
			}
		}
	}
	if( DLC_MatLineIdx == 4 ){
		if( strstr( (char*)DLC_MatLineBuf,"\rOK\r" )){
			DLC_MatLineIdx -= 4;
			memcpy( DLC_MatLineBuf,&DLC_MatLineBuf[4],DLC_MatLineIdx );
			DLC_Matfact = MATC_FACT_OK;
			DLC_MatRetry = 0;
		}
	}
	if( DLC_MatLineIdx == 3 ){
		if( strstr( (char*)DLC_MatLineBuf,"OK\r" )){
			DLC_MatLineIdx -= 3;
			memcpy( DLC_MatLineBuf,&DLC_MatLineBuf[3],DLC_MatLineIdx );
			DLC_Matfact = MATC_FACT_OK;
			DLC_MatRetry = 0;
		}
	}
	if( DLC_MatLineIdx >= 10 ){
		if( strstr( (char*)DLC_MatLineBuf,"$CONNECT:1\r" ))
			DLC_Matfact = MATC_FACT_CON;
		if( strstr( (char*)DLC_MatLineBuf,"$CONNECT:0\r" ))
			DLC_Matfact = MATC_FACT_DSC;
	}
	if( DLC_MatLineIdx >= 24 ){								/* $TIME:22/08:03,18:16:32 */
		p = strstr( (char*)DLC_MatLineBuf,"$TIME:2" );
		if( p ){
			if( strchr( p,'\r' )){							/* <cr>まで受信済み */
				DLC_Matfact = MATC_FACT_TIM;
				RTC_DATETIME dt;
				dt.year   = (p[6]-'0')*10 + (p[7]-'0');
				dt.month  = (p[9]-'0')*10 + (p[10]-'0');
				dt.day	  = (p[12]-'0')*10 + (p[13]-'0');
				dt.hour	  = (p[15]-'0')*10 + (p[16]-'0');
				dt.minute = (p[18]-'0')*10 + (p[19]-'0');
				dt.second = (p[21]-'0')*10 + (p[22]-'0');
				RTC_setDateTime( dt );
			}
		}
	}
	if( DLC_MatLineIdx >= 37 ){								/* $RSRP:-nn<cr>$RSRQ:-n<cr>$RSSI:-nn<cr>$SINR:nn<cr> */
		DLC_MatLineBuf[DLC_MatLineIdx] = 0;
		p = strstr( (char*)DLC_MatLineBuf,"$SINR:" );
		if( p ){
			if( strchr( p,'\r' )){							/* $SINR:nn<cr>まで受信済み */
				DLC_Matfact = MATC_FACT_RSR;
			}
		}
	}
	if( DLC_MatLineIdx >= 6 ){
		if( strstr( (char*)DLC_MatLineBuf,"$OPEN\r" )){
			DLC_Matfact = MATC_FACT_OPN;
		}
		else if( strstr( (char*)DLC_MatLineBuf,"$RECV\r" )){
			DLC_MatLineIdx = 0;
			zLogOn = 0;
			DLCMatSend( "AT$RECV,1024\r" );
			DLCMatTimerset( 3,TIMER_1000ms);
		}
	}
	if( DLC_MatLineIdx >= 7 ){
		if( strstr( (char*)DLC_MatLineBuf,"$CLOSE\r" )){
			DLC_Matfact = MATC_FACT_CLS;
		}
		if( strstr( (char*)DLC_MatLineBuf,"$SLEEP\r" )){
			DLC_Matfact = MATC_FACT_SLP;
		}
	}
	if( DLC_MatLineIdx >= 8 ){
		if( strstr( (char*)DLC_MatLineBuf,"$WAKEUP\r" )){
			DLC_Matfact = MATC_FACT_OPN;
		}
	}
	if( DLC_MatLineIdx >= 15 ){
		DLC_MatLineBuf[DLC_MatLineIdx] = 0;
		if( strstr( (char*)DLC_MatLineBuf,"$RECVDATA:" )){
			p = strchr( (char*)DLC_MatLineBuf,'\"' );
			if( p > 0 ){
				p++;
				q = strstr( p,"\"\r" );
				if( q ){
					putst("RSZ=");puthxs(q-p);putcrlf();
					DLC_Matfact = MATC_FACT_DATA;
				}
			}
		}
	}
	if( DLC_Matfact == 0xff ){
		if( DLCMatTmChk( 0 ) )
			DLC_Matfact = MATC_FACT_TO1;
		else if( DLCMatTmChk( 1 ) )
			DLC_Matfact = MATC_FACT_TO2;
		else if( DLCMatTmChk( 3 ) ){
			DLCMatSend( "AT$RECV,1024\r" );
			putst("リトライ(ToT)\r\n");
		}
		else {
			switch( MatGetMsgStack() ){
			case MSGID_TIMER:
				DLC_Matfact = MATC_FACT_TO1;
				break;
			case MSGID_WAKEUP:
				DLC_Matfact = MATC_FACT_WUP;
				break;
			default:
				return;
			}
		}
	}
	if( DLC_Matfact != 0xff ){
		char	s[20];
		DLCMatClockDisplay(s);putst( s );putst("【");puthxb( DLC_Matfact );putch(':');puthxb( DLC_MatState );putst("】\r\n");
		(*MTjmp[DLC_Matfact][DLC_MatState])();
	}
	if( DLC_MatLineIdx == 0 )
		memset( DLC_MatLineBuf,0,sizeof( DLC_MatLineBuf ));
}
#define	REPORT_LIST_MAX	100
int	DLC_MatReportStack;
void DLCMatConfigDefault()
{
	WPFM_SETTING_PARAMETER	config;
	config.isInvalid = 1;
	config.serialNumber 					= 9999999;
	config.measurementInterval 				= 60;
	config.communicationInterval 			= 300;
	config.measurementIntervalOnAlert	 	= 30;
	config.communicationIntervalOnAlert 	= 120;
	config.Measurment						= 0;
	config.sensorKinds[0]		 			= 1;
	config.upperLimits[0]		 			= 1;
	config.lowerLimits[0]		 			= 0;
	config.alertEnableKinds[0][0][1]  		= 1;
	config.alertUpperLimits[0][1] 			= 0.75;
	config.alertEnableKinds[0][0][0] 		= 1;
	config.alertUpperLimits[0][0] 			= 0.55;
	config.alertEnableKinds[0][1][0]  		= 1;
	config.alertLowerLimits[0][0]  			= 0.25;
	config.alertEnableKinds[0][1][1]  		= 1;
	config.alertLowerLimits[0][1] 			= 0.15;
	strcpy( config.Measure_ch1,"水圧" );
	strcpy( config.MeaKind_ch1,"MPa" );
	config.alertChatteringTimes[0] 			= 100;
	config.alertEnableKinds[1][0][1]		= 1;
	config.alertUpperLimits[1][1]			= -25;
	config.alertEnableKinds[1][0][0]		= 1;
	config.alertUpperLimits[1][0]			= 90;
	config.alertEnableKinds[1][1][0]		= 1;
	config.alertLowerLimits[1][0]			= 0;
	config.alertEnableKinds[1][1][1] 		= 1;
	config.alertLowerLimits[1][1]			= -10;
	strcpy( config.Measure_ch2,"流量" );
	strcpy( config.MeaKind_ch2,"m^3/hour" );
	config.alertChatteringTimes[1] 			= 1;
	config.alertChatteringKind				= 1;
	strcpy( config.AlertPause,"1970-01-01 09:00:01" );
	config.alertTimeout						= 5;
	WPFM_writeSettingParameter( &config );
}
void DLCMatReortDefault()
{
}
static char http_config[] = "POST /config HTTP/1.1\r\nHost:beam.soracom.io\r\nContent-Type:application/json\r\nContent-Length:    \r\n\r\n";
static char http_status[] = "POST /status HTTP/1.1\r\nHost:beam.soracom.io\r\nContent-Type:application/json\r\nContent-Length:    \r\n\r\n";
static char http_report[] = "POST /report HTTP/1.1\r\nHost:beam.soracom.io\r\nContent-Type:application/json\r\nContent-Length:    \r\n\r\n";
static char http_tmp[8600];
char	DLC_MatSendBuff[1024*2+16];
static WPFM_SETTING_PARAMETER	config;
void DLCMatPostConfig()
{
	char	tmp[48],n,*p;
	int		i;
	WPFM_readSettingParameter( &config );
	strcpy( http_tmp,http_config );
	strcat( http_tmp,"{\"Config\":{" );
	sprintf( tmp,"\"LoggerSerialNo\":%d,"		,(int)config.serialNumber );				strcat( http_tmp,tmp );
	sprintf( tmp,"\"Interval\":%ld,"			,config.measurementInterval );				strcat( http_tmp,tmp );
	sprintf( tmp,"\"ReprotInterval\":%ld,"		,config.communicationInterval );			strcat( http_tmp,tmp );
	sprintf( tmp,"\"IntervalAlert\":%ld,"		,config.measurementIntervalOnAlert  );		strcat( http_tmp,tmp );
	sprintf( tmp,"\"ReprotIntervalAlert\":%ld,"	,config.communicationIntervalOnAlert );		strcat( http_tmp,tmp );
	sprintf( tmp,"\"Measurment\":%d,"			,config.Measurment );						strcat( http_tmp,tmp );
	sprintf( tmp,"\"Select_ch1\":%d,"			,config.sensorKinds[0] )		;			strcat( http_tmp,tmp );		/* ch1 センサ種別 */
	sprintf( tmp,"\"Upper0_ch1\":%d,"			,config.upperLimits[0] );					strcat( http_tmp,tmp );		/* ch1 センサ出力の上限値 */
	sprintf( tmp,"\"Lower0_ch1\":%d,"			,config.lowerLimits[0] );					strcat( http_tmp,tmp );		/* ch1 センサ出力の下限値 */
	sprintf( tmp,"\"AlertSw_U2_ch1\":%d,"		,(int)config.alertEnableKinds[0][0][1] );	strcat( http_tmp,tmp );		/* アラート U2 ch1 */
	sprintf( tmp,"\"Upper2_ch1\":%f,"			,config.alertUpperLimits[0][1] );			strcat( http_tmp,tmp );		/* 上限値2 ch1 */
	sprintf( tmp,"\"AlertSw_U1_ch1\":%d,"		,(int)config.alertEnableKinds[0][0][0] );	strcat( http_tmp,tmp );		/* アラート U1 ch1 */
	sprintf( tmp,"\"Upper1_ch1\":%f,"			,config.alertUpperLimits[0][0] );			strcat( http_tmp,tmp );		/* 上限値1 ch1 */
	sprintf( tmp,"\"AlertSw_L1_ch1\":%d,"		,(int)config.alertEnableKinds[0][1][0] );	strcat( http_tmp,tmp );		/* アラート U2 ch1 */
	sprintf( tmp,"\"Lower1_ch1\":%f,"			,config.alertLowerLimits[0][0] );			strcat( http_tmp,tmp );		/* 上限値2 ch1 */
	sprintf( tmp,"\"AlertSw_L2_ch1\":%d,"		,(int)config.alertEnableKinds[0][1][1] );	strcat( http_tmp,tmp );
	sprintf( tmp,"\"Lower2_ch1\":%f,"			,config.alertLowerLimits[0][1] );			strcat( http_tmp,tmp );
 	sprintf( tmp,"\"Measure_ch1\":\"%s\","		,config.Measure_ch1 );						strcat( http_tmp,tmp );
 	sprintf( tmp,"\"MeaKind_ch1\":\"%s\","		,config.MeaKind_ch1 );						strcat( http_tmp,tmp );
	sprintf( tmp,"\"Chattering_ch1\":%d,"		,config.alertChatteringTimes[0] );			strcat( http_tmp,tmp );
	sprintf( tmp,"\"Select_ch2\":%d,"			,config.sensorKinds[1] );					strcat( http_tmp,tmp );
	sprintf( tmp,"\"Upper0_ch2\":%d,"			,config.upperLimits[1] );					strcat( http_tmp,tmp );
	sprintf( tmp,"\"Lower0_ch2\":%d,"			,config.lowerLimits[1] );					strcat( http_tmp,tmp );
	sprintf( tmp,"\"AlertSw_U2_ch2\":%d,"		,(int)config.alertEnableKinds[1][0][1] );	strcat( http_tmp,tmp );
	sprintf( tmp,"\"Upper2_ch2\":%f,"			,config.alertUpperLimits[1][1] );			strcat( http_tmp,tmp );
	sprintf( tmp,"\"AlertSw_U1_ch2\":%d,"		,(int)config.alertEnableKinds[1][0][0] );	strcat( http_tmp,tmp );
	sprintf( tmp,"\"Upper1_ch2\":%f,"			,config.alertUpperLimits[1][0] );			strcat( http_tmp,tmp );
	sprintf( tmp,"\"AlertSw_L1_ch2\":%d,"		,(int)config.alertEnableKinds[1][1][0] );	strcat( http_tmp,tmp );
	sprintf( tmp,"\"Lower1_ch2\":%f,"			,config.alertLowerLimits[1][0] );			strcat( http_tmp,tmp );
	sprintf( tmp,"\"AlertSw_L2_ch2\":%d,"		,(int)config.alertEnableKinds[1][1][1] );	strcat( http_tmp,tmp );
	sprintf( tmp,"\"Lower2_ch2\":%f,"			,config.alertLowerLimits[1][1] );			strcat( http_tmp,tmp );
	sprintf( tmp,"\"Measure_ch2\":\"%s\","		,config.Measure_ch2 );						strcat( http_tmp,tmp );
	sprintf( tmp,"\"MeaKind_ch2\":\"%s\","		,config.MeaKind_ch2 );						strcat( http_tmp,tmp );
	sprintf( tmp,"\"Chattering_ch2\":%d,"		,config.alertChatteringTimes[1] );			strcat( http_tmp,tmp );
	sprintf( tmp,"\"Chattering_type\":%d,"		,config.alertChatteringKind );				strcat( http_tmp,tmp );
	sprintf( tmp,"\"AlertPause\":\"%s\","		,config.AlertPause );						strcat( http_tmp,tmp );
	sprintf( tmp,"\"AlertTimeOut\":%d"			,config.alertTimeout );						strcat( http_tmp,tmp );
	strcat( http_tmp,"}}" );
	config.Measurment = 0;	// =1だった場合、1度Config送信したら戻す
	i = (int)(strchr(http_tmp,'}')-strstr(http_tmp,"{\"Config\":{"))+1;
	if( i > 0 ){
		p = strstr( http_tmp,"Length:    " );
		if( p < 0 ){
			putst("format err1 \r\n" );
			return;
		}
		sprintf( tmp,"%d",i+1 );
		for( i=0;tmp[i]!=0;i++ )
			p[7+i] = tmp[i];
		putst( http_tmp );putcrlf();
		strcpy( DLC_MatSendBuff,"AT$SEND,\"" );
		tmp[2] = 0;
		for( i=0;http_tmp[i]!=0;i++ ){
			n = http_tmp[i];
			tmp[0] = outhex( n>>4 );
			tmp[1] = outhex( n&0x0f );
			strcat( DLC_MatSendBuff,tmp );
		}
		strcat( DLC_MatSendBuff,"\"\r" );
		DLCMatSend( DLC_MatSendBuff );
	}
}
void DLCMatPostStatus()
{
	char	tmp[48],n,*p,ver[6];
	int		i;
	memcpy( ver,&_Main_version[4],5 );
	ver[5] = 0;
	strcpy( http_tmp,http_status );
	strcat( http_tmp,"{\"Status\":{" );
	putst("Alter=");puthxb( WPFM_lastAlertStatus );putcrlf();
	DLC_MatTxType = 0;
	if( WPFM_lastAlertStatus & (MLOG_ALERT_STATUS_CH1_UPPER_WARNING|MLOG_ALERT_STATUS_CH1_LOWER_WARNING|MLOG_ALERT_STATUS_CH2_UPPER_WARNING|MLOG_ALERT_STATUS_CH2_LOWER_WARNING))
		DLC_MatTxType = 12;
	if( WPFM_lastAlertStatus & (MLOG_ALERT_STATUS_CH1_UPPER_ATTENTION|MLOG_ALERT_STATUS_CH1_LOWER_ATTENTION|MLOG_ALERT_STATUS_CH2_UPPER_ATTENTION|MLOG_ALERT_STATUS_CH2_LOWER_ATTENTION))
		DLC_MatTxType = 11;
	if( DLC_Matknd == 2 )				/* Push SW */
		DLC_MatTxType = 1;
	sprintf( tmp,"\"LoggerSerialNo\":%d,"	,(int)config.serialNumber );					strcat( http_tmp,tmp );
	sprintf( tmp,"\"IMEI\":\"%s\","			,DLC_MatIMEI );									strcat( http_tmp,tmp );
	sprintf( tmp,"\"MSISDN\":\"%s\","		,DLC_MatNUM );									strcat( http_tmp,tmp );
	sprintf( tmp,"\"Version\":\"%5s\","		,ver );											strcat( http_tmp,tmp );
	sprintf( tmp,"\"LTEVersion\":\"%s\","	,DLC_MatVer );									strcat( http_tmp,tmp );
	sprintf( tmp,"\"ExtCellPwr1\":%.3f,"	,(float)WPFM_lastBatteryVoltages[0]/1000 );		strcat( http_tmp,tmp );
	sprintf( tmp,"\"ExtCellPwr2\":%.3f,"	,(float)WPFM_lastBatteryVoltages[1]/1000 );		strcat( http_tmp,tmp );
	sprintf( tmp,"\"Batt1Use\":%d,"			,WPFM_externalBatteryNumberInUse );				strcat( http_tmp,tmp );
	sprintf( tmp,"\"Batt2Use\":%d,"			,WPFM_externalBatteryNumberToReplace );			strcat( http_tmp,tmp );
	sprintf( tmp,"\"EARFCN\":%d,"			,123 );											strcat( http_tmp,tmp );
	sprintf( tmp,"\"CellId\":%d,"			,192 );											strcat( http_tmp,tmp );
	sprintf( tmp,"\"RSRP\":%d,"				,DLCMatCharInt( DLC_MatRadioDensty,"RSRP:" ));	strcat( http_tmp,tmp );
	sprintf( tmp,"\"RSRQ\":%d,"				,DLCMatCharInt( DLC_MatRadioDensty,"RSRQ:" ));	strcat( http_tmp,tmp );
	sprintf( tmp,"\"RSSI\":%d,"				,DLCMatCharInt( DLC_MatRadioDensty,"RSSI:" ));	strcat( http_tmp,tmp );
	sprintf( tmp,"\"SINR\":%d,"				,DLCMatCharInt( DLC_MatRadioDensty,"SINR:" ));	strcat( http_tmp,tmp );
	sprintf( tmp,"\"Temp\":%d,"				,WPFM_lastTemperatureOnBoard );					strcat( http_tmp,tmp );
 	sprintf( tmp,"\"TxType\":%d"			,DLC_MatTxType );								strcat( http_tmp,tmp );
	strcat( http_tmp,"}}" );
	i = (int)(strchr(http_tmp,'}')-strstr(http_tmp,"{\"Status\":{"))+1;
	if( i > 0 ){
		p = strstr( http_tmp,"Length:    " );
		if( p < 0 ){
			putst("format err1 \r\n" );
			return;
		}
		sprintf( tmp,"%d",i+1 );
		for( i=0;tmp[i]!=0;i++ )
			p[7+i] = tmp[i];
		putst( http_tmp );putcrlf();
		strcpy( DLC_MatSendBuff,"AT$SEND,\"" );
		tmp[2] = 0;
		for( i=0;http_tmp[i]!=0;i++ ){
			n = http_tmp[i];
			tmp[0] = outhex( n>>4 );
			tmp[1] = outhex( n&0x0f );
			strcat( DLC_MatSendBuff,tmp );
		}
		strcat( DLC_MatSendBuff,"\"\r" );
		DLCMatSend( DLC_MatSendBuff );
	}
}
/*
	機能：Reportを通知、SPI-Flashに溜まっているReportを通知
	Parameter:通知する数
*/
static	int DLC_MatSndCnt;
void DLCMatPostSndSub()
{
	char	tmp[3],v;
	int		i;
	if( DLC_MatSndCnt < 0 )
		return;
	putst("DLCMatPostSndSub\r\n");
	strcpy( DLC_MatSendBuff,"AT$SEND,\"" );
	tmp[2] = 0;
	for( i=0;http_tmp[DLC_MatSndCnt]!=0;i++ ){
		v = http_tmp[DLC_MatSndCnt];
		tmp[0] = outhex( v>>4 );
		tmp[1] = outhex( v&0x0f );
		strcat( DLC_MatSendBuff,tmp );
		DLC_MatSndCnt++;
		if( i == 1000 ){
			putst("■");
			break;
		}
	}
	strcat( DLC_MatSendBuff,"\"\r" );
	DLCMatSend( DLC_MatSendBuff );
	if( http_tmp[DLC_MatSndCnt]==0 )
		DLC_MatSndCnt = -1;
}
void DLCMatPostReport()
{
	char	tmp[48],*p;
	char	s[32];	
	int		i;
	MLOG_T 	log_p;
	strcpy( http_tmp,http_report );
	strcat( http_tmp,"{\"Report\":{" );
	sprintf( tmp,"\"LoggerSerialNo\":%d,"	,(int)config.serialNumber );				strcat( http_tmp,tmp );
	strcat( http_tmp,"\"Reportlist\":[" );
	for(i=0;i<REPORT_LIST_MAX;i++){
		if( MLOG_getLog( &log_p ) < 0 )
			break;
		DLCMatClockGet( &log_p,s );
		if( i > 0)
			strcat( http_tmp,"," );
		sprintf( tmp,"{\"Time\":\"%s\","		,s );									strcat( http_tmp,tmp );
		sprintf( tmp,"\"Value_ch1\":%.3f,"	,log_p.measuredValues[0] );					strcat( http_tmp,tmp );
		sprintf( tmp,"\"Value_ch2\":%.3f,"	,log_p.measuredValues[1] );					strcat( http_tmp,tmp );
		sprintf( tmp,"\"Alert\":\"%02x\"}"	,log_p.alertStatus  );						strcat( http_tmp,tmp );
	}
	if( i == 0 ){
		putst("Report is 0!\r\n");
		return;
	}
	sprintf( tmp,"Report=%d\r\n",i );putst( tmp );
	strcat( http_tmp,"]}}" );
	i = (int)(strchr(http_tmp,']')-strstr(http_tmp,"{\"Report\":{"))+2;
	if( i > 0 ){
		p = strstr( http_tmp,"Length:    " );
		if( p < 0 ){
			putst("format err1 \r\n" );
			return;
		}
		sprintf( tmp,"%d",i+1 );
		for( i=0;tmp[i]!=0;i++ )
			p[7+i] = tmp[i];
		putst( http_tmp );putcrlf();
	}
	DLC_MatSndCnt = 0;
	DLCMatPostSndSub();
}
void DLCMatWgetFile()	// fota
{
	char	tmp[48],n;
	int		i;
	putst("WgetExe!!!");putcrlf();
	strcpy( http_tmp,wget_Head );	/* soracom harvestへwget */
	putst( http_tmp );putcrlf();
	strcpy( DLC_MatSendBuff,"AT$SEND,\"" );
	tmp[2] = 0;
	for( i=0;http_tmp[i]!=0;i++ ){
		n = http_tmp[i];
		tmp[0] = outhex( n>>4 );
		tmp[1] = outhex( n&0x0f );
		strcat( DLC_MatSendBuff,tmp );
	}
	strcat( DLC_MatSendBuff,"\"\r" );
	DLCMatSend( DLC_MatSendBuff );
}
void DLCMatINTParamSet(char *config_p, bool end)
{
	char	*config_ps;
	int		config_len;
	config_ps = strstr(config_p, ":");
	if (end) {
		config_len = strstr(config_p, "}") - strstr(config_p, ":");
	} else {
		config_len = strstr(config_p, ",") - strstr(config_p, ":");
	}
	memset(DLC_MatConfigItem, 0, sizeof(DLC_MatConfigItem));
	if (config_len > 1) {
		strncpy(DLC_MatConfigItem, config_ps+1, config_len-1);
//		putst("\r\nDLC_MatConfigItem:\r\n");Dump(DLC_MatConfigItem, 16);
	} else {
		DLC_MatConfigItem[0] = 0;
	}
}
void DLCMatSTRParamSet(char *config_p)
{
	char	*config_ps;
	int		config_len;
	config_ps = strstr(config_p, ":");
	config_len = strstr(config_p, ",") - strstr(config_p, ":");
	memset(DLC_MatConfigItem, 0, sizeof(DLC_MatConfigItem));
	if (config_len > 3) {
		strncpy(DLC_MatConfigItem, config_ps+2, config_len-3);	/* ""を含むため */
//		putst("\r\nDLC_MatConfigItem:\r\n");Dump(DLC_MatConfigItem, 16);
	} else {
		DLC_MatConfigItem[0] = 0;
	}
}
void DLCMatReflectionConfig()
{
	WPFM_settingParameter.measurementInterval = config.measurementInterval;
	WPFM_settingParameter.communicationInterval = config.communicationInterval;
	WPFM_settingParameter.measurementIntervalOnAlert = config.measurementIntervalOnAlert;
	WPFM_settingParameter.communicationIntervalOnAlert = config.communicationIntervalOnAlert;

	WPFM_settingParameter.sensorKinds[0] = config.sensorKinds[0];
	WPFM_settingParameter.sensorKinds[1] = config.sensorKinds[1];
	WPFM_settingParameter.upperLimits[0] = config.upperLimits[0];
	WPFM_settingParameter.upperLimits[1] = config.upperLimits[1];
	WPFM_settingParameter.lowerLimits[0] = config.lowerLimits[0];
	WPFM_settingParameter.lowerLimits[1] = config.lowerLimits[1];

	WPFM_settingParameter.alertEnableKinds[0][0][1] = config.alertEnableKinds[0][0][1];
	WPFM_settingParameter.alertEnableKinds[0][0][0] = config.alertEnableKinds[0][0][0];
	WPFM_settingParameter.alertEnableKinds[0][1][0] = config.alertEnableKinds[0][1][0];
	WPFM_settingParameter.alertEnableKinds[0][1][1] = config.alertEnableKinds[0][1][1];
	WPFM_settingParameter.alertEnableKinds[1][0][1] = config.alertEnableKinds[1][0][1];
	WPFM_settingParameter.alertEnableKinds[1][0][0] = config.alertEnableKinds[1][0][0];
	WPFM_settingParameter.alertEnableKinds[1][1][0] = config.alertEnableKinds[1][1][0];
	WPFM_settingParameter.alertEnableKinds[1][1][1] = config.alertEnableKinds[1][1][1];

	WPFM_settingParameter.alertUpperLimits[0][1] = config.alertUpperLimits[0][1];
	WPFM_settingParameter.alertUpperLimits[0][0] = config.alertUpperLimits[0][0];
	WPFM_settingParameter.alertLowerLimits[0][0] = config.alertLowerLimits[0][0];
	WPFM_settingParameter.alertLowerLimits[0][1] = config.alertLowerLimits[0][1];
	WPFM_settingParameter.alertUpperLimits[1][1] = config.alertUpperLimits[1][1];
	WPFM_settingParameter.alertUpperLimits[1][0] = config.alertUpperLimits[1][0];
	WPFM_settingParameter.alertLowerLimits[1][0] = config.alertLowerLimits[1][0];
	WPFM_settingParameter.alertLowerLimits[1][1] = config.alertLowerLimits[1][1];

	strcpy(WPFM_settingParameter.Measure_ch1, config.Measure_ch1);
	strcpy(WPFM_settingParameter.MeaKind_ch1, config.MeaKind_ch1);
	strcpy(WPFM_settingParameter.Measure_ch2, config.Measure_ch2);
	strcpy(WPFM_settingParameter.MeaKind_ch2, config.MeaKind_ch2);

	WPFM_settingParameter.alertChatteringTimes[0] = config.alertChatteringTimes[0];
	WPFM_settingParameter.alertChatteringTimes[1] = config.alertChatteringTimes[1];

	WPFM_settingParameter.alertChatteringKind = config.alertChatteringKind;
	WPFM_settingParameter.alertTimeout = config.alertTimeout;
	strcpy(WPFM_settingParameter.AlertPause, config.AlertPause);

	if (WPFM_lastAlertStatus & (MLOG_ALERT_STATUS_CH1_UPPER_WARNING|MLOG_ALERT_STATUS_CH1_LOWER_WARNING|MLOG_ALERT_STATUS_CH2_UPPER_WARNING|MLOG_ALERT_STATUS_CH2_LOWER_WARNING)) {	// アラート状態は警報?
		SENSOR_updateMeasurementInterval(WPFM_settingParameter.measurementIntervalOnAlert);
		WPFM_updateCommunicationInterval(WPFM_settingParameter.communicationIntervalOnAlert);
	} else {	// 通常
		SENSOR_updateMeasurementInterval(WPFM_settingParameter.measurementInterval);
		WPFM_updateCommunicationInterval(WPFM_settingParameter.communicationInterval);
	}
	WPFM_dumpSettingParameter(&WPFM_settingParameter);
}
void DLCMatConfigRet()
{
	char	*config_p;
	WPFM_readSettingParameter( &config );
	if (strstr(DLC_MatResBuf, "\"Change\":true")) {
putst("coco3\r\n");
#if 0
		config_p = strstr(DLC_MatResBuf, "LoggerSerialNo");
		if (config_p) {
			DLCMatINTParamSet(config_p, false);
			config.serialNumber = atoi(DLC_MatConfigItem);
//			putst("LoggerSerialNo:");puthxw(config.serialNumber);putcrlf();
		}
#endif
		config_p = strstr(DLC_MatResBuf, "Interval");
		if (config_p) {
			DLCMatINTParamSet(config_p, false);
			config.measurementInterval = atoi(DLC_MatConfigItem);
//			putst("Interval:");puthxw(config.measurementInterval);putcrlf();
		}
		config_p = strstr(DLC_MatResBuf, "ReprotInterval");
		if (config_p) {
			DLCMatINTParamSet(config_p, false);
			config.communicationInterval = atoi(DLC_MatConfigItem);
//			putst("ReprotInterval:");puthxw(config.communicationInterval);putcrlf();
		}
		config_p = strstr(DLC_MatResBuf, "IntervalAlert");
		if (config_p) {
			DLCMatINTParamSet(config_p, false);
			config.measurementIntervalOnAlert = atoi(DLC_MatConfigItem);
//			putst("IntervalAlert:");puthxw(config.measurementIntervalOnAlert);putcrlf();
		}
		config_p = strstr(DLC_MatResBuf, "ReprotIntervalAlert");
		if (config_p) {
			DLCMatINTParamSet(config_p, false);
			config.communicationIntervalOnAlert = atoi(DLC_MatConfigItem);
//			putst("ReprotIntervalAlert:");puthxw(config.communicationIntervalOnAlert);putcrlf();
		}
		config_p = strstr(DLC_MatResBuf, "Measurment");
		if (config_p) {
			DLCMatINTParamSet(config_p, false);
			config.Measurment = atoi(DLC_MatConfigItem);
//			putst("Measurment:");puthxw(config.Measurment);putcrlf();
			if (config.Measurment == 1) {
putst("coco4\r\n");
				WPFM_cancelAlert();
			}
		}
		config_p = strstr(DLC_MatResBuf, "Select_ch1");
		if (config_p) {
			DLCMatINTParamSet(config_p, false);
			config.sensorKinds[0] = atoi(DLC_MatConfigItem);
//			putst("Select_ch1:");puthxb(config.sensorKinds[0]);putcrlf();
		}
		config_p = strstr(DLC_MatResBuf, "Select_ch2");
		if (config_p) {
			DLCMatINTParamSet(config_p, false);
			config.sensorKinds[1] = atoi(DLC_MatConfigItem);
//			putst("Select_ch2:");puthxb(config.sensorKinds[1]);putcrlf();
		}
		config_p = strstr(DLC_MatResBuf, "Upper0_ch1");
		if (config_p) {
			DLCMatINTParamSet(config_p, false);
			config.upperLimits[0] = atoi(DLC_MatConfigItem);
//			putst("Upper0_ch1:");puthxb(config.upperLimits[0]);putcrlf();
		}
		config_p = strstr(DLC_MatResBuf, "Upper0_ch2");
		if (config_p) {
			DLCMatINTParamSet(config_p, false);
			config.upperLimits[1] = atoi(DLC_MatConfigItem);
//			putst("Upper0_ch2:");puthxb(config.upperLimits[1]);putcrlf();
		}
		config_p = strstr(DLC_MatResBuf, "Lower0_ch1");
		if (config_p) {
			DLCMatINTParamSet(config_p, false);
			config.lowerLimits[0] = atoi(DLC_MatConfigItem);
//			putst("Lower0_ch1:");puthxb(config.lowerLimits[0]);putcrlf();
		}
		config_p = strstr(DLC_MatResBuf, "Lower0_ch2");
		if (config_p) {
			DLCMatINTParamSet(config_p, false);
			config.lowerLimits[1] = atoi(DLC_MatConfigItem);
//			putst("Lower0_ch2:");puthxb(config.lowerLimits[1]);putcrlf();
		}
		config_p = strstr(DLC_MatResBuf, "AlertSw_U2_ch1");
		if (config_p) {
			DLCMatINTParamSet(config_p, false);
			config.alertEnableKinds[0][0][1] = atoi(DLC_MatConfigItem);
//			putst("AlertSw_U2_ch1:");puthxb(config.alertEnableKinds[0][0][1]);putcrlf();
		}
		config_p = strstr(DLC_MatResBuf, "AlertSw_U1_ch1");
		if (config_p) {
			DLCMatINTParamSet(config_p, false);
			config.alertEnableKinds[0][0][0] = atoi(DLC_MatConfigItem);
//			putst("AlertSw_U1_ch1:");puthxb(config.alertEnableKinds[0][0][0]);putcrlf();
		}
		config_p = strstr(DLC_MatResBuf, "AlertSw_L1_ch1");
		if (config_p) {
			DLCMatINTParamSet(config_p, false);
			config.alertEnableKinds[0][1][0] = atoi(DLC_MatConfigItem);
//			putst("AlertSw_L1_ch1:");puthxb(config.alertEnableKinds[0][1][0]);putcrlf();
		}
		config_p = strstr(DLC_MatResBuf, "AlertSw_L2_ch1");
		if (config_p) {
			DLCMatINTParamSet(config_p, false);
			config.alertEnableKinds[0][1][1] = atoi(DLC_MatConfigItem);
//			putst("AlertSw_L2_ch1:");puthxb(config.alertEnableKinds[0][1][1]);putcrlf();
		}
		config_p = strstr(DLC_MatResBuf, "AlertSw_U2_ch2");
		if (config_p) {
			DLCMatINTParamSet(config_p, false);
			config.alertEnableKinds[1][0][1] = atoi(DLC_MatConfigItem);
//			putst("AlertSw_U2_ch2:");puthxb(config.alertEnableKinds[1][0][1]);putcrlf();
		}
		config_p = strstr(DLC_MatResBuf, "AlertSw_U1_ch2");
		if (config_p) {
			DLCMatINTParamSet(config_p, false);
			config.alertEnableKinds[1][0][0] = atoi(DLC_MatConfigItem);
//			putst("AlertSw_U1_ch2:");puthxb(config.alertEnableKinds[1][0][0]);putcrlf();
		}
		config_p = strstr(DLC_MatResBuf, "AlertSw_L1_ch2");
		if (config_p) {
			DLCMatINTParamSet(config_p, false);
			config.alertEnableKinds[1][1][0] = atoi(DLC_MatConfigItem);
//			putst("AlertSw_L1_ch2:");puthxb(config.alertEnableKinds[1][1][0]);putcrlf();
		}
		config_p = strstr(DLC_MatResBuf, "AlertSw_L2_ch2");
		if (config_p) {
			DLCMatINTParamSet(config_p, false);
			config.alertEnableKinds[1][1][1] = atoi(DLC_MatConfigItem);
//			putst("AlertSw_L2_ch2:");puthxb(config.alertEnableKinds[1][1][1]);putcrlf();
		}
		config_p = strstr(DLC_MatResBuf, "Upper2_ch1");
		if (config_p) {
			DLCMatINTParamSet(config_p, false);
			config.alertUpperLimits[0][1] = atof(DLC_MatConfigItem);
//			putst("Upper2_ch1:");puthxs(config.alertUpperLimits[0][1]);putcrlf();
		}
		config_p = strstr(DLC_MatResBuf, "Upper1_ch1");
		if (config_p) {
			DLCMatINTParamSet(config_p, false);
			config.alertUpperLimits[0][0] = atof(DLC_MatConfigItem);
//			putst("Upper1_ch1:");puthxs(config.alertUpperLimits[0][0]);putcrlf();
		}
		config_p = strstr(DLC_MatResBuf, "Lower1_ch1");
		if (config_p) {
			DLCMatINTParamSet(config_p, false);
			config.alertLowerLimits[0][0] = atof(DLC_MatConfigItem);
//			putst("Lower1_ch1:");puthxs(config.alertLowerLimits[0][0]);putcrlf();
		}
		config_p = strstr(DLC_MatResBuf, "Lower2_ch1");
		if (config_p) {
			DLCMatINTParamSet(config_p, false);
			config.alertLowerLimits[0][1] = atof(DLC_MatConfigItem);
//			putst("Lower2_ch1:");puthxs(config.alertLowerLimits[0][1]);putcrlf();
		}
		config_p = strstr(DLC_MatResBuf, "Upper2_ch2");
		if (config_p) {
			DLCMatINTParamSet(config_p, false);
			config.alertUpperLimits[1][1] = atof(DLC_MatConfigItem);
//			putst("Upper2_ch2:");puthxs(config.alertUpperLimits[1][1]);putcrlf();
		}
		config_p = strstr(DLC_MatResBuf, "Upper1_ch2");
		if (config_p) {
			DLCMatINTParamSet(config_p, false);
			config.alertUpperLimits[1][0] = atof(DLC_MatConfigItem);
//			putst("Upper1_ch2:");puthxs(config.alertUpperLimits[1][0]);putcrlf();
		}
		config_p = strstr(DLC_MatResBuf, "Lower1_ch2");
		if (config_p) {
			DLCMatINTParamSet(config_p, false);
			config.alertLowerLimits[1][0] = atof(DLC_MatConfigItem);
//			putst("Lower1_ch2:");puthxs(config.alertLowerLimits[1][0]);putcrlf();
		}
		config_p = strstr(DLC_MatResBuf, "Lower2_ch2");
		if (config_p) {
			DLCMatINTParamSet(config_p, false);
			config.alertLowerLimits[1][1] = atof(DLC_MatConfigItem);
//			putst("Lower2_ch2:");puthxs(config.alertLowerLimits[1][1]);putcrlf();
		}
		config_p = strstr(DLC_MatResBuf, "Measure_ch1");
		if (config_p) {
			DLCMatSTRParamSet(config_p);
			strcpy(config.Measure_ch1, DLC_MatConfigItem);
//			putst("Measure_ch1:");putst(config.Measure_ch1);putcrlf();
		}
		config_p = strstr(DLC_MatResBuf, "MeaKind_ch1");
		if (config_p) {
			DLCMatSTRParamSet(config_p);
			strcpy(config.MeaKind_ch1, DLC_MatConfigItem);
//			putst("MeaKind_ch1:");putst(config.MeaKind_ch1);putcrlf();
		}
		config_p = strstr(DLC_MatResBuf, "Chattering_ch1");
		if (config_p) {
			DLCMatINTParamSet(config_p, false);
			config.alertChatteringTimes[0] = atoi(DLC_MatConfigItem);
//			putst("Chattering_ch1:");puthxb(config.alertChatteringTimes[0]);putcrlf();
		}
		config_p = strstr(DLC_MatResBuf, "Measure_ch2");
		if (config_p) {
			DLCMatSTRParamSet(config_p);
			strcpy(config.Measure_ch2, DLC_MatConfigItem);
//			putst("Measure_ch2:");putst(config.Measure_ch2);putcrlf();
		}
		config_p = strstr(DLC_MatResBuf, "MeaKind_ch2");
		if (config_p) {
			DLCMatSTRParamSet(config_p);
			strcpy(config.MeaKind_ch2, DLC_MatConfigItem);
//			putst("MeaKind_ch2:");putst(config.MeaKind_ch2);putcrlf();
		}
		config_p = strstr(DLC_MatResBuf, "Chattering_ch2");
		if (config_p) {
			DLCMatINTParamSet(config_p, false);
			config.alertChatteringTimes[1] = atoi(DLC_MatConfigItem);
//			putst("Chattering_ch2:");puthxb(config.alertChatteringTimes[1]);putcrlf();
		}
		config_p = strstr(DLC_MatResBuf, "Chattering_type");
		if (config_p) {
			DLCMatINTParamSet(config_p, false);
			config.alertChatteringKind = atoi(DLC_MatConfigItem);
//			putst("Chattering_type:");puthxb(config.alertChatteringKind);putcrlf();
		}
		config_p = strstr(DLC_MatResBuf, "AlertPause");
		if (config_p) {
			DLCMatSTRParamSet(config_p);
			strcpy(config.AlertPause, DLC_MatConfigItem);
//			putst("AlertPause:");putst(config.AlertPause);putcrlf();
		}
		config_p = strstr(DLC_MatResBuf, "AlertTimeOut");
		if (config_p) {
			DLCMatINTParamSet(config_p, true);
			config.alertTimeout = atoi(DLC_MatConfigItem);
//			putst("AlertTimeOut:");puthxb(config.alertTimeout);putcrlf();
		}
		WPFM_writeSettingParameter( &config );
		DLCMatReflectionConfig();
	}
}
int DLCMatRecvDisp()
{
	char	*p,*q,n;
	int		i,j=0,k;
	if(( p = strstr( (char*)DLC_MatLineBuf,"$RECVDATA:" )) > 0 ){
		p = str2int( &p[10],&i );										/* $RECVDATA,i,j,"...."<cr> */
		if( p < 0 ){													/* p            q  */
			putst( "format err2\r\n" );
			return -2;
		}
		p = str2int( p,&j );
		if( p < 0 ){
			putst( "format err3\r\n" );
			return -3;
		}
		putst("Ln=");puthxs(i);putst(" Rm=");puthxs(j);putcrlf();
		p = strchr( p,'\"' );
		if( p > 0 ){
			p++;
			q = strchr( p,'\"' );
			putst("1024=");puthxs(q-p);putcrlf();
			for( k=0;k<i;k++ ){
				n = inhex( *p++ )<<4;
				n += inhex( *p++ );
				DLC_MatResBuf[DLC_MatResIdx++] = n;
			}
//			if( strstr( DLC_MatResBuf,"HTTP/1.1 200 OK" )){
//				if( strstr( DLC_MatResBuf,"Connection: close" ))
//					return 0;
//			}
			if( j == 0 ){
				DLC_MatResBuf[DLC_MatResIdx] = 0;
				putst( DLC_MatResBuf );
				DLC_MatResIdx = 0;
putst("\r\ncoco1\r\n");
				if (strstr(DLC_MatResBuf,"ConfigRet")) {
putst("coco2\r\n");
					DLCMatConfigRet();
				}
// fota				if( strstr( DLC_MatResBuf,"Status" )){
// fota					if (strstr(DLC_MatResBuf, "\"LTEVersion\":")) {	// fota StatusでF/W version指定されたらFOTA起動?
// fota						DLC_MatFotaExe = true;
// fota						// フラグを維持したまま再起動したい
// fota					}
// fota				}
			}
			else {
//				strcpy( &DLC_MatResBuf[DLC_MatResIdx],"★" );
//				DLC_MatResIdx += 2;
			}
			return j;
		}
		else {
			putst("format err4\r\n");
			return -4;
		}
	}
	else
		putst("format err1\r\n");
	return -1;
}
int DLCMatRecvWriteFota()	// fota SPIへ受信データ書込み処理
{
	char	*p,*q,*fpt,n;
	int		i,j=0,k,len;
	int		fotaaddress=DLC_MatSPIFlashAddrFota;	/* FOTAデータ保存番地 */
	if(( p = strstr( (char*)DLC_MatLineBuf,"$RECVDATA:" )) > 0 ){
		p = str2int( &p[10],&i );										/* $RECVDATA,i,j,"...."<cr> */
		if( p < 0 ){													/* p            q  */
			putst( "format err2\r\n" );
			return -2;
		}
		p = str2int( p,&j );
		if( p < 0 ){
			putst( "format err3\r\n" );
			return -3;
		}
		putst("Ln=");puthxs(i);putst(" Rm=");puthxs(j);putcrlf();
		p = strchr( p,'\"' );
		if( p > 0 ){
			p++;
			q = strchr( p,'\"' );
			putst("1024=");puthxs(q-p);putcrlf();
//			if ((q-p) != (i*2)) {
//				Dump((char *)DLC_MatLineBuf,1128);putcrlf();
//			}
			memset(DLC_MatResBuf, 0xFF, sizeof(DLC_MatResBuf));	/* 受信バッファFF初期化 */
			for( k=0;k<i;k++ ){
				n = inhex( *p++ )<<4;
				n += inhex( *p++ );
				DLC_MatResBuf[DLC_MatResIdx++] = n;
			}
//			DLC_MatResBuf[DLC_MatResIdx] = 0;
//			putst( DLC_MatResBuf );
			DLC_MatResIdx = 0;
			if (strstr(DLC_MatResBuf,"Connection: close") == NULL) {	/* ヘッダにConnection: closeなし=先頭以降の受信データ */
				fpt = DLC_MatResBuf;		/* 受信バッファの先頭アドレス */
				len = DLC_MatSPIRemaindataFota;	/* 半端byteのレングス */
//				if (j > 0) {	/* Rmが0でもそれは最終データではない */
				if (1) {
					putst("RecvData1:\r\n");
//					Dump(DLC_MatResBuf,i);putcrlf();
					fotaaddress /= DLC_MatSPIFlashPage;
					if (DLC_MatSPIRemaindataFota != 0) {	/* 半端byteありの場合 */
						memcpy(&DLC_MatSPIRemainbufFota[DLC_MatSPIRemaindataFota], fpt ,sizeof(DLC_MatSPIRemainbufFota) - DLC_MatSPIRemaindataFota);	/* 今回受信データで256byte埋めて */
						if (W25Q128JV_programPage(fotaaddress + DLC_MatSPIWritePageFota, 0, (uint8_t*)DLC_MatSPIRemainbufFota, DLC_MatSPIFlashPage, true) == W25Q128JV_ERR_NONE ){	/* 256byte書込む */
							puthxw(DLC_MatSPIFlashPage * (fotaaddress + DLC_MatSPIWritePageFota));
							putst("_R:OK");putcrlf();
							memset(DLC_MatSPICheckbufFota, 0xFF, sizeof(DLC_MatSPICheckbufFota));
							if (W25Q128JV_readData(DLC_MatSPIFlashPage * (fotaaddress + DLC_MatSPIWritePageFota), (uint8_t*)DLC_MatSPICheckbufFota, DLC_MatSPIFlashPage) == W25Q128JV_ERR_NONE) {
								if (memcmp(DLC_MatSPICheckbufFota, DLC_MatSPIRemainbufFota, DLC_MatSPIFlashPage) == 0) {
									putst("VERFY OK\r\n");
								} else {
									DLC_MatFotaWriteNG = true;
									putst("VERFY NG\r\n");
								}
							} else {
								DLC_MatFotaWriteNG = true;
								putst("READ NG\r\n");
							}
						} else {
							DLC_MatFotaWriteNG = true;
							putst("PROG NG\r\n");
						}
						fpt = &DLC_MatResBuf[sizeof(DLC_MatSPIRemainbufFota) - DLC_MatSPIRemaindataFota];	/* 書込みアドレス進める */
						DLC_MatSPIWritePageFota += 1;	/* 書込みページインデックス進める */
//						putst("BufData1:\r\n");Dump(DLC_MatSPIRemainbufFota, sizeof(DLC_MatSPIRemainbufFota));putcrlf();
					}
					for (k = 0; k < ((0x400 - len) / DLC_MatSPIFlashPage); k++) {	/* 残りのデータを256byte毎書込み */
						if (W25Q128JV_programPage(fotaaddress + k + DLC_MatSPIWritePageFota, 0, (uint8_t*)(fpt + DLC_MatSPIFlashPage * k), DLC_MatSPIFlashPage, true) == W25Q128JV_ERR_NONE ){
							puthxw(DLC_MatSPIFlashPage * (fotaaddress + k + DLC_MatSPIWritePageFota));
							putst(":OK");putcrlf();
							memset(DLC_MatSPICheckbufFota, 0xFF, sizeof(DLC_MatSPICheckbufFota));
							if (W25Q128JV_readData(DLC_MatSPIFlashPage * (fotaaddress + k + DLC_MatSPIWritePageFota), (uint8_t*)DLC_MatSPICheckbufFota, DLC_MatSPIFlashPage) == W25Q128JV_ERR_NONE) {
								if (memcmp(DLC_MatSPICheckbufFota, (fpt + DLC_MatSPIFlashPage * k), DLC_MatSPIFlashPage) == 0) {
									putst("VERFY OK\r\n");
								} else {
									DLC_MatFotaWriteNG = true;
									putst("VERFY NG\r\n");
								}
							} else {
								DLC_MatFotaWriteNG = true;
								putst("READ NG\r\n");
							}
						} else {
							DLC_MatFotaWriteNG = true;
							putst("PROG NG\r\n");
						}
					}
					memset(DLC_MatSPIRemainbufFota, 0xFF, sizeof(DLC_MatSPIRemainbufFota));	/* 半端byte保持バッファFF初期化 */
					DLC_MatSPIRemaindataFota = (0x400 - (DLC_MatSPIFlashPage - len)) - (DLC_MatSPIFlashPage * k);	/* 1ページ未満の半端byte数 */
//					putst("DLC_MatSPIRemaindataFota1:");puthxs(DLC_MatSPIRemaindataFota);putcrlf();
					memcpy(DLC_MatSPIRemainbufFota, fpt + DLC_MatSPIFlashPage * k ,DLC_MatSPIRemaindataFota);	/* 半端byte保持バッファに保持 */
					DLC_MatSPIWritePageFota = k + DLC_MatSPIWritePageFota;	/* SPI書込みページインデックス保持 */
//					putst("RemainData1:\r\n");Dump(DLC_MatSPIRemainbufFota, sizeof(DLC_MatSPIRemainbufFota));putcrlf();
				} else {
					putst("RecvData2:\r\n");
//					Dump(DLC_MatResBuf,i);putcrlf();
					fotaaddress /= DLC_MatSPIFlashPage;
					if (DLC_MatSPIRemaindataFota != 0) {	/* 半端byteありの場合 */
						memcpy(&DLC_MatSPIRemainbufFota[DLC_MatSPIRemaindataFota], fpt ,sizeof(DLC_MatSPIRemainbufFota) - DLC_MatSPIRemaindataFota);	/* 今回受信データで256byte埋めて */
						if (W25Q128JV_programPage(fotaaddress + DLC_MatSPIWritePageFota, 0, (uint8_t*)DLC_MatSPIRemainbufFota, DLC_MatSPIFlashPage, true) == W25Q128JV_ERR_NONE ){	/* 256byte書込む */
							puthxw(DLC_MatSPIFlashPage * (fotaaddress + DLC_MatSPIWritePageFota));
							putst("_R:OK");putcrlf();
							memset(DLC_MatSPICheckbufFota, 0xFF, sizeof(DLC_MatSPICheckbufFota));
							if (W25Q128JV_readData(DLC_MatSPIFlashPage * (fotaaddress + DLC_MatSPIWritePageFota), (uint8_t*)DLC_MatSPICheckbufFota, DLC_MatSPIFlashPage) == W25Q128JV_ERR_NONE) {
								if (memcmp(DLC_MatSPICheckbufFota, DLC_MatSPIRemainbufFota, DLC_MatSPIFlashPage) == 0) {
									putst("VERFY OK\r\n");
								} else {
									DLC_MatFotaWriteNG = true;
									putst("VERFY NG\r\n");
								}
							} else {
								DLC_MatFotaWriteNG = true;
								putst("READ NG\r\n");
							}
						} else {
							DLC_MatFotaWriteNG = true;
							putst("PROG NG\r\n");
						}
						fpt = &DLC_MatResBuf[sizeof(DLC_MatSPIRemainbufFota) - DLC_MatSPIRemaindataFota];	/* 書込みアドレス進める */
						DLC_MatSPIWritePageFota += 1;	/* 書込みページインデックス進める */
//						putst("BufData2:\r\n");Dump(DLC_MatSPIRemainbufFota, sizeof(DLC_MatSPIRemainbufFota));putcrlf();
					}
					for (k = 0; k <= ((i - (DLC_MatSPIFlashPage - len)) / DLC_MatSPIFlashPage); k++) {	/* 残りのデータを256byte毎書込み */
						if (W25Q128JV_programPage(fotaaddress + k + DLC_MatSPIWritePageFota, 0, (uint8_t*)(fpt + DLC_MatSPIFlashPage * k), DLC_MatSPIFlashPage, true) == W25Q128JV_ERR_NONE ){
							puthxw(DLC_MatSPIFlashPage * (fotaaddress + k + DLC_MatSPIWritePageFota));
							putst(":OK");putcrlf();
							memset(DLC_MatSPICheckbufFota, 0xFF, sizeof(DLC_MatSPICheckbufFota));
							if (W25Q128JV_readData(DLC_MatSPIFlashPage * (fotaaddress + k + DLC_MatSPIWritePageFota), (uint8_t*)DLC_MatSPICheckbufFota, DLC_MatSPIFlashPage) == W25Q128JV_ERR_NONE) {
								if (memcmp(DLC_MatSPICheckbufFota, (fpt + DLC_MatSPIFlashPage * k), DLC_MatSPIFlashPage) == 0) {
									putst("VERFY OK\r\n");
								} else {
									DLC_MatFotaWriteNG = true;
									putst("VERFY NG\r\n");
								}
							} else {
								DLC_MatFotaWriteNG = true;
								putst("READ NG\r\n");
							}
						} else {
							DLC_MatFotaWriteNG = true;
							putst("PROG NG\r\n");
						}
					}
					if (DLC_MatFotaWriteNG == false) {	/* 書込みNGなし */
						DLCMatTimerClr( 0 );	/* タイマークリア */
					}
				}
			} else {	/* ヘッダにConnection: closeあり=受信データ先頭 */
				for (k = 0; k < 4; k++) {	/* SPI 256kbyte消去 */
					char line[32];
					W25Q128JV_eraseBlock64(((fotaaddress / 0x10000) + k), true);	/* 現状address:0～ 1ブロック64kbyte*/
					sprintf( line, "%02X0000:ERASE OK\r\n",(unsigned int)((fotaaddress / 0x10000) + k) );
					putst( line );
				}
				memset(DLC_MatSPIRemainbufFota, 0xFF, sizeof(DLC_MatSPIRemainbufFota));	/* 1ページ未満の半端byte保持バッファFF初期化 */
				DLC_MatSPIRemaindataFota = 0;
				fpt = strstr(DLC_MatResBuf,"Connection: close") + strlen("Connection: close\r\n\r\n");	/* FOTAデータの先頭アドレス */
				*(fpt - 1) = 0;	// strlenのため
				len = strlen(DLC_MatResBuf) + 1;	/* ヘッダのレングス */
				if (j > 0) {	/* データが1024byte以上の場合 */
					putst("RecvData3:\r\n");
//					Dump(fpt, 0x400 - len);putcrlf();
					fotaaddress /= DLC_MatSPIFlashPage;
					for (k = 0; k < ((0x400 - len) / DLC_MatSPIFlashPage); k++) {	/* ヘッダを抜いたFOTAデータを256byte毎書込み */
						if (W25Q128JV_programPage(fotaaddress + k, 0, (uint8_t*)(fpt + DLC_MatSPIFlashPage * k), DLC_MatSPIFlashPage, true) == W25Q128JV_ERR_NONE ){
							puthxw(DLC_MatSPIFlashPage * (fotaaddress + k));
							putst(":OK");putcrlf();
							memset(DLC_MatSPICheckbufFota, 0, sizeof(DLC_MatSPICheckbufFota));
							if (W25Q128JV_readData(DLC_MatSPIFlashPage * (fotaaddress + k), (uint8_t*)DLC_MatSPICheckbufFota, DLC_MatSPIFlashPage) == W25Q128JV_ERR_NONE) {
								if (memcmp(DLC_MatSPICheckbufFota, (fpt + DLC_MatSPIFlashPage * k), DLC_MatSPIFlashPage) == 0) {
									putst("VERFY OK\r\n");
								} else {
									DLC_MatFotaWriteNG = true;
									putst("VERFY NG\r\n");
								}
							} else {
								DLC_MatFotaWriteNG = true;
								putst("READ NG\r\n");
							}
						} else {
							DLC_MatFotaWriteNG = true;
							putst("PROG NG\r\n");
						}
					}
					memset(DLC_MatSPIRemainbufFota, 0xFF, sizeof(DLC_MatSPIRemainbufFota));	/* 半端byte保持バッファFF初期化 */
					DLC_MatSPIRemaindataFota = (0x400 - len) - (DLC_MatSPIFlashPage * k);	/* 1ページ未満の半端byte数 */
//					putst("DLC_MatSPIRemaindataFota3:");puthxs(DLC_MatSPIRemaindataFota);putcrlf();
					memcpy(DLC_MatSPIRemainbufFota, fpt + DLC_MatSPIFlashPage * k ,DLC_MatSPIRemaindataFota);	/* 半端byte保持バッファに保持 */
					DLC_MatSPIWritePageFota = k;	/* SPI書込みページインデックス保持 */
//					putst("RemainData3:\r\n");Dump(DLC_MatSPIRemainbufFota, sizeof(DLC_MatSPIRemainbufFota));putcrlf();
				} else {	/* データが1024byte未満の場合(現状ありえない) */
					putst("RecvData4:\r\n");
//					Dump(fpt, i - len);putcrlf();
					fotaaddress /= DLC_MatSPIFlashPage;
					for (k = 0; k <= ((i - len) / DLC_MatSPIFlashPage); k++) {
						if (W25Q128JV_programPage(fotaaddress + k, 0, (uint8_t*)(fpt + DLC_MatSPIFlashPage * k), DLC_MatSPIFlashPage, true) == W25Q128JV_ERR_NONE ){
							puthxw(DLC_MatSPIFlashPage * (fotaaddress + k));
							putst(":OK");putcrlf();
							memset(DLC_MatSPICheckbufFota, 0xFF, sizeof(DLC_MatSPICheckbufFota));
							if (W25Q128JV_readData(DLC_MatSPIFlashPage * (fotaaddress + k), (uint8_t*)DLC_MatSPICheckbufFota, DLC_MatSPIFlashPage) == W25Q128JV_ERR_NONE) {
								if (memcmp(DLC_MatSPICheckbufFota, (fpt + DLC_MatSPIFlashPage * k), DLC_MatSPIFlashPage) == 0) {
									putst("VERFY OK\r\n");
								} else {
									DLC_MatFotaWriteNG = true;
									putst("VERFY NG\r\n");
								}
							} else {
								DLC_MatFotaWriteNG = true;
								putst("READ NG\r\n");
							}
						} else {
							DLC_MatFotaWriteNG = true;
							putst("PROG NG\r\n");
						}
					}
					if (DLC_MatFotaWriteNG == false) {	/* 書込みNGなし */
						DLCMatTimerClr( 0 );	/* タイマークリア */
					}
				}
			}
			DLC_MatResIdx = 0;
			return j;
		}
		else {
			putst("format err4\r\n");
			return -4;
		}
	}
	else
		putst("format err1\r\n");
	return -1;
}
void DLCSPIFlashTest()
{
	int		rt,k;
	char    key;
	while(1){
		uint8_t DmyData[256],Data[256];
		int	address;
		for( int i=0;i<256;i++ )
			DmyData[i] = i;
		putst("\r\nW:write R:read E:erase=>");
		key = toupper(getch());
		putst("\r\nAddress=>");address = c_get32b();
		switch( key ){
		case 'W':
			if( address == -1 ){
				for( int j=0;j<0x1000;j++ ){
					if( W25Q128JV_eraseSctor( j,true ) == W25Q128JV_ERR_NONE ){
						char line[20];
						putst("ERASE OK");putcrlf();
						sprintf(line, "%03X", (unsigned int)j);
						putst(line);putcrlf();
						APP_delay(300);
						address = (j << 4);								/* 0,0x10,0x20,0x30... */
						for( int i=0;i<16;i++ ){
							if( W25Q128JV_programPage( address++,(uint8_t)0,DmyData,(uint16_t)sizeof(DmyData),true ) == W25Q128JV_ERR_NONE ){
								putst( "PROG. OK\r\n" );
								sprintf( line, "%04X\r\n",(unsigned int)address );
								putst( line );
							}
							else
							    putst("PAGE NG\r\n");
						}
					}
					else {
						putst("ERASE NG\r\n");
					}
				}
			}
			else {
				address /= 0x100;
				for( int i=0;i<16;i++ ){
					if( W25Q128JV_programPage( address+i,0,(uint8_t*)DmyData,(uint16_t)sizeof(DmyData),true )== W25Q128JV_ERR_NONE ){
						char line[20];
						putst( "PROG. OK\r\n" );
						sprintf( line, "%04X\r\n",(unsigned int)address+i );
						putst( line );
					}
					else
						putst("PAGE NG\r\n");
				}
			}
			break;
		case 'R':
			if( address == -1 ){
			    for (int k=0; k<0x10000;k++){				/* 65万セクタ(256) */
					uint32_t addr = ((uint32_t)k << 8);
					if (W25Q128JV_readData(addr, Data, (uint16_t)sizeof(Data)) == W25Q128JV_ERR_NONE){
#if 0
						puthxw( addr );putcrlf();
						Dump( (char*)Data,sizeof( Data ) );
#else
						if( memcmp( Data,DmyData,sizeof( Data )) ){
							putst("Find NG=>");puthxw( addr );putcrlf();break;
						}
						else{
							puthxw( addr );putcrlf();
						}
#endif
					}
					else{
						putst("Read NG ");puthxw( addr );putcrlf();
					}
					APP_delay(2);
				}
			}
			else {
				rt = W25Q128JV_readDataFaster( address,(uint8_t*)DmyData, sizeof( DmyData ));
				if( !rt ){
					putcrlf();Dump( (char*)DmyData,sizeof( DmyData ) );
				}
				else {
					puthxb( rt );putcrlf();
				}
			}
			break;
		case 'E':
			if( address == -1 ){
	  			rt = W25Q128JV_eraseChip(true);
				if( !rt ){
					putst("OK\r\n");
				}
				else {
					puthxb( rt );putcrlf();
				}
			}
			else {
				rt = W25Q128JV_eraseSctor(address/0x1000, true);
				if( !rt ){
					putst("OK\r\n");
				}
				else {
					puthxb( rt );putcrlf();
				}
			}
			break;
		case 'B':
			for (k = 0; k < 4; k++) {	/* 指定アドレス～3ブロック消去 */
				char line[20];
				W25Q128JV_eraseBlock64(((address / 0x10000) + k), true);
				sprintf( line, "%X:ERASE OK\r\n",(unsigned int)((address / 0x10000) + k) );
				putst( line );
			}
			break;
		case 'A':
  			rt = W25Q128JV_eraseChip(true);
			if( !rt ){
				putst("OK\r\n");
			}
			else {
				puthxb( rt );putcrlf();
			}
			break;
		case 0x03:
		case 0x1b:
			return;
		}
		putst("\r\nSPI>");
	}
}
int CheckPasswd()
{
	putst("PASSWD=");
	if( getch() == 'y')
		if( getch() == 'e')
			if( getch() == 's')
				return 1;
	return 0;
}
void DLCRomTest()
{
	char	key,buff[256];
	int		address=0;
	while(1){
		key = toupper( getch() );
		switch( key ){
		case 'W':
			NVMCTRL_PageWrite( (uint32_t *)buff,address );
			break;
	    case 'E':
			NVMCTRL_RowErase( address );
			break;
		case 'F':
			putst("Fill char=>");
			key = getch();
			memset( buff,key,sizeof( buff ));
			putst("\r\n");
			Dump( (char*)buff,sizeof( buff ) );
			break;
		case 'R':
			address+=0x100;
			putch('@');puthxw( address );putcrlf();
			NVMCTRL_Read( (uint32_t *)buff,sizeof( buff ),address );
			putcrlf();
			Dump( buff,sizeof( buff ) );
			break;
		case 'A':
			putst("Read mem Address=>" );
			address = c_get32b();
			break;
		case 0x1b:
		case 0x03:
			return;
	 	}
		putst("\r\nROM>");
	}
}
void DLCMatBypass()
{
	while(1){
		uint8_t c;
		if( SERCOM0_USART_Read( &c, 1 )){				/* UARTから入力 */
			if( c == 0x03 || c == 0x1b )				/* ESC/CTRL-Cでexit */
				return;
			SERCOM0_USART_Read( &c, 1 );
			SERCOM5_USART_Write( &c, 1 );				/* MATcoreに出力 */
		}
		APP_delay(10);
		if( SERCOM5_USART_Read( &c, 1 )){				/* MATcoreから入力 */
			SERCOM0_USART_Write( &c, 1 );				/* UARTへ出力 */
			if( c == '\r' ){
				c = '\n';
				SERCOM0_USART_Write( &c, 1 );			/* UARTへ出力 */
			}
		}
		APP_delay(10);
	}
}
void DLCMatTest()
{
	static uchar DLC_MatSleep;
	char    key;
	while(1){
		putst("\r\nCore>");
		key = toupper( getch() );
		switch( key ){
		case 'A':
			DLCMatSend( "AT$SETAPN,soracom.io,sora,sora,CHAP\r" );
			break;
		case 'B':
			putst("UART<=>MATcore MODE!\r\n");
			DLCMatBypass();
			break;
		case 'C':
			DLCMatSend( "AT$CONNECT\r" );
			break;
		case 'D':
			DLCMatSend( "AT$DISCONNECT\r" );
			break;
		case 'L':
			DLCMatSend( "AT$CLOSE\r" );
			break;
		case  'M':
			putst("Msg=");
			MatMsgSend( c_get32b() );
			break;
		case 'N':
			DLCMatSend( "AT$NUM\r" );
			DLCMatSend( "AT$IMEI\r" );
			DLCMatSend( "AT$TIME\r" );
			break;
		case 'R':
			DLCMatSend( "AT$RSRP\r" );
			DLCMatSend( "AT$RSRQ\r" );
			DLCMatSend( "AT$RSSI\r" );
			DLCMatSend( "AT$SINR\r" );
			break;
		case 'O':
			DLCMatSend( "AT$OPEN\r" );
			break;
		case 'S':
			DLCMatSend( "AT$SETSERVER,karugamosoft.ddo.jp,9999\r" );
			break;
		case 'T':
			DLCMatSend( "AT$SETSERVER,beam.soracom.io,8888\r" );
			break;
		case 'U':
#if 1
			DLCMatPostConfig();
#else
			DLCMatSend( "AT$SEND,\"414243\"\r" );
#endif
			break;
		case 'V':
			DLCMatSend( "AT$RECV,1024\r" );
			break;
		case ' ':
			putst("Stat=");puthxb( DLC_MatState );putcrlf();
			Dump( (char*)DLC_MatLineBuf,64 );
			putst("idx=");puthxb( DLC_MatLineIdx );putcrlf();
			break;
		case '#':
			if( zLogOn ^= 1 )
				putst("LogOn\r\n");
			else
				putst("LogOff\r\n");
			break;
		case '$':
			memset( DLC_MatLineBuf,0,sizeof(DLC_MatLineBuf));
			DLC_MatLineIdx = 0;
			break;
		case '&':
			DLC_MatState = 100;
			break;
		case '!':
			if( DLC_MatSleep ^= 1 )
				PORT_GroupWrite( PORT_GROUP_1,0x1<<10,0 );
			else
				PORT_GroupWrite( PORT_GROUP_1,0x1<<10,-1 );
			break;
		case 0x03:
		case 0x1b:
			return;
		}
	}
}
void MATRts()
{
	if( PORT_GroupRead( PORT_GROUP_1 )&(0x1<<22))
		putch('@');
}
void command_software_reset(uchar);
void DLCMatMain()
{
	char key;
	char *VerPrint();
	RTC_DATETIME dt;
	char time[32],tmp[3] = {0, 0, 0};
	uint8_t ap_year, ap_month, ap_day, ap_hour, ap_minute, ap_second;
//	PORT_GroupWrite( PORT_GROUP_1,0x1<<22,0 );
	if( DLC_BigState == 0 ){
		putst( VerPrint() );
		putst( "\r\nMATcore Task Started.\r\n" );
		DLCMatInit();
		DLC_BigState = 1;
	}
	key = getkey();
	if( key ){
		key = toupper(key);
		switch( key ){
		case 0x1b:
			Moni();
			break;
		case 'M':
			if( CheckPasswd() )
				DLCMatTest();
			break;
		case 'I':
			putst("Read IO(1-7)=>");
			key = getch()-'1';
			putcrlf();puthxb(GPIOEXP_get(key));
			break;
		case 'L':
			putst("LED(1-3)=>");
			key = getch()-'1';
			putst("1:On 2:Off 3:Blink=>");
			switch( getch() ){
			case '1':
				GPIOEXP_clear(key);
				break;
			case '2':
				DLC_MatLedTest &= ~(1<<key);
				DLC_MatLedTest &= ~(1<<(key+4));
				GPIOEXP_set(key);
				break;
			case '3':
				DLC_MatLedTest |= (1<<key);
				DLC_MatLedTest |= (1<<(key+4));
				DLCMatTimerset( 1,500 );
				GPIOEXP_set(key);
				break;
			}
			break;
		case 'O':
			putst("\r\nNum=>");
			PORT_GroupWrite( PORT_GROUP_1,0x1<<c_get32b(),0 );
			break;
		case 'U':
			putst("\r\nNum=>");
			PORT_GroupWrite( PORT_GROUP_1,0x1<<c_get32b(),-1 );
			break;
		case 'Y':
			putcrlf();putst("inPORT_GROUP0:1=");
			puthxw( PORT_GroupRead( PORT_GROUP_0 ));putch(':');
			puthxw( PORT_GroupRead( PORT_GROUP_1 ));
			break;
		case 'E':												/* 強制本プロ削除 */
			if( CheckPasswd() ){
				NVMCTRL_RowErase( 0x8000 );
			}
			break;
		case 'F':
			if( CheckPasswd() )
				DLCSPIFlashTest();
			break;
		case 'W':
			if( CheckPasswd() )
				DLCMatConfigDefault();
			break;
		case 'R':
			if( CheckPasswd() )
				DLCRomTest();
			break;
		case 'C':
			WPFM_readSettingParameter( &config );
			putcrlf();
			putst("LoggerSerialNo:");puthxw(config.serialNumber);putcrlf();
			putst("Interval:");puthxw(config.measurementInterval);putcrlf();
			putst("ReprotInterval:");puthxw(config.communicationInterval);putcrlf();
			putst("IntervalAlert:");puthxw(config.measurementIntervalOnAlert);putcrlf();
			putst("ReprotIntervalAlert:");puthxw(config.communicationIntervalOnAlert);putcrlf();
			putst("Measurment:");puthxw(config.Measurment);putcrlf();
			putst("Select_ch1:");puthxb(config.sensorKinds[0]);putcrlf();
			putst("Select_ch2:");puthxb(config.sensorKinds[1]);putcrlf();
			putst("Upper0_ch1:");puthxb(config.upperLimits[0]);putcrlf();
			putst("Upper0_ch2:");puthxb(config.upperLimits[1]);putcrlf();
			putst("Lower0_ch1:");puthxb(config.lowerLimits[0]);putcrlf();
			putst("Lower0_ch2:");puthxb(config.lowerLimits[1]);putcrlf();
			putst("AlertSw_U2_ch1:");puthxb(config.alertEnableKinds[0][0][1]);putcrlf();
			putst("AlertSw_U1_ch1:");puthxb(config.alertEnableKinds[0][0][0]);putcrlf();
			putst("AlertSw_L1_ch1:");puthxb(config.alertEnableKinds[0][1][0]);putcrlf();
			putst("AlertSw_L2_ch1:");puthxb(config.alertEnableKinds[0][1][1]);putcrlf();
			putst("AlertSw_U2_ch2:");puthxb(config.alertEnableKinds[1][0][1]);putcrlf();
			putst("AlertSw_U1_ch2:");puthxb(config.alertEnableKinds[1][0][0]);putcrlf();
			putst("AlertSw_L1_ch2:");puthxb(config.alertEnableKinds[1][1][0]);putcrlf();
			putst("AlertSw_L2_ch2:");puthxb(config.alertEnableKinds[1][1][1]);putcrlf();
			putst("Upper2_ch1:");puthxb(config.alertUpperLimits[0][1]);putcrlf();
			putst("Upper1_ch1:");puthxb(config.alertUpperLimits[0][0]);putcrlf();
			putst("Lower1_ch1:");puthxb(config.alertLowerLimits[0][0]);putcrlf();
			putst("Lower2_ch1:");puthxb(config.alertLowerLimits[0][1]);putcrlf();
			putst("Upper2_ch2:");puthxb(config.alertUpperLimits[1][1]);putcrlf();
			putst("Upper1_ch2:");puthxb(config.alertUpperLimits[1][0]);putcrlf();
			putst("Lower1_ch2:");puthxb(config.alertLowerLimits[1][0]);putcrlf();
			putst("Lower2_ch2:");puthxb(config.alertLowerLimits[1][1]);putcrlf();
			putst("Measure_ch1:");putst(config.Measure_ch1);putcrlf();
			putst("MeaKind_ch1:");putst(config.MeaKind_ch1);putcrlf();
			putst("Chattering_ch1:");puthxb(config.alertChatteringTimes[0]);putcrlf();
			putst("Measure_ch2:");putst(config.Measure_ch2);putcrlf();
			putst("MeaKind_ch2:");putst(config.MeaKind_ch2);putcrlf();
			putst("Chattering_ch2:");puthxb(config.alertChatteringTimes[1]);putcrlf();
			putst("Chattering_type:");puthxb(config.alertChatteringKind);putcrlf();
			putst("AlertPause:");putst(config.AlertPause);putcrlf();
			putst("AlertTimeOut:");puthxb(config.alertTimeout);putcrlf();
			break;
		case 'T':
			RTC_getDatetime( &dt );
			sprintf( time,"%02d/%02d/%02d %02d:%02d:%02d",(int)dt.year,(int)dt.month,(int)dt.day,(int)dt.hour,(int)dt.minute,(int)dt.second );
			putst("\r\nCulentTime:  ");putst(time);putcrlf();
			putst("AlertPause:");putst(WPFM_settingParameter.AlertPause);putcrlf();
			tmp[0] = WPFM_settingParameter.AlertPause[0];
			tmp[1] = WPFM_settingParameter.AlertPause[1];
			ap_year = atoi(tmp);
			puthxs(ap_year);putcrlf();
			if (20 > ap_year) {
				putst("return normal1\r\n");
			} else if (20 == ap_year) {
				tmp[0] = WPFM_settingParameter.AlertPause[2];
				tmp[1] = WPFM_settingParameter.AlertPause[3];
				ap_year = atoi(tmp);
				puthxs(ap_year);putcrlf();
				if (dt.year > ap_year) {
					putst("return normal2\r\n");
				} else if (dt.year == ap_year) {
					tmp[0] = WPFM_settingParameter.AlertPause[5];
					tmp[1] = WPFM_settingParameter.AlertPause[6];
					ap_month = atoi(tmp);
					puthxs(ap_month);putcrlf();
					if (dt.month > ap_month) {
						putst("return normal3\r\n");
					} else if (dt.month == ap_month) {
						tmp[0] = WPFM_settingParameter.AlertPause[8];
						tmp[1] = WPFM_settingParameter.AlertPause[9];
						ap_day = atoi(tmp);
						puthxs(ap_day);putcrlf();
						if (dt.day > ap_day) {
							putst("return normal4\r\n");
						} else if (dt.day == ap_day) {
							tmp[0] = WPFM_settingParameter.AlertPause[11];
							tmp[1] = WPFM_settingParameter.AlertPause[12];
							ap_hour = atoi(tmp);
							puthxs(ap_hour);putcrlf();
							if (dt.hour > ap_hour) {
								putst("return normal5\r\n");
							} else if (dt.hour == ap_hour) {
								tmp[0] = WPFM_settingParameter.AlertPause[14];
								tmp[1] = WPFM_settingParameter.AlertPause[15];
								ap_minute = atoi(tmp);
								puthxs(ap_minute);putcrlf();
								if (dt.minute > ap_minute) {
									putst("return normal6\r\n");
								} else if (dt.minute == ap_minute) {
									tmp[0] = WPFM_settingParameter.AlertPause[17];
									tmp[1] = WPFM_settingParameter.AlertPause[18];
									ap_second = atoi(tmp);
									puthxs(ap_second);putcrlf();
									if (dt.second >= ap_second) {
										putst("return normal7\r\n");
									}
								}
							}
						}
					}
				}
			}
			break;
		case 0x01:												/* CTRL+A */
			if( CheckPasswd() )
				__NVIC_SystemReset();
			break;
		default:
			break;
		}
		putst("\r\nDLC>");
	}
	_GO_IDLE();
}
int DLCMatIsSleep()
{
	if( DLC_MatState == MATC_STATE_SLP )
		return 1;
	return 0;
}
void DLCMatUpdate()
{
	command_software_reset(1);
}
