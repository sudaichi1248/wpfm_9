#include <stdio.h>
#include <stddef.h>                     // Defines NULL
#include <stdbool.h>                    // Defines true
#include <stdlib.h>                     // Defines EXIT_FAILURE
#include <ctype.h>
#include <string.h>                     // Defines EXIT_FAILURE
#include "definitions.h"                // SYS function prototypes
#include "moni.h" 
#include "gpioexp.h" 
#include "w25q128jv.h"
#include "DLCpara.h"
#include "FOTAcmd.h"

#define	 	DLC_MatSPIFlashAddrFota		0xB00000;	// SPIフラッシュ書込みアドレス

char *VerPrint();
static char http_tmp[512];

bool	DLC_MatFotaWriteNG=false;	// FOTA書込みNGフラグ
int	 	DLC_MatSPIFlashPage=0x100;	// SPIフラッシュ1ページbyte数
int	 	DLC_MatSPIFlashSector=0x400;	// SPIフラッシュ1セクタbyte数
int	 	DLC_MatSPIRemaindataFota;	// 1ページ未満の半端byte数→保持して次回書込み
int	 	DLC_MatSPIWritePageFota;	// SPI書込みページインデックス
int		DLC_MatFotaDataLen=0;	// FOTAデータレングス
int		DLC_MatWriteFotaDataLen=0;	// 書込みFOTAデータレングス
char	DLC_MatFotaCRC[4];	// FOTAデータチェックサム
char	DLC_MatSPIRemainbufFota[256];	// 1ページ未満の半端byte保持バッファ
char	DLC_MatSPICheckbufFota[256];	// ベリファイ用バッファ
static	char wget_Head[] = "GET /DLC00/DLC01.bin HTTP/1.1\r\nHost:harvest-files.soracom.io\r\nUser-Agent: Wget\r\nConnection: close\r\n\r\n";	// FOTAデータ指定
//static	char wget_Head[] = "PUT HTTP/1.1\r\nHost: harvest-files.soracom.io\r\ncontent-type:text/plain\r\nContent-Length: \r\n\r\n";
// static char wget_Head[] = "GET /2048.bin HTTP/1.1\r\nHost:harvest-files.soracom.io\r\nUser-Agent: Wget\r\nConnection: close\r\n\r\n";
// static char wget_Head[] = "GET /1792.bin HTTP/1.1\r\nHost:harvest-files.soracom.io\r\nUser-Agent: Wget\r\nConnection: close\r\n\r\n";
// static char wget_Head[] = "GET /256.bin HTTP/1.1\r\nHost:harvest-files.soracom.io\r\nUser-Agent: Wget\r\nConnection: close\r\n\r\n";

//-----------------------------------------------------------------------------
// 以下、FOTA実行処理
//-----------------------------------------------------------------------------
void DLCMatWgetFile()
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

