typedef struct {
	uchar	FOTAact;							/* FOTA���s�t���O,FOTA�J�n����0�ɂ���FOTA�I��(���s���܂�)FF�� */
	uchar	fix[255];						
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
