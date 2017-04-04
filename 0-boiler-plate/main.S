.NOLIST
#include "atmega128.def"
#include "utils.def"
.LIST

.global __main

.MACRO	toggle_led	led
	push	r16
	ldi	r16,	(1<<\led)
	out	PORTB,	r16
	pop	r16
.ENDM

.SECTION .text

__main: MAIN:
	ldi	r16,	0xFF
	out	DDRB,	r16
	toggle_led	7

MAIN_DONE:
	rjmp	MAIN_DONE
