#include <stdio.h>
#include <stddef.h>                     // Defines NULL
#include <stdbool.h>                    // Defines true
#include <stdlib.h>                     // Defines EXIT_FAILURE
#include <ctype.h>
#include <string.h>                     // Defines EXIT_FAILURE
#include "definitions.h"                // SYS function prototypes
#include "moni.h" 
#include "gpioexp.h" 
#include "w25q128jv.h"
char *VerPrint();
bool command_getch(char * character_p)
{
	bool result = false;
	if (APP_readUSB( (uint8_t*)character_p, 1)) {
		result = true;
	}
	return result;
}
bool command_putch(char character)
{
	bool result = false;
	if (APP_writeUSB( (uint8_t const*)&character, 1)) {
	    result = true;
	}
	return result;
}
#define command_COMMAND_BUFFER_SIZE 128
typedef struct {
    int write_index;
    int read_index;
    char buffer[command_COMMAND_BUFFER_SIZE];
} command_command;
static command_command s_command_command;
//-----------------------------------------------------------------------------
// 受信バッファから1Line取得
//-----------------------------------------------------------------------------
bool command_sci_get_line(void)
{
	char c;
	bool result = false;
	while (command_getch(&c) == true) {
		command_putch(c);
		if (c == '\n') {				// ラインフィード(無視)
			continue;
		}
		if (c == '\b') {				// バックスペース
			if (s_command_command.write_index) {
				s_command_command.write_index--;
			}
			continue;
		}
		s_command_command.buffer[s_command_command.write_index++] = toupper(c);
		if (c == '\r') {				// コマンド検出
			s_command_command.buffer[s_command_command.write_index] = 0x00; 
			s_command_command.write_index = 0;
			result = true;
			break;
		}
	}
	return result;
}
void command_software_reset(void)
{
	NVMCTRL_RowErase( 0x8000 );
#if 1
	uint32_t app_start_address;
	app_start_address = *(uint32_t *) (4);
	SYS_INT_Disable(); /* 割り込み禁止 */
	/* Rebase the Stack Pointer */
	__set_MSP(*(uint32_t *) 0);
	/* Rebase the vector table base address */
	SCB->VTOR = ((uint32_t) 0);
	/* Jump to application Reset Handler in the application */
	asm("bx %0"::"r"(app_start_address));
#else
	__NVIC_SystemReset();
#endif
}
void command_main(void)
{
	unsigned char *p;
	p = (unsigned char*)0x20007fff;
	while (command_sci_get_line() == true) {   // コマンドバッファから１line取得
		if (strcmp(s_command_command.buffer , "!!DOWNLOADFIRM\r") == 0) {
			*p = 1;
			APP_printlnUSB("\r\nOK\r\n");
			command_software_reset();
			break;
		}
		if (strcmp(s_command_command.buffer , "!!DOWNLOADBOOT\r") == 0) {
			*p = 2;
			APP_printlnUSB("\r\nOK\r\n");
			command_software_reset();
			break;
		}
		if (strcmp(s_command_command.buffer , "!!VERSION\r") == 0) {
			APP_printlnUSB( VerPrint() );
			break;
		}
		if (strcmp(s_command_command.buffer , "!!RESET\r") == 0) {
			APP_printlnUSB("\r\nOK\r\n");
			command_software_reset();
			break;
		}
		if (memcmp(s_command_command.buffer , "AT", 2) == 0) {
			APP_printlnUSB("\r\nOK\r\n");
			break;
		}
	}
}
