void DLCMatSend( char *s );
void DLCMatTimerClr(int tmid );
void DLC_delay(int);
void DLCMatWgetFile();	// fota FOTAファイルwget
int DLCMatRecvWriteFota();	// fota FOTAデータ書込み処理
void DLCMatFOTAdataRcvFin();	// fota
void DLC_MatSPIFOTAerase();	// SPI最終セクタ消去

extern int		DLC_MatLineIdx;
extern char 	DLC_MatResBuf[1050];
extern int	 	DLC_MatResIdx;
extern uchar	DLC_MatLineBuf[2100];
extern bool		DLC_MatFotaWriteNG;	// fota FOTA書込みNGフラグ
extern char		DLC_MatSendBuff[1024*2+16];