void DLCMatFOTAdataRcvFin()
{
	int		fotaaddress=DLC_MatSPIFlashAddrFota;	/* FOTAデータ保存番地 */
	APP_delay(100);
	DLC_MatLineIdx = 0;
	putst("RecvData2:\r\n");
	fotaaddress /= DLC_MatSPIFlashPage;
	if (DLC_MatSPIRemaindataFota != 0) {	/* 半端byteありの場合 */
		if (W25Q128JV_programPage(fotaaddress + DLC_MatSPIWritePageFota, 0, (uint8_t*)DLC_MatSPIRemainbufFota, DLC_MatSPIFlashPage, true) == W25Q128JV_ERR_NONE ){	/* 256byte書込む */
			puthxw(DLC_MatSPIFlashPage * (fotaaddress + DLC_MatSPIWritePageFota));
			putst("_R:OK");putcrlf();
			memset(DLC_MatSPICheckbufFota, 0xFF, sizeof(DLC_MatSPICheckbufFota));
			if (W25Q128JV_readData(DLC_MatSPIFlashPage * (fotaaddress + DLC_MatSPIWritePageFota), (uint8_t*)DLC_MatSPICheckbufFota, DLC_MatSPIFlashPage) == W25Q128JV_ERR_NONE) {
				if (memcmp(DLC_MatSPICheckbufFota, DLC_MatSPIRemainbufFota, DLC_MatSPIFlashPage) == 0) {
					putst("VERFY OK\r\n");
					DLC_MatWriteFotaDataLen += DLC_MatSPIRemaindataFota;
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
//		putst("BufData2:\r\n");Dump(DLC_MatSPIRemainbufFota, sizeof(DLC_MatSPIRemainbufFota));putcrlf();
	}
	if (DLC_MatFotaDataLen == 0) {
putst("@@@@@ length = 0\r\n");
		DLC_MatFotaWriteNG = true;
	}
	if (DLC_MatFotaWriteNG == false) {	/* 書込みNGなし? */
putst("length:");puthxw(DLC_MatFotaDataLen);putcrlf();
putst("writelength:");puthxw(DLC_MatWriteFotaDataLen);putcrlf();
putst("length(page):");puthxw(DLC_MatFotaDataLen / DLC_MatSPIFlashPage);putcrlf();
//		if (DLC_MatWriteFotaDataLen == ((DLC_MatFotaDataLen / DLC_MatSPIFlashPage) * DLC_MatSPIFlashPage)) {	/* 書込みレングス=FOTAデータレングス(ページ単位)? */
		if (DLC_MatWriteFotaDataLen == DLC_MatFotaDataLen) {	/* 書込みレングス=FOTAデータレングス? */
			memset(DLC_MatSPICheckbufFota, 0xFF, sizeof(DLC_MatSPICheckbufFota));
//			DLC_MatSPICheckbufFota[0xFC] = 0x04;
//			DLC_MatSPICheckbufFota[0xFD] = 0x03;
//			DLC_MatSPICheckbufFota[0xFE] = 0x02;
//			DLC_MatSPICheckbufFota[0xFF] = 0x01;
			memcpy(&DLC_MatSPICheckbufFota[0xFC], DLC_MatFotaCRC, sizeof(DLC_MatFotaCRC));
			putst("CheckData:\r\n");Dump(DLC_MatSPICheckbufFota, DLC_MatSPIFlashPage);putcrlf();
			if (W25Q128JV_programPage(fotaaddress + 0x35F, 0, (uint8_t*)DLC_MatSPICheckbufFota, DLC_MatSPIFlashPage, true) == W25Q128JV_ERR_NONE ){	/* チェック用256byte書込む */
				DLCMatTimerClr( 4 );	/* タイマークリア */
				DLCMatTimerClr( 5 );	/* タイマークリア */
				putst("FOTA SUCCESS. timer CLR\r\n");
putst("crc page:");puthxw(fotaaddress + 0x35F);putcrlf();
putst("write:");puthxw(DLC_MatSPIWritePageFota);putcrlf();
				DLC_delay(1000);
				DLCFotaFinAndReset();
				return;
			}
		}
	}
	putst("FOTA FAILED.\r\n");
	W25Q128JV_eraseSctor(((fotaaddress * DLC_MatSPIFlashPage + 0x36000) / 0x1000) - 1, true);	/* 失敗なのでFOTAデータ最終セクタ消去(SPI Flash) */
	DLC_delay(1000);
	DLCFotaNGAndReset();
}
int DLCMatRecvWriteFota()	// SPIへ受信データ書込み処理
{
	char	*p,*q,*fpt,n;
	int		i,j=0,k,len,recvlen;
	int		fotaaddress=DLC_MatSPIFlashAddrFota;	/* FOTAデータ保存番地 */
	if(( p = strstr( (char*)DLC_MatLineBuf,"$RECVDATA:" )) > 0 ){
		*p = 0;	// $RECVDATA:の$削除
		p = str2int( &p[10],&i );										/* $RECVDATA,i,j,"...."<cr> */
		if( p < 0 ){													/* p            q  */
			putst( "format err2\r\n" );
			DLC_MatFotaWriteNG = true;
			return -2;
		}
		p = str2int( p,&j );
		if( p < 0 ){
			putst( "format err3\r\n" );
			DLC_MatFotaWriteNG = true;
			return -3;
		}
		putst("Ln=");puthxs(i);putst(" Rm=");puthxs(j);putcrlf();
		recvlen = i;	/* 受信データレングス */
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
//			if (strstr(DLC_MatResBuf,"Connection: close") == NULL) {	/* ヘッダにConnection: closeなし=先頭以降の受信データ */
			if (strstr(DLC_MatResBuf,"Content-Type: application/octet-stream") == NULL) {	/* ヘッダにConnection: closeなし=先頭以降の受信データ */
				fpt = DLC_MatResBuf;		/* 受信バッファの先頭アドレス */
				len = DLC_MatSPIRemaindataFota;	/* 半端byteのレングス */
//				if (j > 0) {	/* Rmが0でもそれは最終データではない */
				if (1) {
					putst("RecvData1:\r\n");
//					Dump(DLC_MatResBuf,i);putcrlf();
					fotaaddress /= DLC_MatSPIFlashPage;
					if (DLC_MatSPIRemaindataFota != 0) {	/* 半端byteありの場合 */
						if ((len  + recvlen) < DLC_MatSPIFlashPage) {	/* 半端byteと受信データの和が1ページ未満? */
							memcpy(&DLC_MatSPIRemainbufFota[DLC_MatSPIRemaindataFota], fpt ,recvlen);	/* 今回受信データで半端byte保持バッファ埋める */
							DLC_MatSPIRemaindataFota = len  + recvlen;
putst("mjca2\r\n");
							return j;
						}
						memcpy(&DLC_MatSPIRemainbufFota[DLC_MatSPIRemaindataFota], fpt ,sizeof(DLC_MatSPIRemainbufFota) - DLC_MatSPIRemaindataFota);	/* 今回受信データで256byte埋めて */
						if (W25Q128JV_programPage(fotaaddress + DLC_MatSPIWritePageFota, 0, (uint8_t*)DLC_MatSPIRemainbufFota, DLC_MatSPIFlashPage, true) == W25Q128JV_ERR_NONE ){	/* 256byte書込む */
							puthxw(DLC_MatSPIFlashPage * (fotaaddress + DLC_MatSPIWritePageFota));
							putst("_R:OK");putcrlf();
							memset(DLC_MatSPICheckbufFota, 0xFF, sizeof(DLC_MatSPICheckbufFota));
							if (W25Q128JV_readData(DLC_MatSPIFlashPage * (fotaaddress + DLC_MatSPIWritePageFota), (uint8_t*)DLC_MatSPICheckbufFota, DLC_MatSPIFlashPage) == W25Q128JV_ERR_NONE) {
								if (memcmp(DLC_MatSPICheckbufFota, DLC_MatSPIRemainbufFota, DLC_MatSPIFlashPage) == 0) {
									putst("VERFY OK\r\n");
									DLC_MatWriteFotaDataLen += DLC_MatSPIFlashPage;
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
						recvlen = recvlen - (sizeof(DLC_MatSPIRemainbufFota) - DLC_MatSPIRemaindataFota);	/* 半端byte保持バッファ埋めた分減ずる */
						fpt = &DLC_MatResBuf[sizeof(DLC_MatSPIRemainbufFota) - DLC_MatSPIRemaindataFota];	/* 書込みアドレス進める */
						DLC_MatSPIWritePageFota += 1;	/* 書込みページインデックス進める */
//						putst("BufData1:\r\n");Dump(DLC_MatSPIRemainbufFota, sizeof(DLC_MatSPIRemainbufFota));putcrlf();
					}
					for (k = 0; k < ((DLC_MatSPIFlashSector - len) / DLC_MatSPIFlashPage); k++) {	/* 残りのデータを256byte毎書込み */
						if (recvlen < DLC_MatSPIFlashPage) {	/* データが1ページ未満? */
putst("mjca1\r\n");
							break;
						}
						if (W25Q128JV_programPage(fotaaddress + k + DLC_MatSPIWritePageFota, 0, (uint8_t*)(fpt + DLC_MatSPIFlashPage * k), DLC_MatSPIFlashPage, true) == W25Q128JV_ERR_NONE ){
							puthxw(DLC_MatSPIFlashPage * (fotaaddress + k + DLC_MatSPIWritePageFota));
							putst(":OK");putcrlf();
							memset(DLC_MatSPICheckbufFota, 0xFF, sizeof(DLC_MatSPICheckbufFota));
							if (W25Q128JV_readData(DLC_MatSPIFlashPage * (fotaaddress + k + DLC_MatSPIWritePageFota), (uint8_t*)DLC_MatSPICheckbufFota, DLC_MatSPIFlashPage) == W25Q128JV_ERR_NONE) {
								if (memcmp(DLC_MatSPICheckbufFota, (fpt + DLC_MatSPIFlashPage * k), DLC_MatSPIFlashPage) == 0) {
									putst("VERFY OK\r\n");
									DLC_MatWriteFotaDataLen += DLC_MatSPIFlashPage;
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
						recvlen -= DLC_MatSPIFlashPage;
					}
					memset(DLC_MatSPIRemainbufFota, 0xFF, sizeof(DLC_MatSPIRemainbufFota));	/* 半端byte保持バッファFF初期化 */
					DLC_MatSPIRemaindataFota = recvlen;	/* 1ページ未満の半端byte数 */
//					putst("DLC_MatSPIRemaindataFota1:");puthxs(DLC_MatSPIRemaindataFota);putcrlf();
					memcpy(DLC_MatSPIRemainbufFota, fpt + DLC_MatSPIFlashPage * k ,DLC_MatSPIRemaindataFota);	/* 半端byte保持バッファに保持 */
					DLC_MatSPIWritePageFota = k + DLC_MatSPIWritePageFota;	/* SPI書込みページインデックス保持 */
//					putst("RemainData1:\r\n");Dump(DLC_MatSPIRemainbufFota, sizeof(DLC_MatSPIRemainbufFota));putcrlf();
#if 0
				} else {
					putst("RecvData2:\r\n");
#endif
				}
			} else {	/* ヘッダにConnection: closeあり=受信データ先頭 */
				DLCMatTimerClr( 0 );	// タイマー0クリア
				for (k = 0; k < 4; k++) {	/* SPI 256kbyte消去 */
					char line[32];
					W25Q128JV_eraseBlock64(((fotaaddress / 0x10000) + k), true);	/* 現状address:0～ 1ブロック64kbyte*/
					sprintf( line, "%02X0000:ERASE OK\r\n",(unsigned int)((fotaaddress / 0x10000) + k) );
					putst( line );
				}
				memset(DLC_MatSPIRemainbufFota, 0xFF, sizeof(DLC_MatSPIRemainbufFota));	/* 1ページ未満の半端byte保持バッファFF初期化 */
				DLC_MatSPIRemaindataFota = 0;
				DLC_MatWriteFotaDataLen = 0;
				fpt = strstr(DLC_MatResBuf,"Connection: close") + strlen("Connection: close\r\n\r\n");	/* FOTAデータの先頭アドレス */
				*(fpt - 1) = 0;	// strlenのため
				len = strlen(DLC_MatResBuf) + 1;	/* ヘッダのレングス */
				len += 8;	// サイズとチェックサムの8byte
putst("header len:");puthxw(len);putcrlf();
				recvlen -= len;
				DLC_MatFotaDataLen = *fpt;	// FOTAデータレングス
				fpt++;
				DLC_MatFotaDataLen |= *fpt << 8;
				fpt++;
				DLC_MatFotaDataLen |= *fpt << 16;
				fpt++;
				DLC_MatFotaDataLen |= *fpt << 24;
				fpt++;
				putst("DLC_MatFotaDataLen:");puthxw(DLC_MatFotaDataLen);putcrlf();
				memcpy(DLC_MatFotaCRC, fpt, sizeof(DLC_MatFotaCRC));
				fpt += 4;
				putst("DLC_MatFotaCRC[]:");Dump(DLC_MatFotaCRC, sizeof(DLC_MatFotaCRC));putcrlf();
//				if (j > 0) {	/* データが1024byte以上の場合 */
				if (1) {	/* Rmが0の場合もあり */
					if (j > 0) {	/* データが1024byte以上の場合 */
						putst("RecvData3:\r\n");
					} else {
						putst("RecvData4:\r\n");
					}
//					Dump(fpt, DLC_MatSPIFlashSector - len);putcrlf();
					fotaaddress /= DLC_MatSPIFlashPage;
					for (k = 0; k < ((DLC_MatSPIFlashSector - len) / DLC_MatSPIFlashPage); k++) {	/* ヘッダを抜いたFOTAデータを256byte毎書込み */
						if (recvlen < DLC_MatSPIFlashPage) {	/* データが1ページ未満? */
							break;
						}
						if (W25Q128JV_programPage(fotaaddress + k, 0, (uint8_t*)(fpt + DLC_MatSPIFlashPage * k), DLC_MatSPIFlashPage, true) == W25Q128JV_ERR_NONE ){
							puthxw(DLC_MatSPIFlashPage * (fotaaddress + k));
							putst(":OK");putcrlf();
							memset(DLC_MatSPICheckbufFota, 0, sizeof(DLC_MatSPICheckbufFota));
							if (W25Q128JV_readData(DLC_MatSPIFlashPage * (fotaaddress + k), (uint8_t*)DLC_MatSPICheckbufFota, DLC_MatSPIFlashPage) == W25Q128JV_ERR_NONE) {
								if (memcmp(DLC_MatSPICheckbufFota, (fpt + DLC_MatSPIFlashPage * k), DLC_MatSPIFlashPage) == 0) {
									putst("VERFY OK\r\n");
									DLC_MatWriteFotaDataLen += DLC_MatSPIFlashPage;
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
						recvlen -= DLC_MatSPIFlashPage;
					}
					memset(DLC_MatSPIRemainbufFota, 0xFF, sizeof(DLC_MatSPIRemainbufFota));	/* 半端byte保持バッファFF初期化 */
					DLC_MatSPIRemaindataFota = recvlen;	/* 1ページ未満の半端byte数 */
//					putst("DLC_MatSPIRemaindataFota3:");puthxs(DLC_MatSPIRemaindataFota);putcrlf();
					memcpy(DLC_MatSPIRemainbufFota, fpt + DLC_MatSPIFlashPage * k ,DLC_MatSPIRemaindataFota);	/* 半端byte保持バッファに保持 */
					DLC_MatSPIWritePageFota = k;	/* SPI書込みページインデックス保持 */
//					putst("RemainData3:\r\n");Dump(DLC_MatSPIRemainbufFota, sizeof(DLC_MatSPIRemainbufFota));putcrlf();
#if 0
				} else {	/* データが1024byte未満の場合(現状ありえない) */
					putst("RecvData4:\r\n");
//					Dump(fpt, i - len);putcrlf();
					fotaaddress /= DLC_MatSPIFlashPage;
					for (k = 0; k <= ((i - len) / DLC_MatSPIFlashPage); k++) {
						if (recvlen < DLC_MatSPIFlashPage) {	/* データが1ページ未満? */
							break;
						}
						if (W25Q128JV_programPage(fotaaddress + k, 0, (uint8_t*)(fpt + DLC_MatSPIFlashPage * k), DLC_MatSPIFlashPage, true) == W25Q128JV_ERR_NONE ){
							puthxw(DLC_MatSPIFlashPage * (fotaaddress + k));
							putst(":OK");putcrlf();
							memset(DLC_MatSPICheckbufFota, 0xFF, sizeof(DLC_MatSPICheckbufFota));
							if (W25Q128JV_readData(DLC_MatSPIFlashPage * (fotaaddress + k), (uint8_t*)DLC_MatSPICheckbufFota, DLC_MatSPIFlashPage) == W25Q128JV_ERR_NONE) {
								if (memcmp(DLC_MatSPICheckbufFota, (fpt + DLC_MatSPIFlashPage * k), DLC_MatSPIFlashPage) == 0) {
									putst("VERFY OK\r\n");
									DLC_MatWriteFotaDataLen += DLC_MatSPIFlashPage;
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
						recvlen -= DLC_MatSPIFlashPage;
					}
					DLC_MatSPIRemaindataFota = recvlen;	/* 1ページ未満の半端byte数 */
					DLC_MatSPIWritePageFota = k;	/* SPI書込みページインデックス保持 */
#endif
				}
			}
			DLC_MatResIdx = 0;
			return j;
		}
		else {
			putst("format err4\r\n");
			DLC_MatFotaWriteNG = true;
			return -4;
		}
	}
	else {
		putst("format err1\r\n");
		DLC_MatFotaWriteNG = true;
	}
	return -1;
}
void DLC_MatSPIFOTAerase()	// SPI最終セクタ消去
{
	int		fotaaddress=DLC_MatSPIFlashAddrFota;	/* FOTAデータ保存番地 */
	W25Q128JV_eraseSctor(((fotaaddress + 0x36000) / 0x1000) - 1, true);	/* 失敗なのでFOTAデータ最終セクタ消去(SPI Flash) */
}
