typedef struct {
	uchar	FOTAact;							/* FOTA���s�t���O,FOTA�J�n����0�ɂ���FOTA�I��(���s���܂�)FF�� */
	uchar	Server;								/* 0;karugamo�T�[�o�[ 0�ȊO=soracom */
	uchar	ReportLog;							/* 0;Report���O�����@ 0�ȊO=�����Ȃ�*/
	uchar	BatCarivFlg;						/* 0:�V������R  0�ȊO:��������R */
	uchar	fix[252];						
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
void DLCMatEventLog();
void DLCMatRepotLogChange();
void DLCMatBatCarivChange();
void DLCMatSettingClear();
void DLCMatSetClock();
void DLCMatGetClock();
