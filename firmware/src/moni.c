#include	<ctype.h>
#include	<string.h>
#include	"moni.h"

#define  SP		0x20
#define  CR		0x0d
#define  LF		0x0a
#define  BS		0x08
#define  CAN	0x18
#define	 ESC	0x1b
#define	 TAB	0x09
#define	 BufLen	20
void	Mgets( char* );
void	Mdump( char*,int );
void	MdmpDsp( int );
void	Msbust( char* ),MsbustH( char* ),MsbustW( char* );
void	MsubDsp( void ),MsubDspH( void ),MsubDspW( void );
void	Minput( char* );
void	Moutput( char* );
void	Moutput2( void );
void	Mfillmem( char* );
int		Mstrlen( char* );
int		Minhex( char buf[],int	*len );
const char	msg_pronpt[] = "mon>";
/*--------------------------------------------------------------
	inhex( )ASSII->HEX
---------------------------------------------------------------*/
char inhex( char c )
{
	if (('0'<=c)&&(c<='9'))
		return( c-'0');
	if (('A'<=c)&&(c<='F'))
		return( c-'A'+0xa );
	if (('a'<=c)&&(c<='f'))
		return( c-'a'+0xa);
	return( 0xff );
}
/*--------------------------------------------------------------
	outhex( )HEX->ASSII
---------------------------------------------------------------*/
char outhex( char c )
{
	if (c<=9)
		return( c+'0');
	if ((10<=c)&&(c<=15))
		return( c-10+'A' );
	return( ' ' );
}
void putst( char *s )
{
	for(;*s;s++)
		putch(*s);
}
void puthxb( char n )
{
	putch(outhex( n>>4 ));
	putch(outhex( n&0x0f ));
}
void puthxs( short n )
{
	puthxb( (n>>8)&0xff );
	puthxb( n&0xff );
}
void puthxw( int n )
{
	puthxb( (n>>24)&0xff );
	puthxb( (n>>16)&0xff );
	puthxb( (n>>8)&0xff );
	puthxb( n&0xff );
}
/*--------------------------------------------------------------
	char2int( )ASCII->int
---------------------------------------------------------------*/
char *str2int( char *p,int *k )
{
	int	i;
	*k=0;
	for(i=0;i<5;i++){
		if( p[i] >= '0' && p[i] <= '9' ){
			*k *= 10;
			*k += p[i] - '0';
			continue;
		}
		else if ( p[i] == ' ' )
			continue;
		else if ( p[i] == '-' )
			continue;
		else if ( p[i] == ',' )
			break;
		else
			return p+i+1;
	}
	return p+i+1;
}
void Dump( char *s,int sz )
{
	int		i;
	for(i=0;i<sz;){
		puthxb(s[i++] );
		if((i%16)==0)
			putst("\r\n");
		else if((i%8)==0)
			putch(' ');
	}
	putst("\r\n");
}
void putcrlf()
{
	putst("\r\n");
}
/*-------------------------------
	32bit 16hex input
---------------------------------*/
int c_get32b( void )
{
	char c;
	int  r = 0 ;
	while( 1 ){
		c = getch() ;
		if ( c == 0x0d )
			return( r );
		if ( c == '#' )
			return( -1 );
		if (( c = inhex(c) ) == 0xff )
			return( r );
		r = ( r << 4 ) + c ;
	}
}
void Moni()
{
	char	line[BufLen];
	while(1){
		putcrlf();
		putst( (char*)msg_pronpt );	
		Mgets( line );
		switch( toupper(line[0] )){
		case 'D':
			Mdump( line,1 );
			break;
		case 'B':
			Mdump( line,0 );
			break;
		case 'S':
			Msbust( line );
			break;
		case 'H':
			MsbustH( line );
			break;
		case 'W':
			MsbustW( line );
			break;
		case 'F':
			Mfillmem( line );
			break;
		case '?':
			putst( (char*)"\r\nD:Dump Memory    { Address Size }..Little Endian\n\r" );
			putst( (char*)"B:Dump Memory    { Address Size }..Big Endian\n\r" );
			putst( (char*)"S:Substitute     { Address Value}　連続入力の場合はピリオドで中止\n\r" );
			putst( (char*)"H:16bit In/Out Memory { Address }\n\r" );
			putst( (char*)"W:32bit In/Out Memory { Address }\n\r" );
			putst( (char*)"F:Fill Memory    { Address Value Size}\n\r" );
			putst( (char*)"TAB:History\n\r" );
			break;
		case ESC:
			return;
		}
	}
}
/*--------------------------------------------------------------
	Mgets( )１行入力 
---------------------------------------------------------------*/
void Mgets( char *buf )
{
	int		i;
	char	c;
#define	HistBufMsk	3
#define	HistBufIdx	4
	static	char	histy[HistBufIdx][BufLen];
	static	int		hisix;
	static	int		hisixp;

	memset( buf,0,BufLen );		/* 0で埋める */
	for ( i = 0; i < BufLen ;){
		c = getch();		/* 1文字入力 */
		switch( c ){
		case CR:		/* ﾘﾀｰﾝｷｰ */
			memcpy( histy[hisix],buf,BufLen );	/* 学習ﾊﾞｯﾌｧに覚えておく */
			hisix++;
			hisix &= HistBufMsk;
			hisixp = hisix;
			return;
		case TAB:		/* ﾀﾌﾞｷｰ */
			hisixp--;
			hisixp &= HistBufMsk;
			memcpy( buf,histy[hisixp],BufLen );	/* 学習ﾊﾞｯﾌｧから読みだし */
			i = strlen( buf );		/* 終了文字を含まないﾚﾝｸﾞｽ */
			putch( CR );
			putst( (char*)"                                      " );
			putch( CR );
			putst( (char*)msg_pronpt );
			putst( buf );
			break;
		case BS:
			if ( i != 0 ){
				putch( BS );
				i--;
			}
			break;
		case ESC:		/* ESCｷｰ */
		case 0x00:		/* 0 */
			buf[0] = ESC;
			return;
		default:
//			putch( c );		/* ｴｺｰﾊﾞｯｸ */
			buf[i] = c;
			i++;
		}
	}
}
#define		GET_OK		0		/* 正常 */
#define		GET_END		1		/* キャンセル */
#define		GET_BLANK	2		/* 飛ばし */
/*--------------------------------------------------------------
	debug_cgethxb( )32bitHex入力 
---------------------------------------------------------------*/
int c_gethxw( int *val )
{
	uchar 		c;
	int			flg;
	*val = 0;
	flg = 0;
	while(1){
		c = getch() ;
		if ((( '0' <= c )&&( c <= '9' ))||(( 'A' <= c)&&( c <= 'F'))||(( 'a' <= c)&&( c <= 'f'))){
			putch( c ) ;
			c = inhex( c );
			*val = ( *val << 4 ) + c ;
			flg = 1;
		}
		else{
			switch( c ){
			case '.':			/* 入力終了,キャンセル */
			case 0x1b:
				return( GET_END );
			case 0x0d:	
				if ( flg == 0 )	/* 何も入力しないでリターン */
					return( GET_BLANK );
				return( GET_OK );
			default:
				return( GET_BLANK );
			}	
		}
	}
}
/*--------------------------------------------------------------
	c_gethxs( )16bitHex入力 
---------------------------------------------------------------*/
int c_gethxs( short *val )
{
	uchar 		c;
	int			flg;
	*val = 0;
	flg = 0;
	while(1){
		c = getch() ;
		if ((( '0' <= c )&&( c <= '9' ))||(( 'A' <= c)&&( c <= 'F'))||(( 'a' <= c)&&( c <= 'f'))){
			putch( c ) ;
			c = inhex( c );
			*val = ( *val << 4 ) + c ;
			flg = 1;
		}
		else{
			switch( c ){
			case '.':			/* 入力終了,キャンセル */
			case 0x1b:
				return( GET_END );
			case 0x0d:	
				if ( flg == 0 )	/* 何も入力しないでリターン */
					return( GET_BLANK );
				return( GET_OK );
			default:
				return( GET_BLANK );
			}	
		}
	}
}

