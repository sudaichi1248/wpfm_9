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
#include "DLCpara.h"
#define		DLC_PARAMETER_ADDRESS	0x3E000
#define		FIRM_SUM_ADDRESS		0x3DFFC
#define		FIRM_SUM_SECTOR			0x3DF00
DLC_Parameter 	DLC_Para;
void DLCParaRead()
{
	NVMCTRL_Read( (uint32_t *)&DLC_Para,sizeof( DLC_Para ),DLC_PARAMETER_ADDRESS );
}
void DLCParaSave()
{
	char	*tmp;
	tmp = (char*)&DLC_Para;
	NVMCTRL_RowErase( DLC_PARAMETER_ADDRESS );
	for(int i=0;i<256;i+=64 ){													/*  64byte����write */
		NVMCTRL_PageWrite( (uint32_t*)(tmp+i),FIRM_SUM_SECTOR+i );
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
	DLC_Para.FOTAact = 0;														/* FOTA�J�n�t���O */
	DLCParaSave();
	__NVIC_SystemReset();														/* ���u���Z�b�g */
}
/*
	FOTA�����Ń��Z�b�g
*/
void DLCFotaFinAndReset()
{
	DLC_Para.FOTAact = 0xFF;													/* FOTA�����t���O */
	DLCParaSave();
	DLCsumBreakAndReset();
}
