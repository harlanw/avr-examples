;;
;; @file   - startup.S
;; @author - Harlan Waldrop <waldroha@oregonstate.edu>
;;

.NOLIST
#include "atmega128.def"
#include "utils.def"
.LIST

;;
;; @define - Vector Table
;; @description - Contains vector table definitions for the program.
;; @remarks - 
;; 	This section is placed into the "vectors" section by LD. This is required
;; 	for the vector table to be properly placed into the beginning of the text
;; 	section. Without this directive the "ORG" directive will be ignored depending
;; 	on the order of files passed to GCC, i.e., "gcc file1.S.o file2.S.o startup.S.o,"
;; 	will not place this table at location 0x00 but after the first two files.
;;
.SECTION .vectors
.ORG 0x0000

vector_table:;	Function		Addr.	Src.	Def.
	jmp	_INIT			; $00	RESET	Reset
	jmp	__xint0_handler		; $02	INT0	Ext. Interrupt 0
	jmp	__xint1_handler		; $04	INT1	Ext. Interrupt 1
	jmp	__xint2_handler		; $06	INT2	Ext. Interrupt 2
	jmp	__xint3_handler		; $08	INT3	Ext. Interrupt 3
	jmp	__xint4_handler		; $0A	INT4	Ext. Interrupt 4
	jmp	__xint5_handler		; $0C	INT5	Ext. Interrupt 5
	jmp	__xint6_handler		; $0E	INT6	Ext. Interrupt 6
	jmp	__xint7_handler		; $10	INT7	Ext. Interrupt 7
.ORG 0x0046

.SECTION .text

;;
;; @function - _init
;; @description -
;; 	Initializes the stack pointer and LCD variables before launching into MAIN
;;
_INIT:
	ldi 	r16,	LOW(RAMEND)
	out 	SPL,	r16
	ldi 	r16,	HIGH(RAMEND)
	out 	SPH,	r16

	jmp __main

;;
;; @function - _def_int_handler
;; @description - Default interrupt handler for all external interrupts.
;;
_def_int_handler:
	reti

.WEAK	__xint0_handler, __xint1_handler, __xint2_handler, __xint3_handler
.WEAK	__xint4_handler, __xint5_handler, __xint6_handler, __xint7_handler
.SET	__xint0_handler, _def_int_handler
.SET	__xint1_handler, _def_int_handler
.SET	__xint2_handler, _def_int_handler
.SET	__xint3_handler, _def_int_handler
.SET	__xint4_handler, _def_int_handler
.SET	__xint5_handler, _def_int_handler
.SET	__xint6_handler, _def_int_handler
.SET	__xint7_handler, _def_int_handler
