void DLCMatSend( char *s );
void DLCMatTimerClr(int tmid );
void DLC_delay(int);
void DLCMatWgetFile();	// fota FOTA�t�@�C��wget
int DLCMatRecvWriteFota();	// fota FOTA�f�[�^�����ݏ���
void DLCMatFOTAdataRcvFin();	// fota
void DLC_MatSPIFOTAerase();	// SPI�ŏI�Z�N�^����

extern int		DLC_MatLineIdx;
extern char 	DLC_MatResBuf[1050];
extern int	 	DLC_MatResIdx;
extern uchar	DLC_MatLineBuf[2100];
extern bool		DLC_MatFotaWriteNG;	// fota FOTA������NG�t���O
extern char		DLC_MatSendBuff[1024*2+16];
