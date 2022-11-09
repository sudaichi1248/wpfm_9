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
#include "DLCpara.h"
#include "Eventlog.h"
#include "version.h"
#include "FOTAcmd.h"
char *VerPrint();
void DLCMatTimerInt();
void DLCMatState();
void IDLEputch();
void command_main();
void DLC_delay(int);
//void _GO_IDLE(){command_main();DLCMatState();}
#ifdef ADD_FUNCTION
void DLCMatRtcTimeChk();
void _GO_IDLE(){DLCMatState();IDLEputch();DLCMatRtcTimeChk();}
#else
void _GO_IDLE(){DLCMatState();IDLEputch();}
#endif
void Moni();
void DLCMatConfigDefault();
void DLCMatPostConfig(),DLCMatPostStatus(),DLCMatReportSnd();
int	DLCMatPostReport();
void DLCMatTimerset(int tmid,int cnt ),DLCMatError(),DLCMatReset();
void DLCMatServerChange();
extern	char _Main_version[];
int DLCMatRecvDisp();
char 	zLogOn=1;
char	DLC_MatVer[8];
char 	DLC_MatResBuf[1050];
int	 	DLC_MatResIdx;
uchar	DLC_MatLineBuf[2100];
int		DLC_MatLineIdx;
uchar	DLC_Matfact,DLC_MatState;
char	DLC_MatDateTime[32];
char	DLC_MatRadioDensty[80];
char	DLC_MatNUM[16];
char	DLC_MatIMEI[16];
int		DLC_MatTmid;
uchar	DLC_BigState,DLC_Matknd;
uchar	DLC_MatRetry;
char	DLC_MatConfigItem[32];
uchar	DLC_MatTxType;
bool	DLC_ForcedCallOK=false;
bool	DLC_MatsendRepOK=false;

int		DLC_MatFotaTOcnt=0;	// fota  タイムアウトカウンタ
// 測定logリングバッファ試験用
int mlogdumywrite(uint32_t logtime);
uint32_t logtime;

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
#define	_DEBUG_PUTCH_SZ_MAX		0x1000
#define	_DEBUG_PUTCH_SZ_MSK		0x0FFF
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
#define		TIMER_300ms		300
#define		TIMER_1000ms	1000
#define		TIMER_3000ms	3000
#define		TIMER_5000ms	5000
#define		TIMER_7000ms	7000
#define		TIMER_12s		12000
#define		TIMER_15s		15000
#define		TIMER_30s		30000
#define		TIMER_90s		90000
#define		TIMER_NUM		8	// 0:all over timer,1:,2:push sw timer,3:retry timer,4:FOTA timer
struct {
	int		cnt;
	uchar	TO;
} DLC_MatTimer[TIMER_NUM];
#define		RTC_TIMER_NUM		5	// 0:alertTimeout,1:LED1 6s Timer
struct {
	int		cnt;
	uchar	TO;						/* 0:not use 1;counting 2:TO */
} DLC_MatRtcTimer[RTC_TIMER_NUM];
int	DLCMatTmisAct()
{
	for(int i=0;i<TIMER_NUM;i++ ){
		if( DLC_MatTimer[i].TO ){
			return 1;
		}
	}
	return 0;
}
void DLCMatTimerset(int tmid,int cnt )
{
	if(DLCMatTmisAct()==0)
       TC5_TimerStart();
	DLC_MatTimer[tmid].TO = 1;
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
	if( DLC_MatTimer[tmid].TO == 2 ){
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
				DLC_MatTimer[i].TO = 2;
		}
	}
