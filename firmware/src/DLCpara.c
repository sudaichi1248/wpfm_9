/*
	DLC�F���i�֐�
	����Flash�̃f�[�^�A�ݒ�l�̓ǂݏo���A�ۑ�
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
#include "Moni.h"
#include "Eventlog.h"
#include "DLCpara.h"
#define		DLC_PARAMETER_ADDRESS	0x3E000
#define		FIRM_SUM_ADDRESS		0x3DFFC
#define		FIRM_SUM_SECTOR			0x3DF00
DLC_Parameter 	DLC_Para;
void	DLCMatRptLimit();
void DLCParaRead()
{
	NVMCTRL_Read( (uint32_t *)&DLC_Para,sizeof( DLC_Para ),DLC_PARAMETER_ADDRESS );
#ifdef BOARD_PROTOTYPE2
	DLC_Para.BatCarivFlg = 0;
#endif
}
void DLCParaSave()
{
	char	*tmp;
	tmp = (char*)&DLC_Para;
	NVMCTRL_RowErase( DLC_PARAMETER_ADDRESS );
	for(int i=0;i<256;i+=64 ){													/*  64byte����write */
		NVMCTRL_PageWrite( (uint32_t*)(tmp+i),DLC_PARAMETER_ADDRESS+i );
	}
}
int DLCParaVrfy()
{
	uchar		wk[256];
	NVMCTRL_Read( (uint32_t *)wk,sizeof( wk ),DLC_PARAMETER_ADDRESS );
	return memcmp( wk,&DLC_Para,sizeof( wk ));
}
/*
	SUM�������Z�b�g=����Boot�N��
*/
void DLCsumBreakAndReset()
{
	NVMCTRL_RowErase( FIRM_SUM_SECTOR );										/* �{�v��SUM���� */
	APP_delay(100);
	__NVIC_SystemReset();														/* ���u���Z�b�g */
}
/*
	FOTA�J�n�Ń��Z�b�g
*/
void DLCFotaGoAndReset()
{
	DLCEventLogWrite( _ID1_FOTA_START,0,0 );
	DLC_Para.FOTAact = 0;														/* FOTA�J�n�t���O */
	DLCParaSave();
	APP_delay(100);
	__NVIC_SystemReset();														/* ���u���Z�b�g */
}
/*
	FOTA�����Ń��Z�b�g
*/
void DLCFotaFinAndReset()
{
	DLCEventLogWrite( _ID1_FOTA_END,0,0 );
	DLC_Para.FOTAact = 0xFF;													/* FOTA�����t���O */
	DLCParaSave();
	DLCsumBreakAndReset();
}
/*
	FOTA���s�Ń��Z�b�g
*/
void DLCFotaNGAndReset(int state)
{
extern	uchar	DLC_Matfact,DLC_MatState;
	DLCEventLogWrite( _ID1_FOTA_FAIL,DLC_Matfact,DLC_MatState );
	DLC_Para.FOTAact = 0xFF;													/* FOTA�J�n�t���O */
	DLCParaSave();
	APP_delay(100);
	__NVIC_SystemReset();														/* ���u���Z�b�g */
}
void DLCMatUSBOK( char *resp )
{
	resp[0] = 0x02;
	resp[1] = '0';
	resp[2] = '0';
	resp[3] = '0';
	resp[4] = 'O';
	resp[5] = 'K';
	resp[6] = 0x03;
	resp[7] = 0x00;
	APP_printUSB(resp);
}
void DLCMatUSBNG( char *resp )
{
	resp[0] = 0x02;
	resp[1] = '0';
	resp[2] = '0';
	resp[3] = '3';
	resp[4] = 'N';
	resp[5] = 'G';
	resp[6] = '2';
	resp[7] = '0';
	resp[8] = '0';
	resp[9] = 0x03;
	resp[10] = 0x00;
	APP_printUSB(resp);
}
/*
	USB�����UPDATE�R�}���h
*/
void DLCMatUpdateGo(const char *param, char *resp)
{
    if (WPFM_operationMode == WPFM_OPERATION_MODE_NON_MEASUREMENT)
		DLCsumBreakAndReset();
	else
		DLCMatUSBNG( resp );
}
void DLCMatmlogBroke( const char *param, char *resp)
{
	if (WPFM_operationMode == WPFM_OPERATION_MODE_NON_MEASUREMENT)
		DLCMatUSBOK( resp );
	else
		DLCMatUSBNG( resp );
}
void DLCMatRepotLogChange(const char *param, char *resp)
{
	DLC_Para.ReportLog ^= 0xff;
	if( DLC_Para.ReportLog == 0 )
		putst( "ReportLog=On\r" );
	else
		putst( "ReportLog=Off\r" );
	DLCParaSave();
	DLCMatUSBOK( resp );
}
void DLCMatMeasureLogChange(const char *param, char *resp)
{
	DLC_Para.MeasureLog ^= 0xff;
	if( DLC_Para.MeasureLog == 0 )
		putst( "MeasureLog=On\r" );
	else
		putst( "MeasureLog=Off\r" );
	DLCParaSave();
	DLCMatUSBOK( resp );
}
void DLCMatDebugCmdChange(const char *param, char *resp)
{
	DLC_Para.DebugCmd ^= 0xff;
	if( DLC_Para.DebugCmd == 0 )
		putst( "DebugCmd=On\r" );
	else
		putst( "DebugCmd=Off\r" );
	DLCParaSave();
	DLCMatUSBOK( resp );
}
void DLCMatBatCarivChange(const char *param, char *resp)
{
    if (WPFM_operationMode != WPFM_OPERATION_MODE_NON_MEASUREMENT){
		DLCMatUSBNG( resp );
		return;
	}
	if( param[0] == '0' )
		DLC_Para.BatCarivFlg = 0;
	else
		DLC_Para.BatCarivFlg = 0xff;
	DLCParaSave();
	DLCMatUSBOK( resp );
}
/*
	ROM�ݒ�̃N���AT
*/
void DLCMatSettingClear(const char *p, char *resp)
{
    if (WPFM_operationMode != WPFM_OPERATION_MODE_NON_MEASUREMENT){
		DLCMatUSBNG( resp );
		return;
	}
	putst("The Parameter Deleted!\r\n");
	NVMCTRL_RowErase( 0x0003FE00 );				/* �ۑ��p�����[�^�폜 */
	DLCMatUSBOK( resp );
}
void DLCMatSetClock(const char *p, char *resp)
{
	RTC_DATETIME dt;
	dt.year   = (p[0]-'0')*10 + (p[1]-'0');
	dt.month  = (p[2]-'0')*10 + (p[3]-'0');
	dt.day	   = (p[4]-'0')*10 + (p[5]-'0');
	dt.hour   = (p[6]-'0')*10 + (p[7]-'0');
	dt.minute = (p[8]-'0')*10 + (p[9]-'0');
	dt.second = (p[10]-'0')*10 + (p[11]-'0');
	RTC_setDateTime( dt );
	putst("�����␳!\r\n");
	DLCMatUSBOK( resp );
}
void DLCMatGetClock(const char *param, char *resp)
{
	RTC_DATETIME 	dt;
	RTC_getDatetime( &dt );
	resp[0] = 0x02;
	resp[1] = '0';
	resp[2] = '1';
	resp[3] = '2';
	resp[4] = 'O';
	resp[5] = 'K';
	resp[6] = dt.year/10+'0';
	resp[7] = dt.year%10+'0';
	resp[8] = dt.month/10+'0';
	resp[9] = dt.month%10+'0';
	resp[10] = dt.day/10+'0';
	resp[11] = dt.day%10+'0';
	resp[12] = dt.hour/10+'0';
	resp[13] = dt.hour%10+'0';
	resp[14] = dt.minute/10+'0';
	resp[15] = dt.minute%10+'0';
	resp[16] = dt.second/10+'0';
	resp[17] = dt.second%10+'0';
	resp[18] = 0x03;
	resp[19] = 0x00;
	APP_printUSB(resp);
	DLCMatUSBOK( resp );
}
void DLCMatReportLmt(const char *p, char *resp)
{
	if (WPFM_operationMode != WPFM_OPERATION_MODE_NON_MEASUREMENT){
		DLCMatUSBNG( resp );
		return;
	}
	DLC_Para.Http_Report_max = ((p[0]-'0')*10000)+((p[1]-'0')*1000)+((p[2]-'0')*100)+((p[3]-'0')*10)+p[4]-'0';
	putst("ReportLmt=");putdech( DLC_Para.Http_Report_max );putcrlf();
	DLCParaSave();
	DLCMatRptLimit();
	DLCMatUSBOK( resp );
}
void DLCMatReportFlg(const char *param, char *resp)
{
	if (WPFM_operationMode == WPFM_OPERATION_MODE_NON_MEASUREMENT)
		DLCMatUSBOK( resp );
	else
		DLCMatUSBNG( resp );
}
void DLCMatEventLogClr(const char *param, char *resp)
{
	if (WPFM_operationMode != WPFM_OPERATION_MODE_NON_MEASUREMENT){
		DLCMatUSBNG( resp );
		return;
	}
	DLCEventLogClr(0);
	DLCMatUSBOK( resp );
}
void DLCMatCPower(const char *param, char *resp)
{
	if( param[0] == '1' )
		PORT_GroupWrite( PORT_GROUP_0,0x1<<12,-1 );		/* ON */
	else
		PORT_GroupWrite( PORT_GROUP_0,0x1<<12,0 );		/* OFF */
	DLCMatUSBOK( resp );
}
