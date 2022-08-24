#include <stdio.h>
#include <stddef.h>                     // Defines NULL
#include <stdbool.h>                    // Defines true
#include <stdlib.h>                     // Defines EXIT_FAILURE
#include <ctype.h>
#include <string.h>                     // Defines EXIT_FAILURE
#define MAIN_VERSION "Ver 00.20 "
char 	_Main_version[32] = {MAIN_VERSION};
char *VerPrint()
{
	strcat( _Main_version,__DATE__ );
	strcat( _Main_version," " );
	strcat( _Main_version,__TIME__ );
	return _Main_version;
}
