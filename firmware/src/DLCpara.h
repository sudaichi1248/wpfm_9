typedef struct {
	uchar	FOTAact;							/* FOTA実行フラグ,FOTA開始時に0にしてFOTA終了(失敗も含む)FFへ */
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
