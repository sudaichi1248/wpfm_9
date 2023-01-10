typedef struct {
	uchar	FOTAact;							/* FOTA実行フラグ,FOTA開始時に0にしてFOTA終了(失敗も含む)FFへ */
	uchar	Server;								/* 0;karugamoサーバー 0以外=soracom */
	uchar	ReportLog;							/* 0;Reportログだす　 0以外=ださない*/
	uchar	BatCarivFlg;						/* 0:新分圧抵抗  0以外:旧分圧抵抗 */
	int		Http_Report_max;					/* HTTP ReportのMaxList数 */
	uchar	Http_Report_Hold;					/* Debug用 Report済みを未のままにする */
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
