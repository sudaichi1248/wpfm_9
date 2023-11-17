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

#define	 	DLC_MatSPIFlashAddrFota		0xB00000;	// SPI�t���b�V�������݃A�h���X

char *VerPrint();
static char http_tmp[512];

bool	DLC_MatFotaWriteNG=false;	// FOTA������NG�t���O
int	 	DLC_MatSPIFlashPage=0x100;	// SPI�t���b�V��1�y�[�Wbyte��
int	 	DLC_MatSPIFlashSector=0x400;	// SPI�t���b�V��1�Z�N�^byte��
int	 	DLC_MatSPIRemaindataFota;	// 1�y�[�W�����̔��[byte�����ێ����Ď��񏑍���
int	 	DLC_MatSPIWritePageFota;	// SPI�����݃y�[�W�C���f�b�N�X
int		DLC_MatFotaDataLen=0;	// FOTA�f�[�^�����O�X
int		DLC_MatWriteFotaDataLen=0;	// ������FOTA�f�[�^�����O�X
char	DLC_MatFotaCRC[4];	// FOTA�f�[�^�`�F�b�N�T��
char	DLC_MatSPIRemainbufFota[256];	// 1�y�[�W�����̔��[byte�ێ��o�b�t�@
char	DLC_MatSPICheckbufFota[256];	// �x���t�@�C�p�o�b�t�@
static	char wget_Head[] = "GET /DLC00/DLC01.bin HTTP/1.1\r\nHost:harvest-files.soracom.io\r\nUser-Agent: Wget\r\nConnection: close\r\n\r\n";	// FOTA�f�[�^�w��
//static	char wget_Head[] = "PUT HTTP/1.1\r\nHost: harvest-files.soracom.io\r\ncontent-type:text/plain\r\nContent-Length: \r\n\r\n";
// static char wget_Head[] = "GET /2048.bin HTTP/1.1\r\nHost:harvest-files.soracom.io\r\nUser-Agent: Wget\r\nConnection: close\r\n\r\n";
// static char wget_Head[] = "GET /1792.bin HTTP/1.1\r\nHost:harvest-files.soracom.io\r\nUser-Agent: Wget\r\nConnection: close\r\n\r\n";
// static char wget_Head[] = "GET /256.bin HTTP/1.1\r\nHost:harvest-files.soracom.io\r\nUser-Agent: Wget\r\nConnection: close\r\n\r\n";

