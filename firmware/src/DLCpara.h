typedef struct {
	uchar	FOTAact;							/* FOTA���s�t���O,FOTA�J�n����0�ɂ���FOTA�I��(���s���܂�)FF�� */
	uchar	Server;								/* 0;karugamo�T�[�o�[ 0�ȊO=soracom */
	uchar	ReportLog;							/* 0;Report���O�����@ 0�ȊO=�����Ȃ�*/
	uchar	fix[253];						
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
