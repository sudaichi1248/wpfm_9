typedef unsigned char uchar;
typedef unsigned int uint;
typedef unsigned short ushort;
char inhex( char c );
char outhex( char c );
void putch( char c );
void putst( char *s );
void puthxb( char n );
void puthxs( short n );
void puthxw( int n );
void putdecw( uint n );
void putdech( uint n );
void putdecs( uint n );
void Dump( char *s,int sz );
char getch();
void putcrlf();
int c_get32b( void );
char *str2int( char *p,int *k );
