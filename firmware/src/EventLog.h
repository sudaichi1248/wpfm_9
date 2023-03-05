#define EVENTLOG_SPI

typedef struct	{											/* イベントログ				*/
	unsigned int	second;
	unsigned short	mSecond;
	unsigned short	ID1;
	unsigned int	ID2;
	unsigned int	ID3;
} _EventLog;
#ifdef EVENTLOG_SPI
#define EVENT_LOG_AREA_ADDRESS_START        0xC00000	// SPIフラッシュ書込みアドレス
#define EVENT_LOG_AREA_ADDRESS_END	        0xFF0000
//#define EVENT_LOG_AREA_ADDRESS_END	        0xC01000
#define EVENT_LOG_AREA_WRITE_SZ				sizeof(_EventLog)
#define EVENT_LOG_AREA_ERASE_SZ				0x001000
#define EVENT_LOG_AREA_BLOCK_SZ				0x010000
#define	EVENT_LOG_NUMOF_ITEM 	((EVENT_LOG_AREA_ADDRESS_END-EVENT_LOG_AREA_ADDRESS_START)/sizeof(_EventLog))
#else
#define EVENT_LOG_AREA_ADDRESS_START        0x3E200
#define EVENT_LOG_AREA_ADDRESS_END	        0x3FD00
#define EVENT_LOG_AREA_WRITE_SZ				0x00040
#define EVENT_LOG_AREA_ERASE_SZ				0x00100
#define EVENT_LOG_AREA_BLOCK_MSK			0xFFFC0
#define	EVENT_LOG_NUMOF_ITEM 	((EVENT_LOG_AREA_ADDRESS_END-EVENT_LOG_AREA_ADDRESS_START)/sizeof(_EventLog))
#endif
void DLCEventLogInit( void );
void DLCEventLogWrite( ushort ID1,uint ID2,uint ID3 );
void DLCEventLogDisplay( void );
void DLCEventLogClr( int );
/* ID1 discribe */
#define		_ID1_POWER_START			0x0001
#define		_ID1_SYS_START				0x0002
#define		_ID1_SYS_ERROR				0x0003
#define		_ID1_MAT_VERSION			0x0008
#define		_ID1_OPEN_OK				0x0100
#define		_ID1_FACTORY_TEST			0x1000
#define		_ID1_FLASH_ERROR_W			0x1010
#define		_ID1_SYS_SUSPEND			0x01F0
#define		_ID1_SYS_RESUME				0x01F1
#define		_ID1_USIM_STS				0x0101
#define		_ID1_USIM_CNUM				0x0102
#define		_ID1_ALERT1					0x0103
#define		_ID1_ALERT2					0x0104
#define		_ID1_USB_CMD_OKNG			0x1020
#define		_ID1_FOTA_START				0x1021
#define		_ID1_FOTA_END				0x1022
#define		_ID1_ONLINE_UPD_B_START		0x1023
#define		_ID1_ONLINE_UPD_B_END		0x1024
#define		_ID1_CONNECT				0x0110
#define		_ID1_HTTP_OK				0x0111
#define		_ID1_HTTP_RES				0x0112
#define		_ID1_CONN_NG				0x0113
#define		_ID1_REPORTRET				0x0120
#define		_ID1_REPORT   				0x0130
#define		_ID1_SLEEP	 				0x0140
#define		_ID1_CELLACT 				0x0200
#define		_ID1_WATCHDOG_START			0x1030
#define		_ID1_ERROR					0x1031
#define		_ID1_SEREAL_NOISE			0x1032
#define		_ID1_MANTE_START			0x1033
#define		_ID1_INIT_ALL				0x1034
#define		_ID1_VBAT_DRIVE				0x1035