/*--------------------------------------------------------------
	Mdump( )メモリーダンプコマンド
---------------------------------------------------------------*/
#define DefaultDmpSz	0x40
int	dmpadd,dmpsz;
void Mdump( char buf[],int flg )
{
	int		idx,len;
	idx = 1;
	dmpsz = DefaultDmpSz;				/* ダンプサイズのデフォルト */
	switch( buf[idx] ){
	case ' ':
		idx++;
		if ( buf[idx] != '\0' ){		/* ｱﾄﾞﾚｽ入力済み */
			dmpadd = Minhex( &buf[idx],&len ) & ~0x03;
			idx += len;
			if ( buf[idx] != 0 ){	/* ｻｲｽﾞ入力済み */
				dmpsz = Minhex( &buf[idx],&len );
				idx += len;
			}
			else{
				dmpsz = DefaultDmpSz;		/* ﾃﾞﾌｫﾙﾄ */
			}
		}
		MdmpDsp(flg);
		return;
	case '\0':
		MdmpDsp(flg);
		return;
	default:
		putst( (char*)"D {XXXXXXXX,XXXXXXXX} \n\r" );
	}
}
/*--------------------------------------------------------------
	MdmpDsp( )メモリダンプ表示
---------------------------------------------------------------*/
void MdmpDsp( int flg )
{
#ifdef	_PNCU
	int		cnt = 0;
#endif
	int		i,j;
	int		ln[4];
	char		c;
	j = 0;
	for ( i = 0; i < dmpsz ;i+=4,dmpadd += 4 ){
		if ( j == 0 ){
			putst((char*)"\n\r" );
			puthxw( dmpadd );putch( ':' );
		}
		if(flg)
			puthxw( *((int*)dmpadd ) );
		else
			Dump( (char *)dmpadd ,4 );
		ln[j++] = *((int*)dmpadd);
		putch( ' ' );
		if ( j == 4 ){			/* 1行分? */
			if(flg){
				for ( j = 0; j < 4; j++ ){	/* ASCII表示 */
					c = ln[j]>>24&0xff;
					putch( c );
					c = ln[j]>>16&0xff;
					putch( c );
					c = ln[j]>>8&0xff;
					putch( c );
					c = ln[j]&0xff;
					putch( c );
				}
			}
			else{
				for ( j = 0; j < 4; j++ ){	/* ASCII表示 */
					c = ln[j]&0xff;
					putch( c );
					c = ln[j]>>8&0xff;
					putch( c );
					c = ln[j]>>16&0xff;
					putch( c );
					c = ln[j]>>24&0xff;
					putch( c );
				}
			}
			j = 0;
		}
#ifdef _PNCU
		if( ++cnt >= 32 ){
			Xdelay(0);
			cnt = 0;
		}
#endif
	}
	if ( j != 0 ){			/* １行分なかったの半端部分のASCII表示 */
		for ( i = j; i < 4; i++ )
			putst( (char*)"         " );
		for ( i = 0; i < j; i++ ){	/* ASCII表示 */
			if(flg){
				c = ln[j]>>24&0xff;
				putch( c );
				c = ln[j]>>16&0xff;
				putch( c );
				c = ln[j]>>8&0xff;
				putch( c );
				c = ln[j]&0xff;
				putch( c );
			}
			else{
				c = ln[j]&0xff;
				putch( c );
				c = ln[j]>>8&0xff;
				putch( c );
				c = ln[j]>>16&0xff;
				putch( c );
				c = ln[j]>>24&0xff;
				putch( c );
			}
		}
		putst( (char*)"\n\r" );
	}
}
/*--------------------------------------------------------------
	Msbust( )メモリ置換コマンド
---------------------------------------------------------------*/
static int	subadd;
void Msbust( char *buf )
{
	int		idx,len,val;
	uchar	*p;
	idx = 1;
	switch( buf[idx] ){
	case ' ':
		idx++;
		if ( buf[idx] != '\0' ){		/* アドレス入力済み */
			subadd = Minhex( &buf[idx],&len );
			idx += len;
			if ( buf[idx] != 0 ){	/* 値入力済み */
				p = (uchar*)subadd;
				val = Minhex( &buf[idx],&len );
				*p = (uchar)val;
				return;
			}
		}
		MsubDsp();
		return;
	case '\0':
		MsubDsp();
		return;
	default:
		putst( (char*)"\n\rS XXXX XX\n\r" );
	}
}
/*--------------------------------------------------------------
	MsubDsp( )メモリ置換続けて出来る
---------------------------------------------------------------*/
void MsubDsp( void )
{
	int		val;
	char	*p;
	while( 1 ){
		p = (char*)subadd;
		val = *p;
		putcrlf();puthxw( subadd );putch( ':' );putch( ' ' );
		puthxb( (uchar)val );putch( ' ' );
		switch( c_gethxw( &val )){
		case GET_OK:
			*p = (uchar)val;
			break;
		case GET_END:
			return;
		case GET_BLANK:
			break;
		}
		subadd++;
	}
}
/*--------------------------------------------------------------
	Msbust( )メモリ置換コマンド
---------------------------------------------------------------*/
void MsbustH( char *buf )
{
	int		idx,len,val;
	short	*p;
	idx = 1;
	switch( buf[idx] ){
	case ' ':
		idx++;
		if ( buf[idx] != '\0' ){		/* アドレス入力済み */
			subadd = Minhex( &buf[idx],&len );
			idx += len;
			if ( buf[idx] != 0 ){	/* 値入力済み */
				p = (short*)subadd;
				val = Minhex( &buf[idx],&len );
				*p = (short)val;
				return;
			}
		}
		MsubDspH();
		return;
	case '\0':
		MsubDspH();
		return;
	default:
		putst( (char*)"\n\rS XXXX XX\n\r" );
	}
}
/*--------------------------------------------------------------
	MsubDspH( )メモリ置換続けて出来る
---------------------------------------------------------------*/
void MsubDspH( void )
{
	int		val;
	short	*p;
	while( 1 ){
		p = (short*)subadd;
		val = *p;
		putcrlf();puthxw( subadd );putch( ':' );putch( ' ' );
		puthxs( (short)val );putch( ' ' );
		switch( c_gethxs( (short *)&val )){
		case GET_OK:
			*p = (short)val;
			break;
		case GET_END:
			return;
		case GET_BLANK:
			break;
		}
		subadd+=2;
	}
}
/*--------------------------------------------------------------
	MsbustW( )メモリ置換コマンド
---------------------------------------------------------------*/
void MsbustW( char *buf )
{
	int		idx,len,val;
	long	*p;
	idx = 1;
	switch( buf[idx] ){
	case ' ':
		idx++;
		if ( buf[idx] != '\0' ){		/* アドレス入力済み */
			subadd = Minhex( &buf[idx],&len );
			idx += len;
			if ( buf[idx] != 0 ){	/* 値入力済み */
				p = (long*)subadd;
				val = Minhex( &buf[idx],&len );
				*p = (long)val;
				return;
			}
		}
		MsubDspW();
		return;
	case '\0':
		MsubDspW();
		return;
	default:
		putst( (char*)"\n\rW XXXXXXXX XXXXXXXX\n\r" );
	}
}
/*--------------------------------------------------------------
	MsubDspW( )メモリ置換続けて出来る
---------------------------------------------------------------*/
void MsubDspW( void )
{
	int		val;
	long	*p;
	while( 1 ){
		p = (long*)subadd;
		val = *p;
		putcrlf();puthxw( subadd );putch( ':' );putch( ' ' );
		puthxw( (long)val );putch( ' ' );
		switch( c_gethxw( &val )){
		case GET_OK:
			*p = (long)val;
			break;
		case GET_END:
			return;
		case GET_BLANK:
			break;
		}
		subadd+=4;
	}
}
/*--------------------------------------------------------------
	Minput( ) I/O Input
---------------------------------------------------------------*/
static	uint	*ioadd;
void Minput( char *buf )
{
	int		idx,len;
	idx = 1;
	if ( buf[idx] == ' ' ){
		idx++;
	}
	if ( buf[idx] != '\0' ){		/* ｱﾄﾞﾚｽ入力済み */
		ioadd = (uint*)Minhex( &buf[idx],&len );
		putch( ' ' );
		puthxw( *ioadd );
		return;
	}
}
/*--------------------------------------------------------------
	Moutput( )I/O Port Out
---------------------------------------------------------------*/
void Moutput( char *buf )
{
	int		idx,len;
	idx = 1;
	if ( buf[idx] == ' ' ){
		idx++;
	}
	if ( buf[idx] != '\0' ){		/* ｱﾄﾞﾚｽ入力済み */
		ioadd = (uint*)Minhex( &buf[idx],&len );
		idx += len;
		if ( buf[idx] != '\0' ){	/* 値入力済み */
			*ioadd = Minhex( &buf[idx],&len );
			return;
		}
	}
	Moutput2();
}
/*--------------------------------------------------------------
	Moutput2( ) I/O Port Out 続けてできる
---------------------------------------------------------------*/
void Moutput2( void )
{
	int	val;
	while( 1 ){
		putcrlf();puthxw( (uint)ioadd );putch( ' ' );puthxw( *ioadd );putch( ' ' );
		switch( c_gethxw( &val )){
		case GET_OK:
			*ioadd = val;
			break;
		case GET_END:
			return;
		case GET_BLANK:
			break;
		}
	}
}
/*--------------------------------------------------------------
	Mfillmem( ) Fillコマンド
---------------------------------------------------------------*/
void Mfillmem( char *buf )
{
	int		idx,len;
	char	val;
	int		add,sz;
	idx = 1;
	if ( buf[idx] == ' ' ){
		idx++;
		if ( buf[idx] != '\0' ){/* ｱﾄﾞﾚｽ入力? */
			add = Minhex( &buf[idx],&len );
			idx += len;
			if ( buf[idx] != '\0' ){	/* 値入力? */
				val = Minhex( &buf[idx],&len );
				idx += len;
				if ( buf[idx] != '\0' ){	/* ｻｲｽﾞ入力? */
					sz = Minhex( &buf[idx],&len );
                    memset( (void*)add,val,sz );
					return;
				}
			}
		}
	}
	putst( (char*)"\n\rF XXXXXXXX XX XXXXXXXXX\n\r" );
}
/*--------------------------------------------------------------
	Minhex( ) 文字列->Hex変換（文字列の終了は0 ' ',':',','である)
---------------------------------------------------------------*/
int Minhex( char buf[],int	*len )
{
	int		i,val;
	val = 0;
	for( i = 0;; i++ ){
		if ( buf[i] == 0 )
			break;
		if (( buf[i] == ' ' )||( buf[i] == ':' )||( buf[i] == ',' ))
			break;
		val <<= 4;
		val |= inhex( buf[i] );
	}
	*len = i+1;
	return( val );
}