//-----------------------------------------------------------------------------
// �ȉ��AFOTA���s����
//-----------------------------------------------------------------------------
void DLCMatWgetFile()
{
	char	tmp[48],n;
	int		i;
	putst("WgetExe!!!");putcrlf();
	strcpy( http_tmp,wget_Head );	/* soracom harvest��wget */
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
	int		fotaaddress=DLC_MatSPIFlashAddrFota;	/* FOTA�f�[�^�ۑ��Ԓn */
	APP_delay(100);
	DLC_MatLineIdx = 0;
	putst("RecvData2:\r\n");
	fotaaddress /= DLC_MatSPIFlashPage;
	if (DLC_MatSPIRemaindataFota != 0) {	/* ���[byte����̏ꍇ */
		if (W25Q128JV_programPage(fotaaddress + DLC_MatSPIWritePageFota, 0, (uint8_t*)DLC_MatSPIRemainbufFota, DLC_MatSPIFlashPage, true) == W25Q128JV_ERR_NONE ){	/* 256byte������ */
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
	if (DLC_MatFotaWriteNG == false) {	/* ������NG�Ȃ�? */
putst("length:");puthxw(DLC_MatFotaDataLen);putcrlf();
putst("writelength:");puthxw(DLC_MatWriteFotaDataLen);putcrlf();
putst("length(page):");puthxw(DLC_MatFotaDataLen / DLC_MatSPIFlashPage);putcrlf();
//		if (DLC_MatWriteFotaDataLen == ((DLC_MatFotaDataLen / DLC_MatSPIFlashPage) * DLC_MatSPIFlashPage)) {	/* �����݃����O�X=FOTA�f�[�^�����O�X(�y�[�W�P��)? */
		if (DLC_MatWriteFotaDataLen == DLC_MatFotaDataLen) {	/* �����݃����O�X=FOTA�f�[�^�����O�X? */
			memset(DLC_MatSPICheckbufFota, 0xFF, sizeof(DLC_MatSPICheckbufFota));
//			DLC_MatSPICheckbufFota[0xFC] = 0x04;
//			DLC_MatSPICheckbufFota[0xFD] = 0x03;
//			DLC_MatSPICheckbufFota[0xFE] = 0x02;
//			DLC_MatSPICheckbufFota[0xFF] = 0x01;
			memcpy(&DLC_MatSPICheckbufFota[0xFC], DLC_MatFotaCRC, sizeof(DLC_MatFotaCRC));
			putst("CheckData:\r\n");Dump(DLC_MatSPICheckbufFota, DLC_MatSPIFlashPage);putcrlf();
			if (W25Q128JV_programPage(fotaaddress + 0x35F, 0, (uint8_t*)DLC_MatSPICheckbufFota, DLC_MatSPIFlashPage, true) == W25Q128JV_ERR_NONE ){	/* �`�F�b�N�p256byte������ */
				DLCMatTimerClr( 4 );	/* �^�C�}�[�N���A */
				DLCMatTimerClr( 5 );	/* �^�C�}�[�N���A */
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
	W25Q128JV_eraseSctor(((fotaaddress * DLC_MatSPIFlashPage + 0x36000) / 0x1000) - 1, true);	/* ���s�Ȃ̂�FOTA�f�[�^�ŏI�Z�N�^����(SPI Flash) */
	DLC_delay(1000);
	DLCFotaNGAndReset();
}
int DLCMatRecvWriteFota()	// SPI�֎�M�f�[�^�����ݏ���
{
	char	*p,*q,*fpt,n;
	int		i,j=0,k,len,recvlen;
	int		fotaaddress=DLC_MatSPIFlashAddrFota;	/* FOTA�f�[�^�ۑ��Ԓn */
	if(( p = strstr( (char*)DLC_MatLineBuf,"$RECVDATA:" )) > 0 ){
		*p = 0;	// $RECVDATA:��$�폜
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
		recvlen = i;	/* ��M�f�[�^�����O�X */
		p = strchr( p,'\"' );
		if( p > 0 ){
			p++;
			q = strchr( p,'\"' );
			putst("1024=");puthxs(q-p);putcrlf();
//			if ((q-p) != (i*2)) {
//				Dump((char *)DLC_MatLineBuf,1128);putcrlf();
//			}
			memset(DLC_MatResBuf, 0xFF, sizeof(DLC_MatResBuf));	/* ��M�o�b�t�@FF������ */
			for( k=0;k<i;k++ ){
				n = inhex( *p++ )<<4;
				n += inhex( *p++ );
				DLC_MatResBuf[DLC_MatResIdx++] = n;
			}
//			DLC_MatResBuf[DLC_MatResIdx] = 0;
//			putst( DLC_MatResBuf );
			DLC_MatResIdx = 0;
//			if (strstr(DLC_MatResBuf,"Connection: close") == NULL) {	/* �w�b�_��Connection: close�Ȃ�=�擪�ȍ~�̎�M�f�[�^ */
			if (strstr(DLC_MatResBuf,"Content-Type: application/octet-stream") == NULL) {	/* �w�b�_��Connection: close�Ȃ�=�擪�ȍ~�̎�M�f�[�^ */
				fpt = DLC_MatResBuf;		/* ��M�o�b�t�@�̐擪�A�h���X */
				len = DLC_MatSPIRemaindataFota;	/* ���[byte�̃����O�X */
//				if (j > 0) {	/* Rm��0�ł�����͍ŏI�f�[�^�ł͂Ȃ� */
				if (1) {
					putst("RecvData1:\r\n");
//					Dump(DLC_MatResBuf,i);putcrlf();
					fotaaddress /= DLC_MatSPIFlashPage;
					if (DLC_MatSPIRemaindataFota != 0) {	/* ���[byte����̏ꍇ */
						if ((len  + recvlen) < DLC_MatSPIFlashPage) {	/* ���[byte�Ǝ�M�f�[�^�̘a��1�y�[�W����? */
							memcpy(&DLC_MatSPIRemainbufFota[DLC_MatSPIRemaindataFota], fpt ,recvlen);	/* �����M�f�[�^�Ŕ��[byte�ێ��o�b�t�@���߂� */
							DLC_MatSPIRemaindataFota = len  + recvlen;
putst("mjca2\r\n");
							return j;
						}
						memcpy(&DLC_MatSPIRemainbufFota[DLC_MatSPIRemaindataFota], fpt ,sizeof(DLC_MatSPIRemainbufFota) - DLC_MatSPIRemaindataFota);	/* �����M�f�[�^��256byte���߂� */
						if (W25Q128JV_programPage(fotaaddress + DLC_MatSPIWritePageFota, 0, (uint8_t*)DLC_MatSPIRemainbufFota, DLC_MatSPIFlashPage, true) == W25Q128JV_ERR_NONE ){	/* 256byte������ */
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
						recvlen = recvlen - (sizeof(DLC_MatSPIRemainbufFota) - DLC_MatSPIRemaindataFota);	/* ���[byte�ێ��o�b�t�@���߂��������� */
						fpt = &DLC_MatResBuf[sizeof(DLC_MatSPIRemainbufFota) - DLC_MatSPIRemaindataFota];	/* �����݃A�h���X�i�߂� */
						DLC_MatSPIWritePageFota += 1;	/* �����݃y�[�W�C���f�b�N�X�i�߂� */
//						putst("BufData1:\r\n");Dump(DLC_MatSPIRemainbufFota, sizeof(DLC_MatSPIRemainbufFota));putcrlf();
					}
					for (k = 0; k < ((DLC_MatSPIFlashSector - len) / DLC_MatSPIFlashPage); k++) {	/* �c��̃f�[�^��256byte�������� */
						if (recvlen < DLC_MatSPIFlashPage) {	/* �f�[�^��1�y�[�W����? */
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
					memset(DLC_MatSPIRemainbufFota, 0xFF, sizeof(DLC_MatSPIRemainbufFota));	/* ���[byte�ێ��o�b�t�@FF������ */
					DLC_MatSPIRemaindataFota = recvlen;	/* 1�y�[�W�����̔��[byte�� */
//					putst("DLC_MatSPIRemaindataFota1:");puthxs(DLC_MatSPIRemaindataFota);putcrlf();
					memcpy(DLC_MatSPIRemainbufFota, fpt + DLC_MatSPIFlashPage * k ,DLC_MatSPIRemaindataFota);	/* ���[byte�ێ��o�b�t�@�ɕێ� */
					DLC_MatSPIWritePageFota = k + DLC_MatSPIWritePageFota;	/* SPI�����݃y�[�W�C���f�b�N�X�ێ� */
//					putst("RemainData1:\r\n");Dump(DLC_MatSPIRemainbufFota, sizeof(DLC_MatSPIRemainbufFota));putcrlf();
#if 0
				} else {
					putst("RecvData2:\r\n");
#endif
				}
			} else {	/* �w�b�_��Connection: close����=��M�f�[�^�擪 */
				DLCMatTimerClr( 0 );	// �^�C�}�[0�N���A
				for (k = 0; k < 4; k++) {	/* SPI 256kbyte���� */
					char line[32];
					W25Q128JV_eraseBlock64(((fotaaddress / 0x10000) + k), true);	/* ����address:0�` 1�u���b�N64kbyte*/
					sprintf( line, "%02X0000:ERASE OK\r\n",(unsigned int)((fotaaddress / 0x10000) + k) );
					putst( line );
				}
				memset(DLC_MatSPIRemainbufFota, 0xFF, sizeof(DLC_MatSPIRemainbufFota));	/* 1�y�[�W�����̔��[byte�ێ��o�b�t�@FF������ */
				DLC_MatSPIRemaindataFota = 0;
				DLC_MatWriteFotaDataLen = 0;
				fpt = strstr(DLC_MatResBuf,"Connection: close") + strlen("Connection: close\r\n\r\n");	/* FOTA�f�[�^�̐擪�A�h���X */
				*(fpt - 1) = 0;	// strlen�̂���
				len = strlen(DLC_MatResBuf) + 1;	/* �w�b�_�̃����O�X */
				len += 8;	// �T�C�Y�ƃ`�F�b�N�T����8byte
putst("header len:");puthxw(len);putcrlf();
				recvlen -= len;
				DLC_MatFotaDataLen = *fpt;	// FOTA�f�[�^�����O�X
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
//				if (j > 0) {	/* �f�[�^��1024byte�ȏ�̏ꍇ */
				if (1) {	/* Rm��0�̏ꍇ������ */
					if (j > 0) {	/* �f�[�^��1024byte�ȏ�̏ꍇ */
						putst("RecvData3:\r\n");
					} else {
						putst("RecvData4:\r\n");
					}
//					Dump(fpt, DLC_MatSPIFlashSector - len);putcrlf();
					fotaaddress /= DLC_MatSPIFlashPage;
					for (k = 0; k < ((DLC_MatSPIFlashSector - len) / DLC_MatSPIFlashPage); k++) {	/* �w�b�_�𔲂���FOTA�f�[�^��256byte�������� */
						if (recvlen < DLC_MatSPIFlashPage) {	/* �f�[�^��1�y�[�W����? */
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
					memset(DLC_MatSPIRemainbufFota, 0xFF, sizeof(DLC_MatSPIRemainbufFota));	/* ���[byte�ێ��o�b�t�@FF������ */
					DLC_MatSPIRemaindataFota = recvlen;	/* 1�y�[�W�����̔��[byte�� */
//					putst("DLC_MatSPIRemaindataFota3:");puthxs(DLC_MatSPIRemaindataFota);putcrlf();
					memcpy(DLC_MatSPIRemainbufFota, fpt + DLC_MatSPIFlashPage * k ,DLC_MatSPIRemaindataFota);	/* ���[byte�ێ��o�b�t�@�ɕێ� */
					DLC_MatSPIWritePageFota = k;	/* SPI�����݃y�[�W�C���f�b�N�X�ێ� */
//					putst("RemainData3:\r\n");Dump(DLC_MatSPIRemainbufFota, sizeof(DLC_MatSPIRemainbufFota));putcrlf();
#if 0
				} else {	/* �f�[�^��1024byte�����̏ꍇ(���󂠂肦�Ȃ�) */
					putst("RecvData4:\r\n");
//					Dump(fpt, i - len);putcrlf();
					fotaaddress /= DLC_MatSPIFlashPage;
					for (k = 0; k <= ((i - len) / DLC_MatSPIFlashPage); k++) {
						if (recvlen < DLC_MatSPIFlashPage) {	/* �f�[�^��1�y�[�W����? */
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
					DLC_MatSPIRemaindataFota = recvlen;	/* 1�y�[�W�����̔��[byte�� */
					DLC_MatSPIWritePageFota = k;	/* SPI�����݃y�[�W�C���f�b�N�X�ێ� */
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
void DLC_MatSPIFOTAerase()	// SPI�ŏI�Z�N�^����
{
	int		fotaaddress=DLC_MatSPIFlashAddrFota;	/* FOTA�f�[�^�ۑ��Ԓn */
	W25Q128JV_eraseSctor(((fotaaddress + 0x36000) / 0x1000) - 1, true);	/* ���s�Ȃ̂�FOTA�f�[�^�ŏI�Z�N�^����(SPI Flash) */
}
