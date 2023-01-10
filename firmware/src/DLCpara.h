typedef struct {
	uchar	FOTAact;							/* FOTA���s�t���O,FOTA�J�n����0�ɂ���FOTA�I��(���s���܂�)FF�� */
	uchar	Server;								/* 0;karugamo�T�[�o�[ 0�ȊO=soracom */
	uchar	ReportLog;							/* 0;Report���O�����@ 0�ȊO=�����Ȃ�*/
	uchar	BatCarivFlg;						/* 0:�V������R  0�ȊO:��������R */
	int		Http_Report_max;					/* HTTP Report��MaxList�� */
	uchar	Http_Report_Hold;					/* Debug�p Report�ς݂𖢂̂܂܂ɂ��� */
	uchar	fix[247];						
} DLC_Parameter;
extern DLC_Parameter DLC_Para;
void DLCParaRead();
void DLCParaSave();
int DLCParaVrfy();
void DLCsumBreakAndReset();
void DLCFotaFineAndReset();
void DLCFotaGoAndReset();
void DLCFotaFinAndReset();
void DLCFotaNGAndReset();
void DLCMatVersion();
void DLCMatUpdateGo();
void DLCMatFotaGo();
void DLCMatServerChange();
void DLCMatEventLog(const char *param, char *resp);
void DLCMatRepotLogChange();
void DLCMatBatCarivChange();
void DLCMatSettingClear();
void DLCMatSetClock();
void DLCMatGetClock();
void DLCMatReportLmt(const char *param, char *resp);
void DLCMatReportFlg();
void DLCMatEventLogClr();