//	putch('t');
}
/*
	Function:RTCタイマー関数通信タスクのTO通知の確認
*/
void DLCMatRtcTimerset(int tmid,int cnt )
{
	DLC_MatRtcTimer[tmid].cnt = cnt;
}
void DLCMatTtcTimerClr(int tmid )
{
	DLC_MatRtcTimer[tmid].cnt = 0;
	DLC_MatRtcTimer[tmid].TO = 0;
}
int	DLCMatRtcChk(int tmid)
{
	if( DLC_MatRtcTimer[tmid].TO ){
		if( DLC_MatRtcTimer[tmid].cnt == 0 ){
			DLC_MatRtcTimer[tmid].TO = 0;
			return 1;
		}
	}
	return 0;
}
void DLCMATrtctimer()
{
	for(int i=0;i<RTC_TIMER_NUM;i++ ){
		if( DLC_MatRtcTimer[i].cnt != 0 ){
			DLC_MatRtcTimer[i].cnt--;
			if( DLC_MatRtcTimer[i].cnt == 0 )
				DLC_MatRtcTimer[i].TO = 1;
		}
	}
}
/*
	MATcoreをWAKEUPさせる処理
	3秒待つ
*/
void DLCMatWake()
{
	int		i;
	PORT_GroupWrite( PORT_GROUP_1,0x1<<10,-1 );						/* Wake! */
	for(i=0;i<300;i++){
		APP_delay(10);
		if( PORT_GroupRead( PORT_GROUP_1 ) & (0x1<<11))
			break;
		PORT_GroupWrite( PORT_GROUP_1,0x1<<10,0 );
		APP_delay(1);
		PORT_GroupWrite( PORT_GROUP_1,0x1<<10,-1 );
	}
	if( i == 300 )
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
				len++;
				str2int( &p[len],&wk );
				wk *= -1;
			}
		}
		else {
			q = strchr( p,'\r' );
			if( q ){
				str2int( &p[len],&wk );
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
#define		MATC_STATE_DISC	17
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
	if( DLC_MatRetry++ > 5 ){
		DLCMatError(0);
		return;
	}
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
	if (DLC_Para.FOTAact != 0) {	// fota 運用時
		if( strstr( DLC_MatVer,"01.04" ) )
			strcpy(	DLC_MatNUM,"812000000000000" );
		else{
			if( DLC_MatNUM[0] )
				;
			else {
				DLCMatError(1);
				DLCMatTimerClr( 0 );
				return;
			}
		}
		switch( DLC_Para.Server ){
		case 0:
			DLCMatSend( "AT$SETSERVER,karugamosoft.ddo.jp,9999\r" );
			break;
		default:
			DLCMatSend( "AT$SETSERVER,beam.soracom.io,8888\r" );
			break;
		}
	} else {	// fota FOTA実行時
		DLCMatSend( "AT$SETSERVER,harvest-files.soracom.io,80\r" );	// fota soracom harvest指定
		DLC_Matknd = 3;	// fota FOTA発呼
	}
	DLCEventLogWrite( _ID1_USIM_CNUM,
	(DLC_MatNUM[0]-'0')<<24|(DLC_MatNUM[1]-'0')<<20|(DLC_MatNUM[2]-'0')<<16|(DLC_MatNUM[3]-'0')<<12|(DLC_MatNUM[4]-'0')<<8|(DLC_MatNUM[5]-'0')<<4|(DLC_MatNUM[6]-'0'),
	(DLC_MatNUM[7]-'0')<<28|(DLC_MatNUM[8]-'0')<<24|(DLC_MatNUM[9]-'0')<<20|(DLC_MatNUM[10]-'0')<<16|(DLC_MatNUM[11]-'0')<<12|(DLC_MatNUM[12]-'0')<<8|(DLC_MatNUM[13]-'0')<<4|(DLC_MatNUM[14]-'0') );
	DLCMatTimerset( 0,TIMER_5000ms );
	DLC_MatState = MATC_STATE_SVR;
}
void MTconn()
{
	DLC_MatLineIdx = 0;
	DLCMatSend( "AT$CONNECT?\r" );
	DLCMatTimerset( 0,TIMER_90s );
	if (DLC_Para.FOTAact != 0) {	// fota 運用時
		DLC_MatState = MATC_STATE_COND;
	} else {	//  FOTA実行時
		DLC_MatState = MATC_STATE_FOTA;	// fota FOTA stateへ
	}
}
void MTtime()
{
	memcpy( DLC_MatDateTime,DLC_MatLineBuf,DLC_MatLineIdx );
	DLC_MatLineIdx = 0;
	if (WPFM_ForcedCall == true) {	// 強制発報
		UTIL_LED1_ON();
	}
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
	DLCEventLogWrite( _ID1_MAT_VERSION,0,(DLC_MatVer[0]-'0')<<12|(DLC_MatVer[1]-'0')<<8|(DLC_MatVer[3]-'0')<<4|(DLC_MatVer[4]-'0') );
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
	if (WPFM_ForcedCall == true) {	// 強制発報
		UTIL_LED1_OFF();
	}
	DLCEventLogWrite( _ID1_OPEN_OK,0,0 );
	DLCMatPostConfig();
	DLC_MatState = MATC_STATE_CNFG;
	DLCMatTimerset( 0,TIMER_7000ms );
}
void MTwget()	// fota
{
	DLC_MatLineIdx = 0;
	DLCMatWgetFile();
	DLCMatTimerset( 4,TIMER_15s );
}
/*
	PostConfig送信でOKを受けた,$RECV待ち
*/
void MTrrcv()
{
	DLCMatTimerset( 0,TIMER_7000ms );
}
void MTrvTO()
{
	DLC_MatLineIdx = 0;
	if (WPFM_ForcedCall == true) {	// 強制発報
		UTIL_startBlinkLED1(5);	// LED1 5回点滅
		DLCMatRtcTimerset(1, 6);
	}
	DLCMatTimerClr( 3 );										/* AT$RECV,1024リトライタイマークリア */
	DLCMatSend( "AT$CLOSE\r" );
	DLCMatTimerset( 0,TIMER_3000ms );
}
void MTdata()
{
	int	rt;
	DLCMatTimerClr( 3 );										/* AT$RECV,1024リトライタイマークリア */
	rt = DLCMatRecvDisp();
	if( rt == 0 ){												/* 残りデータなし */
		zLogOn = 1;
		DLCMatTimerset( 0,TIMER_300ms);							/* $CLOSE待ち */
		if (WPFM_ForcedCall == true) {	// 強制発報
			DLC_ForcedCallOK = true;
			UTIL_LED1_ON();	// LED1 5秒点灯
			DLCMatRtcTimerset(1, 6);
		}
	}
	else {
		putst("Remain=");putdech( rt );putcrlf();
		DLCMatSend( "AT$RECV,1024\r" );
	}
}
void MTfirm()	// fota
{
	int	rt;
	if (DLC_MatFotaWriteNG == false) {	/* 書込みNGなし */
		DLC_MatFotaTOcnt = 0;
		DLCMatTimerset( 4,TIMER_5000ms);
	}
	rt = DLCMatRecvWriteFota();			/* 内部Flashへ受信データ書込み処理 */
	putst("RecvRet=");puthxs( rt );putcrlf();
	if( rt == 0 ){
		DLC_MatLineIdx = 0;
//		zLogOn = 1;
	} else if (rt > 0) {
		DLC_MatLineIdx = 0;
		DLCMatSend( "AT$RECV,1024\r" );
	} else {
		putst("RecvDataERROR\r\n");
	}
}
void MTopn2()
{
	DLC_MatLineIdx = 0;
	if ((WPFM_ForcedCall == true) && (DLC_ForcedCallOK == false)) {	// 強制発報かつサーバ応答なし
		UTIL_startBlinkLED1(5);	// LED1 5回点滅
		DLCMatRtcTimerset(1, 6);
	}
	DLC_ForcedCallOK = false;
	DLCMatSend( "AT$OPEN\r" );
	DLCMatTimerset( 0,TIMER_15s );
	DLC_MatState = MATC_STATE_OPN2;
}
void MTstst()
{
	DLC_MatLineIdx = 0;
	DLCMatPostStatus();
	DLCMatTimerset( 0,TIMER_7000ms );
	DLC_MatState = MATC_STATE_STAT;
}
void MTopn3()
{
	DLC_MatLineIdx = 0;
	DLCMatSend( "AT$OPEN\r" );
	DLCMatTimerset( 0,TIMER_15s );
	DLC_MatState = MATC_STATE_OPN3;
}
void MTrprt()
{
	DLC_MatLineIdx = 0;
	if( DLCMatPostReport() ){													/* Report送信処理 */
		DLCMatTimerset( 0,TIMER_7000ms );
		DLC_MatState = MATC_STATE_RPT;
	}
	else {
		DLCMatSend( "AT$DISCONNECT\r" );
		DLCMatTimerset( 0,TIMER_3000ms );
		DLC_MatState = MATC_STATE_DISC;
	}
}
/*
	Post Report送信してOKを受けた、データがあれな送信 $CLOSE待ち
*/
void MTrpOk()
{
	DLC_MatLineIdx = 0;
	DLCMatReportSnd();
	DLCMatTimerset( 0,TIMER_7000ms );
	DLC_MatState = MATC_STATE_RPT;
}
void MTdisc()
{
	DLC_MatLineIdx = 0;
	if (WPFM_ForcedCall == true) {	// 強制発報
		UTIL_startBlinkLED1(5);	// LED1 5回点滅
		DLCMatRtcTimerset(1, 6);
	}
	if( DLC_Matknd ){													/* 発呼要求保持 */
		DLC_Matknd = 0;
		DLCMatSend( "AT$CONNECT\r" );
		DLCEventLogWrite( _ID1_CONNECT,0,0 );
		DLCMatTimerset( 0,TIMER_90s );
		DLC_MatState = MATC_STATE_CONN;
	}
	else {
		DLCMatTimerset( 0,TIMER_7000ms );
		putst("Go Sleep\r\n");
		PORT_GroupWrite( PORT_GROUP_1,0x1<<10,0 );						/* Sleep! */
		DLC_MatState = MATC_STATE_DISC;
	}
}
void MTcls3()
{
	DLC_MatLineIdx = 0;
	if (WPFM_ForcedCall == true) {	// 強制発報
		UTIL_startBlinkLED1(5);	// LED1 5回点滅
		DLCMatRtcTimerset(1, 6);
	}
	if( DLC_MatState == MATC_STATE_RPT ){	// Report送信で
		if (DLC_MatsendRepOK == false) {	// 200 OK未受信の場合
			MLOG_tailAddressRestore();	// tailAddress戻す
		}
	}
	DLCMatTimerClr( 3 );										/* AT$RECV,1024リトライタイマークリア */
	DLCMatSend( "AT$DISCONNECT\r" );
	DLCMatTimerset( 0,TIMER_3000ms );
	DLC_MatState = MATC_STATE_DISC;
}
void MTclsF()	// fota
{
	DLCMatFOTAdataRcvFin();
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
	DLC_Matknd = 0;
	DLCMatSend( "AT$CONNECT\r" );
	DLCEventLogWrite( _ID1_CONNECT,0,0 );
	DLCMatTimerset( 0,TIMER_90s );
	TC5_TimerStart();
	DLC_MatState = MATC_STATE_CONN;
}
void MTconW()
{
	DLC_MatLineIdx = 0;
	DLCMatSend( "AT$CONNECT\r" );
	DLCEventLogWrite( _ID1_CONNECT,0,0 );
	DLCMatTimerset( 0,TIMER_90s );
	DLC_MatState = MATC_STATE_CONN;
}
void MTtoF()	// fota T/O
{
	if (DLC_MatFotaTOcnt < 3) {
		DLC_MatFotaTOcnt++;
		DLCMatTimerset( 4,TIMER_5000ms);
		DLCMatSend( "AT$RECV,1024\r" );
		putst("リトライ(*o*)\r\n");
	} else {
		// FOTA失敗 次回契機に実行
		putst("FOTA FAILED(T/O).\r\n");
		DLC_MatSPIFOTAerase();	// SPI最終セクタ消去
	}
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
	switch( knd ){
	case 1:
		putst("定期●CALL!\r\n");										/* Constant */
		break;
	case 2:	
		putst("強制■CALL!\r\n");										/* Push */
		DLC_Matknd = knd;
		break;
	case 3:
		putst("警報★CALL!\r\n");										/* Alert */
		DLC_Matknd = knd;
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
void MTledQ()
{
	GPIOEXP_set(0);												/* LED全消灯 */
	GPIOEXP_set(1);
	GPIOEXP_set(2);
	MTRdy();
}
void	 (*MTjmp[18][19])() = {
/*					  0         1       2      3       4       5       6       7       8       9       10      11      12      13      14      15      16      17   18     */
/*				  	 INIT    IDLE    IMEI    APN     SVR     CONN    COND    OPN1    CNFG    OPN2    STAT    OPN3    REPT    SLEEP   FOTA    FCON    FTP     DISC    ERR   */
/* MATCORE RDY 0 */{ MTRdy,  MTRdy,  MTRdy,  MTRdy,  MTRdy,  MTRdy,  MTRdy,  MTRdy,  MTRdy,  MTRdy,  MTRdy,  MTRdy,  MTRdy,  MTRdy,  MTRdy,  MTRdy,  MTRdy,  MTRdy,  MTRdy  },
/* ERROR       1 */{ ______, MTVrT,  ______, ______, ______, ______, ______, MTcls3, MTcls3, MTcls3, MTcls3, MTcls3, MTcls3, ______, ______, ______, ______, ______, ______ },
/* $VER		   2 */{ ______, MTVer,  ______, ______, ______, ______, ______, ______, ______, ______, ______, ______, ______, ______, ______, ______, ______, ______, ______ },
/* $NUM		   3 */{ ______, ______, MTimei, ______, ______, ______, ______, ______, ______, ______, ______, ______, ______, ______, ______, ______, ______, ______, ______ },
/* OK          4 */{ ______, ______, ______, MTapn,  MTdisc, MTconn, ______, ______, MTrrcv, ______, MTrrcv, ______, MTrpOk, ______, ______, ______, ______, ______, ______ },
/* $CONNECT:1  5 */{ ______, ______, ______, ______, ______, ______, MTtime, ______, ______, ______, ______, ______, ______, ______, MTopnF, ______, ______, ______, ______ },
/* $TIME       6 */{ ______, ______, ______, ______, ______, ______, MTrsrp, ______, ______, ______, ______, ______, ______, ______, ______, ______, ______, ______, ______ },
/* $RSRP       7 */{ ______, ______, ______, ______, ______, ______, MTOpen, ______, ______, ______, ______, ______, ______, ______, ______, ______, ______, ______, ______ },
/* $OPEN/$WAKE 8 */{ ______, ______, ______, ______, ______, ______, ______, MTcnfg, ______, MTstst, ______, MTrprt, ______, MTconW, MTwget, ______, ______, ______, ______ },
/* $CLOSE      9 */{ ______, ______, ______, ______, ______, ______, ______, ______, MTopn2, ______, MTopn3, ______, MTcls3, ______, MTclsF, ______, ______, ______, ______ },
/* $RECVDATA  10 */{ ______, ______, ______, ______, ______, ______, ______, ______, MTdata, ______, MTdata, ______, MTdata, ______, MTfirm, ______, ______, ______, ______ },
/* $CONNECT:0 11 */{ ______, ______, ______, ______, ______, ______, MTdisc, MTdisc, MTdisc, MTdisc, MTdisc, MTdisc, MTdisc, ______, ______, ______, ______, MTdisc, ______ },
/* TimOut1    12 */{ MTRdy,  MTVrT,  MTVer,  MTimei, MTdisc, MTdisc, MTdisc, MTcls3, MTrvTO, MTcls3, MTrvTO, MTcls3, MTcls3, MTRSlp, MTtoF,  ______, ______, MTdisc, MTledQ },
/* WAKEUP     13 */{ ______, ______, ______, ______, ______, ______, ______, ______, ______, ______, ______, ______, ______, MTwake, ______, ______, ______, MTwake, ______ },
/* FOTA       14 */{ ______, ______, ______, ______, ______, ______, ______, ______, ______, ______, ______, ______, ______, ______, ______, ______, ______, ______, ______ },
/* FTP        15 */{ ______, ______, ______, ______, ______, ______, ______, ______, ______, ______, ______, ______, ______, ______, ______, ______, ______, ______, ______ },
/* $SLEEP     16 */{ ______, ______, ______, ______, ______, ______, ______, ______, MTslep, MTslep, MTslep, MTslep, MTslep, ______, ______, ______, ______, MTslep, ______ },
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
			if (DLC_Para.FOTAact != 0) {	// fota 運用時
				DLCMatTimerset( 3,TIMER_7000ms);
			}
		}
	}
	if( DLC_MatLineIdx >= 19 ){				/* $RECVDATA:1,0,"41"\r */
		DLC_MatLineBuf[DLC_MatLineIdx] = 0;
		if( strstr( (char*)DLC_MatLineBuf,"$RECVDATA:" )){
			p = strchr( (char*)DLC_MatLineBuf,'\"' );
			if( p > 0 ){
				p++;
				q = strstr( p,"\"\r" );
				if( q ){
					putst("Size=");puthxs(q-p);putcrlf();
					DLC_Matfact = MATC_FACT_DATA;
				}
			}
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
	if( DLC_Matfact == 0xff ){
		if( DLCMatTmChk( 0 ) )
			DLC_Matfact = MATC_FACT_TO1;
		else if( DLCMatTmChk( 1 ) )
			DLC_Matfact = MATC_FACT_TO2;
		else if( DLCMatTmChk( 3 ) ){
			DLCMatSend( "AT$RECV,1024\r" );
			putst("リトライ(ToT)\r\n");
		}
//		else if( DLCMatRtcChk( 0 ) ){
//			DLCMatSend( "AT$RECV,1024\r" );
//			putst("RTC Timer Ok\r\n");
//		}
		else if( DLCMatTmChk( 4 ) )
			DLC_Matfact = MATC_FACT_TO1;
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
void DLCMatConfigDefault()
{
	WPFM_SETTING_PARAMETER	config;
	config.isInvalid = 1;
	config.serialNumber 					= 9999999;
	config.measurementInterval 				= 60;
	config.communicationInterval 			= 300;
	config.measurementIntervalOnAlert	 	= 30;
	config.communicationIntervalOnAlert 	= 120;
#ifdef ADD_FUNCTION
	config.Measurment						= 0;
#endif
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
	strcpy( config.AlertPause,"2040-01-01 09:00:01" );
	config.alertTimeout						= 5;
	WPFM_writeSettingParameter( &config );
}
void DLCMatReortDefault()
{
}
static char http_config[] = "POST /config HTTP/1.1\r\nHost:beam.soracom.io\r\nContent-Type:application/json\r\nContent-Length:    \r\n\r\n";
static char http_status[] = "POST /status HTTP/1.1\r\nHost:beam.soracom.io\r\nContent-Type:application/json\r\nContent-Length:    \r\n\r\n";
static char http_report[] = "POST /report HTTP/1.1\r\nHost:beam.soracom.io\r\nContent-Type:application/json\r\nContent-Length:      \r\n\r\n";
static char http_tmp[2048];
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
#ifdef ADD_FUNCTION
	sprintf( tmp,"\"Measurment\":%d,"			,config.Measurment );						strcat( http_tmp,tmp );
#endif
	sprintf( tmp,"\"Select_ch1\":%d,"			,config.sensorKinds[0] )		;			strcat( http_tmp,tmp );		/* ch1 センサ種別 */
	sprintf( tmp,"\"Upper0_ch1\":%d,"			,config.upperLimits[0] );					strcat( http_tmp,tmp );		/* ch1 センサ出力の上限値 */
	sprintf( tmp,"\"Lower0_ch1\":%d,"			,config.lowerLimits[0] );					strcat( http_tmp,tmp );		/* ch1 センサ出力の下限値 */
	sprintf( tmp,"\"AlertSw_U2_ch1\":%d,"		,(int)config.alertEnableKinds[0][0][1] );	strcat( http_tmp,tmp );		/* アラート U2 ch1 */
	sprintf( tmp,"\"Upper2_ch1\":%.03f,"		,config.alertUpperLimits[0][1] );			strcat( http_tmp,tmp );		/* 上限値2 ch1 */
	sprintf( tmp,"\"AlertSw_U1_ch1\":%d,"		,(int)config.alertEnableKinds[0][0][0] );	strcat( http_tmp,tmp );		/* アラート U1 ch1 */
	sprintf( tmp,"\"Upper1_ch1\":%.03f,"		,config.alertUpperLimits[0][0] );			strcat( http_tmp,tmp );		/* 上限値1 ch1 */
	sprintf( tmp,"\"AlertSw_L1_ch1\":%d,"		,(int)config.alertEnableKinds[0][1][0] );	strcat( http_tmp,tmp );		/* アラート U2 ch1 */
	sprintf( tmp,"\"Lower1_ch1\":%.03f,"		,config.alertLowerLimits[0][0] );			strcat( http_tmp,tmp );		/* 上限値2 ch1 */
	sprintf( tmp,"\"AlertSw_L2_ch1\":%d,"		,(int)config.alertEnableKinds[0][1][1] );	strcat( http_tmp,tmp );
	sprintf( tmp,"\"Lower2_ch1\":%.03f,"		,config.alertLowerLimits[0][1] );			strcat( http_tmp,tmp );
 	sprintf( tmp,"\"Measure_ch1\":\"%s\","		,config.Measure_ch1 );						strcat( http_tmp,tmp );
 	sprintf( tmp,"\"MeaKind_ch1\":\"%s\","		,config.MeaKind_ch1 );						strcat( http_tmp,tmp );
	sprintf( tmp,"\"Chattering_ch1\":%d,"		,config.alertChatteringTimes[0] );			strcat( http_tmp,tmp );
	sprintf( tmp,"\"Select_ch2\":%d,"			,config.sensorKinds[1] );					strcat( http_tmp,tmp );
	sprintf( tmp,"\"Upper0_ch2\":%d,"			,config.upperLimits[1] );					strcat( http_tmp,tmp );
	sprintf( tmp,"\"Lower0_ch2\":%d,"			,config.lowerLimits[1] );					strcat( http_tmp,tmp );
	sprintf( tmp,"\"AlertSw_U2_ch2\":%d,"		,(int)config.alertEnableKinds[1][0][1] );	strcat( http_tmp,tmp );
	sprintf( tmp,"\"Upper2_ch2\":%.03f,"		,config.alertUpperLimits[1][1] );			strcat( http_tmp,tmp );
	sprintf( tmp,"\"AlertSw_U1_ch2\":%d,"		,(int)config.alertEnableKinds[1][0][0] );	strcat( http_tmp,tmp );
	sprintf( tmp,"\"Upper1_ch2\":%.03f,"		,config.alertUpperLimits[1][0] );			strcat( http_tmp,tmp );
	sprintf( tmp,"\"AlertSw_L1_ch2\":%d,"		,(int)config.alertEnableKinds[1][1][0] );	strcat( http_tmp,tmp );
	sprintf( tmp,"\"Lower1_ch2\":%.03f,"		,config.alertLowerLimits[1][0] );			strcat( http_tmp,tmp );
	sprintf( tmp,"\"AlertSw_L2_ch2\":%d,"		,(int)config.alertEnableKinds[1][1][1] );	strcat( http_tmp,tmp );
	sprintf( tmp,"\"Lower2_ch2\":%.03f,"		,config.alertLowerLimits[1][1] );			strcat( http_tmp,tmp );
	sprintf( tmp,"\"Measure_ch2\":\"%s\","		,config.Measure_ch2 );						strcat( http_tmp,tmp );
	sprintf( tmp,"\"MeaKind_ch2\":\"%s\","		,config.MeaKind_ch2 );						strcat( http_tmp,tmp );
	sprintf( tmp,"\"Chattering_ch2\":%d,"		,config.alertChatteringTimes[1] );			strcat( http_tmp,tmp );
	sprintf( tmp,"\"Chattering_type\":%d,"		,config.alertChatteringKind );				strcat( http_tmp,tmp );
	sprintf( tmp,"\"AlertPause\":\"%s\","		,config.AlertPause );						strcat( http_tmp,tmp );
	sprintf( tmp,"\"AlertTimeOut\":%d"			,config.alertTimeout );						strcat( http_tmp,tmp );
	strcat( http_tmp,"}}" );
#ifdef ADD_FUNCTION
	config.Measurment = 0;	// =1だった場合、1度Config送信したら戻す
#endif
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
	DLC_MatTxType = 0;
	putst("Alert=");puthxb( WPFM_TxType );putcrlf();
	DLC_MatTxType = WPFM_TxType;
#ifdef ADD_FUNCTION
	if ( WPFM_isAlertPause == true )
		DLC_MatTxType = 20;
#endif
	if( DLC_Matknd == 2 )				/* Push SW */
		DLC_MatTxType = 1;
	sprintf( tmp,"\"LoggerSerialNo\":%d,"	,(int)config.serialNumber );					strcat( http_tmp,tmp );
	sprintf( tmp,"\"IMEI\":\"%s\","			,DLC_MatIMEI );									strcat( http_tmp,tmp );
	sprintf( tmp,"\"MSISDN\":\"%s\","		,DLC_MatNUM );									strcat( http_tmp,tmp );
	sprintf( tmp,"\"Version\":\"%5s\","		,ver );											strcat( http_tmp,tmp );
	sprintf( tmp,"\"LTEVersion\":\"%s\","	,DLC_MatVer );									strcat( http_tmp,tmp );
	sprintf( tmp,"\"ExtCellPwr1\":%.3f,"	,(float)WPFM_lastBatteryVoltages[0]/1000 );		strcat( http_tmp,tmp );
	sprintf( tmp,"\"ExtCellPwr2\":%.3f,"	,(float)WPFM_lastBatteryVoltages[1]/1000 );		strcat( http_tmp,tmp );
	sprintf( tmp,"\"Batt1Use\":%d,"			,WPFM_batteryStatus>>4 );						strcat( http_tmp,tmp );
	sprintf( tmp,"\"Batt2Use\":%d,"			,WPFM_batteryStatus&0x0F );						strcat( http_tmp,tmp );
	sprintf( tmp,"\"EARFCN\":%d,"			,DLCMatCharInt( DLC_MatRadioDensty,"EARFCN:"));	strcat( http_tmp,tmp );
	sprintf( tmp,"\"CellId\":%d,"			,DLCMatCharInt( DLC_MatRadioDensty,"CELLID:"));	strcat( http_tmp,tmp );
	sprintf( tmp,"\"RSRP\":%d,"				,DLCMatCharInt( DLC_MatRadioDensty,"RSRP:" ));	strcat( http_tmp,tmp );
	sprintf( tmp,"\"RSRQ\":%d,"				,DLCMatCharInt( DLC_MatRadioDensty,"RSRQ:" ));	strcat( http_tmp,tmp );
	sprintf( tmp,"\"RSSI\":%d,"				,DLCMatCharInt( DLC_MatRadioDensty,"RSSI:" ));	strcat( http_tmp,tmp );
	sprintf( tmp,"\"SINR\":%d,"				,DLCMatCharInt( DLC_MatRadioDensty,"SINR:" ));	strcat( http_tmp,tmp );
	sprintf( tmp,"\"Temp\":%.1f,"			,(float)(WPFM_lastTemperatureOnBoard/10.0) );	strcat( http_tmp,tmp );
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
	2022.11.3 Reportを分割して送信する
*/
//http_tmpをASCII変換して送信する。→OKを待つ、これおループ
int		DLC_MatReportMax,DLC_MatReportCnt,DLC_MatReportFin;
#define			DLC_REPORT_ALL_MAX		3000				/* 1度の通信で送信するReortのMAX */
#define			DLC_REPORT_SND_LMT		12					/* MATcoreに一度にSendするReport数 */
void DLCMatReportSndSub()
{
	char	tmp[3],v;
	int		i;
	putst("■\r\n");
	strcpy( DLC_MatSendBuff,"AT$SEND,\"" );
	tmp[2] = 0;
	for( i=0;http_tmp[i]!=0;i++ ){
		v = http_tmp[i];
		tmp[0] = outhex( v>>4 );
		tmp[1] = outhex( v&0x0f );
		strcat( DLC_MatSendBuff,tmp );
	}
	strcat( DLC_MatSendBuff,"\"\r" );
	DLCMatSend( DLC_MatSendBuff );
	memset( http_tmp,0,sizeof( http_tmp ));
}
/* 
	ListのDLC_REPORT_SND_LMTまで分割して送る
*/
void DLCMatReportSnd()
{
	char	tmp[48],s[32];
	int		i;
	MLOG_T 	log_p;
	if( DLC_MatReportFin < 0 )																		/* 送信終わり */
		return;
	for( i=0; DLC_MatReportCnt < DLC_MatReportMax; DLC_MatReportCnt++,i++ ){
		if( i == DLC_REPORT_SND_LMT )
			break;
		if( MLOG_getLog( &log_p ) < 0 )
			break;
		DLCMatClockGet( &log_p,s );
		if( DLC_MatReportFin ){
			strcat( http_tmp,"," );
		}
		else
			DLC_MatReportFin = 1;
		sprintf( tmp,"{\"Time\":\"%s\","		,s );									strcat( http_tmp,tmp );
		sprintf( tmp,"\"Value_ch1\":%.3f,"	,log_p.measuredValues[0] );					strcat( http_tmp,tmp );
		sprintf( tmp,"\"Value_ch2\":%.3f,"	,log_p.measuredValues[1] );					strcat( http_tmp,tmp );
		sprintf( tmp,"\"Alert\":\"%02x\"}"	,log_p.alertStatus  );						strcat( http_tmp,tmp );
	}
	if ( DLC_MatReportCnt == DLC_MatReportMax ){													/* 最後のList */
		strcat( http_tmp,"]}}" );
		DLC_MatReportFin = -1;
	}
	putst( http_tmp );putcrlf();
	DLCMatReportSndSub();
}
int DLCMatPostReport()
{
	char	tmp[48],*p;
	int		i,Len;
	MLOG_T 	log_p;
	DLC_MatsendRepOK = false;
	DLC_MatReportCnt = 0;																			/* httpを作るときのReportのカウンタ */
	DLC_MatReportFin = 0;																			/* 分割送信の為,最終フレームを表すフラグ */
	strcpy( http_tmp,http_report );
	strcat( http_tmp,"{\"Report\":{" );
	sprintf( tmp,"\"LoggerSerialNo\":%d,"	,(int)config.serialNumber );
	strcat( http_tmp,tmp );
	strcat( http_tmp,"\"Reportlist\":[" );
	MLOG_tailAddressBuckUp();
	for( DLC_MatReportMax=0; DLC_MatReportMax < DLC_REPORT_ALL_MAX; DLC_MatReportMax++ ){						/* Lengthを求めるためにmlogを仮走査 */
		if( MLOG_getLog( &log_p ) < 0 )
			break;
	}
	MLOG_tailAddressRestore();
	if( DLC_MatReportMax ){
		putst("Report=");putdecw( DLC_MatReportMax );putcrlf();
		DLCEventLogWrite( _ID1_REPORT,0,DLC_MatReportMax );
		Len = 51+DLC_MatReportMax*80+2;
		p = strstr( http_tmp,"Length:    " );
		if( p < 0 ){
				putst("format err1 \r\n" );
			return 0;
		}
		sprintf( tmp,"%d",Len );
		for( i=0;tmp[i]!=0;i++ )
			p[7+i] = tmp[i];
		putst( http_tmp );putcrlf();
		DLCMatReportSndSub();																/* ヘッダだけ送信 */
		return 1;																			/* 送信データ有 */
	}
	else {
		return 0;																			/* なし */
	}
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

	if (WPFM_InAlert == true) {	// 警報状態?
		SENSOR_updateMeasurementInterval(WPFM_settingParameter.measurementIntervalOnAlert);
		WPFM_updateCommunicationInterval(WPFM_settingParameter.communicationIntervalOnAlert);
	} else {	// 通常
		SENSOR_updateMeasurementInterval(WPFM_settingParameter.measurementInterval);
		WPFM_updateCommunicationInterval(WPFM_settingParameter.communicationInterval);
	}
	WPFM_dumpSettingParameter(&WPFM_settingParameter);
}
#ifdef ADD_FUNCTION
bool DLCMatWatchAlertPause()
{
	RTC_DATETIME dt;
//	char time[32];
	char tmp[3] = {0, 0, 0};
	uint8_t ap_year, ap_month, ap_day, ap_hour, ap_minute, ap_second;

	RTC_getDatetime( &dt );
//	sprintf( time,"%02d-%02d-%02d %02d:%02d:%02d",(int)dt.year,(int)dt.month,(int)dt.day,(int)dt.hour,(int)dt.minute,(int)dt.second );
//	putst("\r\nCulentTime:  ");putst(time);putcrlf();
//	putst("AlertPause:");putst(WPFM_settingParameter.AlertPause);putcrlf();
	tmp[0] = WPFM_settingParameter.AlertPause[0];
	tmp[1] = WPFM_settingParameter.AlertPause[1];
	ap_year = atoi(tmp);
	if (strlen(WPFM_settingParameter.AlertPause) == 0) {
//		putst("non AlertPause\r\n");
		return false;
	}
//	puthxs(ap_year);putcrlf();
	if (20 > ap_year) {
//		putst("return normal1\r\n");
		return true;
	} else if (20 == ap_year) {
		tmp[0] = WPFM_settingParameter.AlertPause[2];
		tmp[1] = WPFM_settingParameter.AlertPause[3];
		ap_year = atoi(tmp);
//		puthxs(ap_year);putcrlf();
		if (dt.year > ap_year) {
//			putst("return normal2\r\n");
			return true;
		} else if (dt.year == ap_year) {
			tmp[0] = WPFM_settingParameter.AlertPause[5];
			tmp[1] = WPFM_settingParameter.AlertPause[6];
			ap_month = atoi(tmp);
//			puthxs(ap_month);putcrlf();
			if (dt.month > ap_month) {
//				putst("return normal3\r\n");
				return true;
			} else if (dt.month == ap_month) {
				tmp[0] = WPFM_settingParameter.AlertPause[8];
				tmp[1] = WPFM_settingParameter.AlertPause[9];
				ap_day = atoi(tmp);
//				puthxs(ap_day);putcrlf();
				if (dt.day > ap_day) {
//					putst("return normal4\r\n");
					return true;
				} else if (dt.day == ap_day) {
					tmp[0] = WPFM_settingParameter.AlertPause[11];
					tmp[1] = WPFM_settingParameter.AlertPause[12];
					ap_hour = atoi(tmp);
//					puthxs(ap_hour);putcrlf();
					if (dt.hour > ap_hour) {
//						putst("return normal5\r\n");
						return true;
					} else if (dt.hour == ap_hour) {
						tmp[0] = WPFM_settingParameter.AlertPause[14];
						tmp[1] = WPFM_settingParameter.AlertPause[15];
						ap_minute = atoi(tmp);
//						puthxs(ap_minute);putcrlf();
						if (dt.minute > ap_minute) {
//							putst("return normal6\r\n");
							return true;
						} else if (dt.minute == ap_minute) {
							tmp[0] = WPFM_settingParameter.AlertPause[17];
							tmp[1] = WPFM_settingParameter.AlertPause[18];
							ap_second = atoi(tmp);
//							puthxs(ap_second);putcrlf();
							if (dt.second >= ap_second) {
//								putst("return normal7\r\n");
								return true;
							}
						}
					}
				}
			}
		}
	}
	return false;
}
bool DLCMatCheckAlertPause(char *alertpause_p)
{
	RTC_DATETIME dt;
//	char time[32];
	char tmp[3] = {0, 0, 0};
	uint8_t ap_year, ap_month, ap_day, ap_hour, ap_minute, ap_second;

	RTC_getDatetime( &dt );
//	sprintf( time,"%02d-%02d-%02d %02d:%02d:%02d",(int)dt.year,(int)dt.month,(int)dt.day,(int)dt.hour,(int)dt.minute,(int)dt.second );
//	putst("\r\nCulentTime:  ");putst(time);putcrlf();
//	putst("AlertPause:");putst(alertpause_p);putcrlf();
	tmp[0] = *alertpause_p++;
	tmp[1] = *alertpause_p++;
	ap_year = atoi(tmp);
	if (strlen(alertpause_p) == 0) {
//		putst("non AlertPause\r\n");
		return false;
	}
//	puthxs(ap_year);putcrlf();
	if (20 < ap_year) {
//		putst("return true1\r\n");
		return true;
	} else if (20 == ap_year) {
		tmp[0] = *alertpause_p++;
		tmp[1] = *alertpause_p++;
		ap_year = atoi(tmp);
//		puthxs(ap_year);putcrlf();
		if (dt.year < ap_year) {
//			putst("return true2\r\n");
			return true;
		} else if (dt.year == ap_year) {
			alertpause_p++;
			tmp[0] = *alertpause_p++;
			tmp[1] = *alertpause_p++;
			ap_month = atoi(tmp);
//			puthxs(ap_month);putcrlf();
			if (dt.month < ap_month) {
//				putst("return true3\r\n");
				return true;
			} else if (dt.month == ap_month) {
				alertpause_p++;
				tmp[0] = *alertpause_p++;
				tmp[1] = *alertpause_p++;
				ap_day = atoi(tmp);
//				puthxs(ap_day);putcrlf();
				if (dt.day < ap_day) {
//					putst("return true4\r\n");
					return true;
				} else if (dt.day == ap_day) {
					alertpause_p++;
					tmp[0] = *alertpause_p++;
					tmp[1] = *alertpause_p++;
					ap_hour = atoi(tmp);
//					puthxs(ap_hour);putcrlf();
					if (dt.hour < ap_hour) {
//						putst("return true5\r\n");
						return true;
					} else if (dt.hour == ap_hour) {
						alertpause_p++;
						tmp[0] = *alertpause_p++;
						tmp[1] = *alertpause_p++;
						ap_minute = atoi(tmp);
//						puthxs(ap_minute);putcrlf();
						if (dt.minute < ap_minute) {
//							putst("return true6\r\n");
							return true;
						} else if (dt.minute == ap_minute) {
							alertpause_p++;
							tmp[0] = *alertpause_p++;
							tmp[1] = *alertpause_p++;
							ap_second = atoi(tmp);
//							puthxs(ap_second);putcrlf();
							if (dt.second < ap_second) {
//								putst("return true7\r\n");
								return true;
							}
						}
					}
				}
			}
		}
	}
//	putst("return false\r\n");
	return false;
}
void DLCMatAlertTimeStart()
{
	if (DLC_MatRtcTimer[0].cnt == 0) {	// AlertTime無起動?
		DLCMatRtcTimerset(0, WPFM_settingParameter.alertTimeout);
putst("\r\nAlertTime start:");puthxs(WPFM_settingParameter.alertTimeout);putcrlf();
	}
}
void DLCMatRtcTimeChk()
{
	if (DLCMatRtcChk(0)) {	// AlertTime T/O?
		WPFM_cancelAlert();
putst("\r\nAlertTime T/O");putcrlf();
	}
	if (DLCMatRtcChk(1)) {	// LED1 6s T/O?
		UTIL_LED1_OFF();	// LED1 消灯
		WPFM_ForcedCall = false;
		DLC_ForcedCallOK = false;
	}
}
void DLCMatAlertTimeClr()
{
	if (DLC_MatRtcTimer[0].cnt != 0) {	// AlertTime起動中?
		DLCMatTtcTimerClr(0);
putst("\r\nAlertTime clear");putcrlf();
	}
}
#endif
void DLCMatConfigRet()
{
	char	*config_p;
	WPFM_readSettingParameter( &config );
	if (strstr(DLC_MatResBuf, "\"Change\":true")) {
putst("\r\ncoco3\r\n");
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
		DLCEventLogWrite( _ID1_CONFIGRET,0,0 );
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
//			putst("Upper0_ch1:");puthxs(config.upperLimits[0]);putcrlf();
		}
		config_p = strstr(DLC_MatResBuf, "Upper0_ch2");
		if (config_p) {
			DLCMatINTParamSet(config_p, false);
			config.upperLimits[1] = atoi(DLC_MatConfigItem);
//			putst("Upper0_ch2:");puthxs(config.upperLimits[1]);putcrlf();
		}
		config_p = strstr(DLC_MatResBuf, "Lower0_ch1");
		if (config_p) {
			DLCMatINTParamSet(config_p, false);
			config.lowerLimits[0] = atoi(DLC_MatConfigItem);
//			putst("Lower0_ch1:");puthxs(config.lowerLimits[0]);putcrlf();
		}
		config_p = strstr(DLC_MatResBuf, "Lower0_ch2");
		if (config_p) {
			DLCMatINTParamSet(config_p, false);
			config.lowerLimits[1] = atoi(DLC_MatConfigItem);
//			putst("Lower0_ch2:");puthxs(config.lowerLimits[1]);putcrlf();
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
#ifdef ADD_FUNCTION
		config_p = strstr(DLC_MatResBuf, "AlertPause");
		if (config_p) {
			DLCMatSTRParamSet(config_p);
			if (DLC_MatConfigItem[0] == 0) {	// AlertPauseなし?
				memset(config.AlertPause, 0, sizeof(config.AlertPause));
			} else {
				if (DLCMatCheckAlertPause(DLC_MatConfigItem) == true) {	// 現在日時以降のAlertPause?
					strcpy(config.AlertPause, DLC_MatConfigItem);	// 設定
//					putst("AlertPause:");putst(config.AlertPause);putcrlf();
				}
			}
		}
		config_p = strstr(DLC_MatResBuf, "Measurment");
		if (config_p) {
			DLCMatINTParamSet(config_p, false);
			config.Measurment = atoi(DLC_MatConfigItem);
//			putst("Measurment:");puthxw(config.Measurment);putcrlf();
			if (config.Measurment == 1) {
putst("coco4\r\n");
				WPFM_cancelAlert();
				if (WPFM_isAlertPause == true ) {	// AlertPause中?
					WPFM_isAlertPause = false;
					strcpy(config.AlertPause, "");	// AlertPauseクリア
				}
			}
		}
		config_p = strstr(DLC_MatResBuf, "AlertTimeOut");
		if (config_p) {
			DLCMatINTParamSet(config_p, true);
			config.alertTimeout = atoi(DLC_MatConfigItem);
//			putst("AlertTimeOut:");puthxb(config.alertTimeout);putcrlf();
		}
#endif
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
		putst("Ln=");putdecs(i);putst(" Rm=");putdecs(j);putcrlf();
		p = strchr( p,'\"' );
		if( p > 0 ){
			p++;
			q = strchr( p,'\"' );
			putst("1024=");putdecs(q-p);putcrlf();						/* "～"のレングス */
			for( k=0;k<i;k++ ){
				n = inhex( *p++ )<<4;
				n += inhex( *p++ );
				DLC_MatResBuf[DLC_MatResIdx++] = n;
			}
			k = q-(char*)DLC_MatLineBuf+2;
			DLC_MatLineIdx -= k;
			if( DLC_MatLineIdx ){
				memcpy( DLC_MatLineBuf,q+1,DLC_MatLineIdx );
				putst("Buf'Remain=");putdecs(DLC_MatLineIdx);putcrlf();
				Dump( (char*)DLC_MatLineBuf,8);putcrlf();
			}
			if( DLC_MatState == MATC_STATE_RPT ){
				if( strstr( DLC_MatResBuf,"HTTP/1.1 200 OK" )){
					if( strstr( DLC_MatResBuf,"Connection: close" )){		/* ここです */
putst("@@@@@ wktk1\r\n");
						if ( MLOG_updateLog() != MLOG_ERR_NONE) {	// log FLAGを通知済に変更
							putst("write error\r\n");
						}
						DLC_MatsendRepOK = true;
					}
				}
			}
			if( j == 0 ){
				DLC_MatResBuf[DLC_MatResIdx] = 0;
				putst( DLC_MatResBuf );
				DLC_MatResIdx = 0;
//putst("\r\ncoco1\r\n");
				if (strstr(DLC_MatResBuf,"ConfigRet")) {
//putst("coco2\r\n");
					DLCMatConfigRet();
				}
// fota				if( strstr( DLC_MatResBuf,"Status" )){
// fota					if (strstr(DLC_MatResBuf, "\"LTEVersion\":")) {	// fota StatusでF/W version指定されたらFOTA起動?
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
		case 'A':						/* チップイレーズ */
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
	putst("You need to decide work address by 'A' command");putcrlf();
	while(1){
		key = toupper( getch() );
		switch( key ){
		case 'W':
			NVMCTRL_PageWrite( (uint32_t *)buff,address );puthxw( address );putst("wrote!\r\n");
			break;
	    case 'E':
			NVMCTRL_RowErase( address );puthxw( address );putst("deleted!\r\n");
			break;
		case 'F':
			putst("Fill char=>");
			key = getch();
			memset( buff,key,sizeof( buff ));
			putst("\r\n");
			Dump( (char*)buff,sizeof( buff ) );
			break;
		case 'R':
			putch('@');puthxw( address );putcrlf();
			Dump( (char*)address,sizeof( buff ) );
			address+=0x100;
			break;
		case 'A':
			putst("Read mem Address=>" );
			address = c_get32b();
			break;
		case 'D':
			putst("保存パラメータ削除\r\n");
			NVMCTRL_RowErase( 0x0003FE00 );				/* 保存パラメータ削除 */
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
			DLCMatServerChange();
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
			DLCMatReset();
			break;
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
void DLCMatMain()
{
	extern void _RTC_handlerBClr();
	char key;
	int ret=0;
	RTC_DATETIME dt;
	char s[32];
//	PORT_GroupWrite( PORT_GROUP_1,0x1<<22,0 );
	if( DLC_BigState == 0 ){
		putst( VerPrint() );
		putst( "\r\nMATcore Task Started.\r\n" );
		DLCMatReset();
		DLCMatInit();
		DLC_BigState = 1;
		DLCEventLogWrite( _ID1_SYS_START,0,(_Main_version[4]-'0')<<12|(_Main_version[5]-'0')<<8|(_Main_version[7]-'0')<<4|(_Main_version[8]-'0' ));
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
		case 'O':															/* PortOut */
			if( CheckPasswd() ){
				putst("\r\nGroup0 (Y/N?)=>");
				if( toupper(getch()) == 'Y' ){
					putst("\r\nNo.(H)=>");ret = c_get32b();
					putst("\r\n1 (Y/N?)=>");
					if( toupper(getch()) == 'Y' )
						PORT_GroupWrite( PORT_GROUP_0,0x1<<ret,-1 );
					else
						PORT_GroupWrite( PORT_GROUP_0,0x1<<ret,0 );
				}
				else {
					putst("\r\nNo.(H)=>");ret = c_get32b();
					putst("\r\n1 (Y/N?)=>");
					if( toupper(getch()) == 'Y' )
						PORT_GroupWrite( PORT_GROUP_1,0x1<<ret,-1 );
					else
						PORT_GroupWrite( PORT_GROUP_1,0x1<<ret,0 );
				}
			}
			break;
		case ' ':
			if( DLC_MatTmid ^= 1 )
				PORT_GroupWrite( PORT_GROUP_1,0x1<<23,-1 );
			else
				PORT_GroupWrite( PORT_GROUP_1,0x1<<23,0 );
			break;
		case 'Z':
			if( CheckPasswd() )
//			DLCEventLogWrite( _ID1_CONFIGRET,-1,0 );
			DLCEventLogClr();
			break;
//		case 'W':
//			puthxw( EVENT_LOG_NUMOF_ITEM );
//			for(int i = 0; i < 100; i++ )
//				DLCEventLogWrite( _ID1_CONFIGRET,i,0 );
			break;
		case 'Y':
			putcrlf();putst("inPORT_GROUP0:1=");
			puthxw( PORT_GroupRead( PORT_GROUP_0 ));putch(':');
			puthxw( PORT_GroupRead( PORT_GROUP_1 ));
			break;
		case 'E':												/* 強制本プロ削除+Reset */
			if( CheckPasswd() ){
				putst("本プロ削除してBoot起動します。");putcrlf();
				DLC_delay(1000);
				DLCsumBreakAndReset();
			}
			break;
		case 'F':
			if( CheckPasswd() )
				DLCSPIFlashTest();
			break;
		case 'G':
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
#ifdef ADD_FUNCTION
			putst("Measurment:");puthxw(config.Measurment);putcrlf();
#endif
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
#ifdef ADD_FUNCTION
			putst("AlertPause:");putst(config.AlertPause);putcrlf();
			putst("AlertTimeOut:");puthxb(config.alertTimeout);putcrlf();
#endif
			break;
		case 'V':
//			DLC_MatSPIFOTAerase();	// SPI最終セクタ消去
			DLCEventLogDisplay();
			break;
		case 'X':	// FOTA開始
			if( CheckPasswd() )
				DLCFotaGoAndReset();
			break;
		case 'T':	// FOTA終了
			if( CheckPasswd() )
				DLCFotaFinAndReset();
			break;
		case 'P':
			if( CheckPasswd() ){
				logtime = RTC_now;
				while(1) {
					ret = mlogdumywrite(logtime);
					if (ret == 0) {
						break;
					}
					logtime += 4;
				}
				putst("##### write end #####");
			}
			break;
		case 'J':
			if( CheckPasswd() ){
				logtime = RTC_now;
				for(int i=0;i<DLC_REPORT_ALL_MAX;i++){
					ret = mlogdumywrite(logtime);
					if (ret == 0) {
						break;
					}
					logtime += 1;
				}
				putst("##### write end #####");
			}
			break;
		case 'N':
			MLOG_getNumberofLog();
			putst("\r\nnum:");puthxw(_MLOG_NumberofLog);putcrlf();
			putst("headtime:");puthxw(_MLOG_headTime);putcrlf();
			RTC_convertToDateTime(_MLOG_headTime,&dt);
			sprintf( s,"20%02d-%02d-%02d %02d:%02d:%02d",(int)dt.year,(int)dt.month,(int)dt.day,(int)dt.hour,(int)dt.minute,(int)dt.second );
			putst(s);putcrlf();
			putst("tailtime:");puthxw(_MLOG_tailTime);putcrlf();
			RTC_convertToDateTime(_MLOG_tailTime,&dt);
			sprintf( s,"20%02d-%02d-%02d %02d:%02d:%02d",(int)dt.year,(int)dt.month,(int)dt.day,(int)dt.hour,(int)dt.minute,(int)dt.second );
			putst(s);putcrlf();
			break;
		case 0x03:												/* CTRL+A */
			if( CheckPasswd() ){
				__NVIC_SystemReset();
			}
			break;
		case 'Q':												/* 強制STBY */
			if( CheckPasswd() ){
				DLC_MatState = MATC_STATE_SLP;
           		 WPFM_sleep();     							  // MCUをスタンバイモードにする
           	}
			break;
		case 'S':												/* Flash Powerdown */
			W25Q128JV_powerDown();
			break;
		case 'H':
			if( CheckPasswd() )
				_RTC_handlerBClr();
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
	if( DLCMatTmisAct())											/* タイマー使用中 */
		return 0;
	if( DLC_Matdebug.wx != DLC_Matdebug.rx )						/* ログ表示中 */
		return 0;
	if( DLC_MatState == MATC_STATE_SLP ){							/* Sleepしてよい */
		TC5_TimerStop();
		return 1;
	}
	if( DLC_MatState == MATC_STATE_ERR ){							/* Sleepしてよい */
		TC5_TimerStop();
		return 1;
	}
	return 0;
}
int DLCMatIsCom()
{
	if( DLC_MatState == MATC_STATE_SLP ){							/* Sleep中 */
		return 1;
	}
	return 0;
}
void DLCMatVersion()
{
	APP_writeUSB( (uint8_t const*)VerPrint(),30 );
}
/*
	USBからのUPDATEコマンド
*/
void DLCMatUpdateGo()
{
	DLCsumBreakAndReset();
}
/*
	USBからのFOTA開始コマンド
*/
void DLCMatFotaGo()
{
	DLCEventLogWrite( _ID1_FOTA_START,0,0 );
	DLCFotaGoAndReset();
}
void DLCMatServerChange()
{
	DLC_Para.Server ^= 0xff;
	if( DLC_Para.Server == 0 )
		putst( "karugamosoft.ddo.jp,9999\r" );
	else
		putst( "beam.soracom.io,8888\r" );
	DLCParaSave();
}
void DLCMatError( int no )
{
	DLCEventLogWrite( _ID1_SOMETHING,0,0 );
	PORT_GroupWrite( PORT_GROUP_1,0x1<<10,0 );						/* Sleep! */
	GPIOEXP_clear(0);												/* LED全点灯 */
	GPIOEXP_clear(1);
	GPIOEXP_clear(2);
	DLCMatTimerset( 0,15000 );
	DLC_MatState = MATC_STATE_ERR;
}
/*
	ログを出し切るdelay
*/
void DLC_delay( int msec )
{
	for(int i=0;i<msec;i++){
		IDLEputch();
		APP_delay(1);
	}
}
/*
	MATcoreのRESET
*/
void DLCMatReset( )
{
	putst("MATcore RST!\r\n");
	PORT_GroupWrite( PORT_GROUP_0,0x1<<12,-1 );		/* OFF */
	APP_delay(200);
	PORT_GroupWrite( PORT_GROUP_0,0x1<<12,0 );		/* ON */
	DLCMatTimerset( 0,15000 );
	DLC_MatState = MATC_STATE_INIT;
}
