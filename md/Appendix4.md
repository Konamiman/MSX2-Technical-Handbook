# APPENDIX 4 - WORK AREA LISTING

<p>&nbsp;</p>

## Index

[Subroutines for read/write calls of the inter-slot](#subroutines-for-readwrite-calls-of-the-inter-slot)

[Starting address of assembly language program of USR function, text screen](#starting-address-of-assembly-language-program-of-usr-function-text-screen)

[Work for initialisation](#work-for-initialisation)

[Area to save VDP registers](#area-to-save-vdp-registers)

[Work area for PLAY statement](#work-area-for-play-statement)

[Work area for key input](#work-area-for-key-input)

[Parameters for Cassette](#parameters-for-cassette)

[Work used by BASIC internally](#work-used-by-basic-internally)

[Work for user function parameter](#work-for-user-function-parameter)

[Work for Math-Pack](#work-for-math-pack)

[Data area used by BASIC interpreter](#data-area-used-by-basic-interpreter)

[Data area used by CIRCLE statement](#data-area-used-by-circle-statement)

[Data area used in PAINT statement](#data-area-used-in-paint-statement)

[Data area used in PLAY statement](#data-area-used-in-play-statement)

[Work area added in MSX2](#work-area-added-in-msx2)

[Data area used by RS-232C](#data-area-used-by-rs-232c)

[Data area used by DOS](#data-area-used-by-dos)

[Data area used by PLAY statement](#data-area-used-by-play-statement)

[Data area](#data-area)

[Hooks](#hooks)

[Changes from the original](#changes-from-the-original)


<p>&nbsp;</p>

[Figure A.5](#figure-a5--work-area) shows the map of the MSX2 work area. In this section, the system work area and hook from F380H to FFCAH in the figure are described. The following notation is used. Length is in bytes.

**Label name (address, length)**

* Initial value, contents, purpose


##### _Figure A.5  Work area_

```
FFFF    ---------------------------
        | slot selection register |
FFFC    |-------------------------|
        |         reserved        |
FFF8    |-------------------------|
FFF7    |  MAIN-ROM slot address  |
        |-------------------------|
        |  register reservation   |
        |      area for new       |
FFE7    |       VDP (9938)        |
        |-------------------------|
        |       program for       |
FFCA    |  expansion BIOS calls   |
        |-------------------------|
        |                         |
        |       hook area         |
FD9A    |                         |
        |-------------------------|
        |                         |
        |    system work area     |
F380    |                         |
        ---------------------------
```


<p>&nbsp;</p>

## Subroutines for read/write calls of the inter-slot

#### RDPRIM (F380H, 5)
* **contents**: read from basic slot

#### WRPRIM (F385H, 7)
* **contents**: write to basic slot

#### CLPRIM (F38CH, 14)
* **contents**: basic slot call


<p>&nbsp;</p>

## Starting address of assembly language program of USR function, text screen

#### USRTAB (F39AH, 20)
* **initial value**: FCERR
* **contents**: starting address of assembly language program of USR function (0 to 9); the value before defining assembly language program points to FCERR (475AH).

#### LINL40 (F3AEH, 1)
* **initial value**: 39
* **contents**: screen width per line at SCREEN 0 (set by WIDTH statement at SCREEN 0)

#### LINL32 (F3AFH, 1)
* **initial value**: 32
* **contents**: screen width per line at SCREEN 1 (set by WIDTH statement at SCREEN 1)

#### LINLEN (F3B0H, 1)
* **initial value**: 29
* **contents**: current screen width per line

#### CRTCNT (F3B1H, 1)
* **initial value**: 24
* **contents**: number of lines of current screen

#### CLMLST (F3B2H, 1)
* **initial value**: 14
* **contents**: horizontal location in the case that items are divided by commas in PRINT statement



<p>&nbsp;</p>

## Work for initialisation


### SCREEN 0


#### TXTNAM (F3B3H, 2)
* **initial value**: 0000H
* **contents**: pattern name table

#### TXTCOL (F3B5H, 2)
* **contents**: unused

#### TXTCGP (F3B7H, 2)
* **initial value**: 0800H
* **contents**: pattern generator table

#### TXTATR (F3B9H, 2)
* **contents**: unused

#### TXTPAT (F3BBH, 2)
* **contents**: unused


<p>&nbsp;</p>

### SCREEN 1

#### T32NAM (F3BDH, 2)
* **initial value**: 1800H
* **contents**: pattern name table

#### T32COL (F3BFH, 2)
* **initial value**: 2000H
* **contents**: colour table

#### T32CGP (F3C1H, 2)
* **initial value**: 0000H
* **contents**: pattern generator table

#### T32ATR (F3C3H, 2)
* **initial value**: 1B00H
* **contents**: sprite attribute table

#### T32PAT (F3C5H, 2)
* **initial value**: 3800H
* **contents**: sprite generator table


<p>&nbsp;</p>

### SCREEN 2


#### GRPNAM (F3C7H, 2)
* **initial value**: 1800H
* **contents**: pattern name table

#### GRPCOL (F3C9H, 2)
* **initial value**: 2000H
* **contents**: colour table

#### GRPCGP (F3CBH, 2)
* **initial value**: 0000H
* **contents**: pattern generator table

#### GRPATR (F3CDH, 2)
* **initial value**: 1B00H
* **contents**: sprite attribute table

#### GRPPAT (F3CFH, 2)
* **initial value**: 3800H
* **contents**: sprite generator table


<p>&nbsp;</p>

### SCREEN 3


#### MLTNAM (F3D1H, 2)
* **initial value**: 0800H
* **contents**: pattern name table

#### MLTCOL (F3D3H, 2)
* **contents**: unused

#### MLTCGP (F3D5H, 2)
* **initial value**: 0000H
* **contents**: pattern generator table

#### MLTATR (F3D7H, 2)
* **initial value**: 1B00H
* **contents**: sprite attribute table

#### MLTPAT (F3D9H, 2)
* **initial value**: 3800H
* **contents**: sprite generator table


<p>&nbsp;</p>

### Other screen settings


#### CLIKSW (F3DBH, 1)
* **initial value**: 1
* **contents**: key click switch (0 = OFF, otherwise = ON), set by `<key click switch>` of SCREEN statement

#### CSRY (F3DCH, 1)
* **initial value**: 1
* **contents**: Y-coordinate of cursor

#### CSRX (F3DDH, 1)
* **initial value**: 1
* **contents**: X-coordinate of cursor

#### CNSDFG (F3DEH, 1)
* **initial value**: 0
* **contents**: function key display switch (0 = display, otherwise = no display), set by KEY ON/OFF statement


<p>&nbsp;</p>

## Area to save VDP registers


#### RG0SAV (F3DFH, 1)
* **initial value**: 0

#### RG1SAV (F3E0H, 1)
* **initial value**: E0H

#### RG2SAV (F3E1H, 1)
* **initial value**: 0

#### RG3SAV (F3E2H, 1)
* **initial value**: 0

#### RG4SAV (F3E3H, 1)
* **initial value**: 0

#### RG5SAV (F3E4H, 1)
* **initial value**: 0

#### RG6SAV (F3E5H, 1)
* **initial value**: 0

#### RG7SAV (F3E6H, 1)
* **initial value**: 0

#### STATFL (F3E7H, 1)
* **initial value**: 0
* **contents**: stores VDP status (contents of status register 0, in MSX2)

#### TRGFLG (F3E8H, 1)
* **initial value**: FFH
* **contents**: stores trigger button status of joystick

#### FORCLR (F3E9H, 1)
* **initial value**: 15
* **contents**: foreground colour; set by colour statement

#### BAKCLR (F3EAH, 1)
* **initial value**: 4
* **contents**: background colour; set by colour statement

#### BDRCLR (F3EBH, 1)
* **initial value**: 7
* **contents**: border colour; set by colour statement

#### MAXUPD (F3ECH, 3)
* **initial value**: JP 0000H (C3H, 00H, 00H)
* **contents**: used by CIRCLE statement internally

#### MINUPD (F3EFH, 3)
* **initial value**: JP 0000H (C3H, 00H, 00H)
* **contents**: used by CIRCLE statement internally

#### ATRBYT (F3F2H, 1)
* **initial value**: 15
* **contents**: colour code in using graphics


<p>&nbsp;</p>

## Work area for PLAY statement


#### QUEUES (F3F3H, 2)
* **initial value**: QUETAB (F959H)
* **contents**: points to queue table at the execution of PLAY statement

#### FRCNEW (F3F5H)
* **initial value**: 255
* **contents**: used by BASIC interpreter internally


<p>&nbsp;</p>

## Work area for key input


#### SCNCNT (F3F6H, 1)
* **initial value**: 1
* **contents**: interval for the key scan

#### REPCNT (F3F7H, 1)
* **initial value**: 50
* **contents**: delay until the auto-repeat of the key begins

#### PUTPNT (F3F8H, 2)
* **initial value**: KEYBUF (FBF0H)
* **contents**: points to address to write in the key buffer

#### GETPNT (F3FAH, 2)
* **initial value**: KEYBUF (FBF0H)
* **contents**: points to address to read from key buffer


<p>&nbsp;</p>

## Parameters for Cassette


<p>&nbsp;</p>

#### CS120 (F3FCH, 5*2)
  * **contents**:
    * 1200 baud:
      * 83 (LOW01): Low width representing bit 0
      * 92 (HIGH01): High width representing bit 0
      * 38 (LOW11): Low width representing bit 1
      * 45 (HIGH11): High width representing bit 1
      * HEADLEN * 2/256: High bytes (HEDLEN = 2000) of header bits for short header
    * 2400 baud
      * 37 (LOW02): Low width representing bit 0
      * 45 (HIGH02): High width representing bit 0
      * 14 (LOW12): Low width representing bit 1
      * 22 (HIGH12): High width representing bit 1
      * HEADLEN * 4/256: High bytes (HEDLEN = 2000) of header bits for short header

#### LOW (F406H, 2)
* **initial value**: LOW01, HIGH01 (by default, 1200 baud)
* **contents**: width of LOW and HIGH which represents bit 0 of current baud rate; set by `<cassette baud rate>` of SCREEN statement

#### HIGH (F408H, 2)
* **initial value**: LOW11, HIGH11 (by default, 1200 baud)
* **contents**: width of LOW and HIGH which represents bit 1 of current baud rate; set by `<cassette baud rate>` of SCREEN statement

#### HEADER (F40AH, 1)
* **initial value**: HEADLEN * 2/256 (by default, 1200 baud)
* **contents**: header bit for the short header of current baud rate (HEADLEN = 2000); set by `<cassette baud rate>` of SCREEN statement

#### ASPCT1 (F40BH, 1)
* **contents**: 256/aspect ratio; set by SCREEN statement to use in CIRCLE statement

#### ASPCT2 (F40DH, 1)
* **contents**: 256 * aspect ratio; set by SCREEN statement to use in CIRCLE statement

#### ENDPRG (F40FH, 5)
* **initial value**: ":"
* **contents**: false end of program for RESUME NEXT statement


<p>&nbsp;</p>

## Work used by BASIC internally

#### ERRFLG (F414H, 1)
* **contents**: area to store the error number

#### LPTPOS (F415H, 1)
* **initial value**: 0
* **contents**: printer head location

#### PRTFLG (F416H, 1)
* **contents**: flag whether to send to printer

#### NTMSXP (F417H, 1)
* **contents**: printer (0 = printer for MSX, otherwise not)

#### RAWPRT (F418H, 1)
* **contents**: non-zero when printing in raw-mode

#### VLZADR (F419H, 2)
* **contents**: address of character to be replaced by VAL function

#### VLZDAT (F41BH, 1)
* **contents**: character to be replaced with 0 by VAL function

#### CURLIN (F41CH, 2)
* **contents**: currently executing line number of BASIC

#### KBUF (F41FH, 318)
* **contents**: crunch buffer; translated into intermediate language from BUF (F55EH)

#### BUFMIN (F55DH, 1)
* **initial value**: ","
* **contents**: used in INPUT statement

#### BUF (F55EH, 258)
* **contents**: buffer to store characters typed; where direct statements are stored in ASCII code

#### ENDBUF (F660H, 1)
* **contents**: prevents overflow of BUF (F55EH)

#### TTYPOS (F661H, 1)
* **contents**: virtual cursor location internally retained by BASIC

#### DIMFLG (F662H, 1)
* **contents**: used by BASIC internally

#### VALTYP (F663H, 1)
* **contents**: used to identify the type of variable

#### DORES (F664H, 1)
* **contents**: indicates whether stored word can be crunched

#### DONUM (F665H, 1)
* **contents**: flag for crunch

#### CONTXT (F666H, 2)
* **contents**: stores text address used by CHRGET

#### CONSAV (F668H, 1)
* **contents**: stores token of constant after calling CHRGET

#### CONTYP (F669H, 1)
* **contents**: type of stored constant

#### CONLO (F66AH, 8)
* **contents**: value of stored constant

#### MEMSIZ (F672H, 2)
* **contents**: highest address of memory used by BASIC

#### STKTOP (F674H, 2)
* **contents**: address used as stack by BASIC; depending on CLEAR statement

#### TXTTAB (F676H, 2)
* **contents**: starting address of BASIC text area

#### TEMPPT (F768H, 2)
* **initial value**: TEMPST (F67AH)
* **contents**: starting address of unused area of temporary descriptor

#### TEMPST (F67AH, 3 * NUMTMP)
* **contents**: area for NUMTEMP

#### DSCTMP (F698H, 3)
* **contents**: string descriptor which is the result of string function

#### FRETOP (F69BH, 2)
* **contents**: starting address of unused area of string area

#### TEMP3 (F69DH, 2)
* **contents**: used for garbage collection or by USR function

#### TEMP8 (F69FH, 2)
* **contents**: for garbage collection

#### ENDFOR (F6A1H, 2)
* **contents**: stores next address of FOR statement (to begin execution from the next of FOR statement at loops)

#### DATLIN (F6A3H, 2)
* **contents**: line number of DATA statement read by READ statement

#### SUBFLG (F6A5H, 1)
* **contents**: flag for array for USR function

#### FLGINP (F6A6H, 1)
* **contents**: flag used in INPUT or READ

#### TEMP (F6A7H, 2)
* **contents**: location for temporary reservation for statement code; used for variable pointer, text address, and others

#### PTRFLG (F6A9H, 1)
* **contents**: 0 if there is not a line number to be converted,otherwise not

#### AUTFLG (F6AAH, 1)
* **contents**: flag for AUTO command validity (non-zero = valid, otherwise invalid)

#### AUTLIN (F6ABH, 2)
* **contents**: last input line number

#### AUTINC (F6ADH, 2)
* **initial value**: 10
* **contents**: increment value of line number of AUTO command

#### SAVTXT (F6AFH, 2)
* **contents**: area to store address of currently executing text; mainly used for error recovery by RESUME statement

#### ERRLIN (F6B3H, 2)
* **contents**: line number where an error occurred

#### DOT (F6B5H, 2)
* **contents**: last line number which was displayed in screen or entered

#### ERRTXT (F6B7H, 2)
* **contents**: text address which caused an error; mainly used for error recovery by RESUME statement

#### ONELIN (F6B9H, 2)
* **contents**: text address to which control jumps at error; set by ON ERROR GOTO statement

#### ONEFLG (F6BBH, 1)
* **contents**: flag which indicates error routine execution (non-zero = in execution, otherwise not)

#### TEMP2 (F6BCH, 2)
* **contents**: for temporary storage

#### OLDLIN (F6BEH, 2)
* **contents**: line number which was terminated by Ctrl+STOP, STOP instruction, END instruction, or was executed last

#### OLDTXT (F6C0H, 2)
* **contents**: address to be executed next

#### VARTAB (F6C2H, 2)
* **contents**: starting address of simple variable; executing NEW statement causes [contents of TXTTAB(F676H) + 2] to be set

#### ARYTAB (F6C4H, 2)
* **contents**: starting address of array table

#### STREND (F6C6H, 2)
* **contents**: last address of memory in use as text area or variable area

#### DATPTR (F6C8H, 2)
* **contents**: text address of data read by executing READ statement

#### DEFTBL (F6CAH, 26)
* **contents**: area to store type of variable for one alphabetical character; depends on type declaration such as CLEAR, DEFSTR, !, or #


<p>&nbsp;</p>

## Work for user function parameter

#### PRMSTK (F6E4H, 2)
* **contents**: previous definition block on stack (for garbage collection)

#### PRMLEN (F6E6H, 2)
* **contents**: number of bytes of objective data

#### PARM1 (F6E8H, PRMSIZ)
* **contents**: objective parameter definition table; PRMSIZ is number of bytes of definition block, initial value is 100

#### PRMPRV (F74CH, 2)
* **initial value**: PRMSTK
* **contents**: pointer to previous parameter block (for garbage collection)

#### PRMLN2 (F74EH, 2)
* **contents**: size of parameter block

#### PARM2 (F750H, 100)
* **contents**: for parameter storage

#### PRMFLG (F7B4H, 1)
* **contents**: flag to indicate whether PARM1 was searched

#### ARYTA2 (F7B5H, 2)
* **contents**: end point of search

#### NOFUNS (F7B7H, 1)
* **contents**: 0 if there is not an objective function

#### TEMP9 (F7B8H, 2)
* **contents**: location of temporary storage for garbage collection

#### FUNACT (F7BAH, 2)
* **contents**: number of objective functions

#### SWPTMP (F7BCH, 8)
* **contents**: location of temporary storage of the value of the first variable of SWAP statement

#### TRCFLG (F7C4H, 1)
* **contents**: trace flag (non-zero = TRACE ON, 0 = TRACE OFF)


<p>&nbsp;</p>

## Work for Math-Pack

#### FBUFFR (F7C5H, 43)
* **contents**: used internally by Math-Pack

#### DECTMP (F7F0H, 2)
* **contents**: used to transform decimal integer to floating-point number

#### DECTM2 (F7F2H, 2)
* **contents**: used at division routine execution

#### DECCNT (F7F4H, 2)
* **contents**: used at division routine execution

#### DAC (F7F6H, 16)
* **contents**: area to set the value to be calculated

#### HOLD8 (F806H, 48)
* **contents**: register storage area for decimal multiplication

#### HOLD2 (F836H, 8)
* **contents**: used internally by Math-Pack

#### HOLD (F83EH, 8)
* **contents**: used internally by Math-Pack

#### ARG (F847H, 16)
* **contents**: area to set the value to be calculated with DAC (F7F6H)

#### RNDX (F857H, 8)
* **contents**: stores last random number in double precision real number; set by RND function


<p>&nbsp;</p>

## Data area used by BASIC interpreter

#### MAXFIL (F85FH, 1)
* **contents**: maximum file number; set by MAXFILES statement

#### FILTAB (F860H, 2)
* **contents**: starting address of file data area

#### NULBUF (F862H, 2)
* **contents**: points to buffer used in SAVE and LOAD by BASIC interpreter

#### PTRFIL (F864H, 2)
* **contents**: address of file data of currently accessing file

#### RUNFLG (F866H, 2)
* **contents**: non-zero value if program was loaded and executed; used by R option of LOAD statement

#### FILNAM (F866H, 11)
* **contents**: area to store filename

#### FILNM2 (F871H, 11)
* **contents**: area to store filename

#### NLONLY (F87CH, 1)
* **contents**: non-zero value if program is being loaded

#### SAVEND (F87DH, 2)
* **contents**: end address of assembly language program to be saved

#### FNKSTR (F87FH, 160)
* **contents**: area to store function key string (16 character x 10)

#### CGPNT (F91FH, 3)
* **contents**: address to store character font on ROM

#### NAMBAS (F922H, 2)
* **contents**: base address of current pattern name table

#### CGPBAS (F924H, 2)
* **contents**: base address of current pattern generator table

#### PATBAS (F926H, 2)
* **contents**: base address of current sprite generator table

#### ATRBAS (F928H, 2)
* **contents**: base address of current sprite attribute table

#### CLOC (F92AH, 2)
* **contents**: used internally by graphic routine

#### CMASK (F92CH, 1)
* **contents**: used internally by graphic routine

#### MINDEL (F92DH, 1)
* **contents**: used internally by graphic routine


#### MAXDEL (F92FH, 2)
* **contents**: used internally by graphic routine


<p>&nbsp;</p>

## Data area used by CIRCLE statement

#### ASPECT (F931H, 2)
* **contents**: aspect ratio of the circle; set by `<ratio>` of CIRCLE statement

#### CENCNT (F933H, 2)
* **contents**: used internally by CIRCLE statement

#### CLINEF (F935H, 1)
* **contents**: flag whether a line is drawn toward the center; specified by `<angle>` of CIRCLE statement

#### CNPNTS (F936H, 2)
* **contents**: point to be plotted

#### CPLOTF (F938H, 1)
* **contents**: used internally by CIRCLE statement

#### CPCNT (F939H, 2)
* **contents**: number of one eight of the circle

#### CPNCNT8 (F93BH, 2)
* **contents**: used internally by CIRCLE statement

#### CPCSUM (F93DH, 2)
* **contents**: used internally by CIRCLE statement

#### CSTCNT (F93FH, 2)
* **contents**: used internally by CIRCLE statement

#### CSCLXY (F941H, 1)
* **contents**: scale of x and y

#### CSAVEA (F942H, 2)
* **contents**: reservation area of ADVGRP

#### CSAVEM (F944H, 1)
* **contents**: reservation area of ADVGRP

#### CXOFF (F945H, 2)
* **contents**: x offset from the center

#### CYOFF (F947H, 2)
* **contents**: y offset from the center


<p>&nbsp;</p>

## Data area used in PAINT statement

#### LOHMSK (F949H, 1)
* **contents**: used internally by PAINT statement

#### LOHDIR (F94AH, 1)
* **contents**: used internally by PAINT statement

#### LOHADR (F94BH, 2)
* **contents**: used internally by PAINT statement

#### LOHCNT (F94DH, 2)
* **contents**: used internally by PAINT statement

#### SKPCNT (F94FH, 2)
* **contents**: skip count

#### MIVCNT (F951H, 2)
* **contents**: movement count

#### PDIREC (F953H, 1)
* **contents**: direction of the paint

#### LFPROG (F954H, 1)
* **contents**: used internally by PAINT statement

#### RTPROG (F955H, 1)
* **contents**: used internally by PAINT statement


<p>&nbsp;</p>

## Data area used in PLAY statement

#### MCLTAB (F956H, 2)
* **contents**: points to the top of the table of PLAY macro or DRAW macro

#### MCLFLG (F958H, 1)
* **contents**: assignment of PLAY/DRAW

#### QUETAB (F959H, 24)
* **contents**: queue table
  * +0: PUT offset
  * +1: GET offset
  * +2: backup character
  * +3: queue length
  * +4: queue address
  * +5: queue address

#### QUEBAK (F971H, 4)
* **contents**: used in BCKQ

#### VOICAQ (F975H, 128)
* **contents**: queue of voice 1 (1 = a)

#### VOICBQ (F9F5H, 128)
* **contents**: queue of voice 2 (2 = b)

#### VOICCQ (FA75H, 128)
* **contents**: queue of voice 3 (3 = c)


<p>&nbsp;</p>

## Work area added in MSX2

#### DPPAGE (FAF5H, 1)
* **contents**: display page number

#### ACPAGE (FAF6H, 1)
* **contents**: active page number

#### AVCSAV (FAF7H, 1)
* **contents**: reserves AV control port

#### EXBRSA (FAF8H, 1)
* **contents**: SUB-ROM slot address

#### CHRCNT (FAF9H, 1)
* **contents**: character counter in the buffer; used in Roman-kana translation (value is 0 `<`=n `<`=2)

#### ROMA (FAFAH, 2)
* **contents**: area to store character in the buffer; used in Roman-kana translation (Japan version only)

#### MODE (FAFCH, 1)
* **contents**: mode switch for VRAM size

```
        (0000WVV0)
             ---
             |||
             |++--- 00 = 16K VRAM
             |      01 = 64K VRAM
             |      11 = 128K VRAM
             |
             +----- 1 = mask, 0 = no mask
                    Flags whether to specify VRAM address
                    ANDed with 3FFFH in SCREEN 0 to 3;
                    in SCREEN 4 to 8, never masked
```

#### NORUSE (FAFDH, 1)
* **contents**: unused

#### XSAVE (FAFEH, 2)
* **contents**: [ I OOOOOOO XXXXXXXX ]

#### YSAVE (FB00H, 2)
* **contents**: [ x OOOOOOO YYYYYYYY ]

```
        I = 1 lightpen interrupt request
        OOOOOOO = unsigned offset
        XXXXXXX = X-coordinate
        YYYYYYY = Y-coordinate
```

#### LOGOPR (FB02H, 1)
* **contents**: logical operation code


<p>&nbsp;</p>

## Data area used by RS-232C

#### RSTMP (FB03H, 50)
* **contents**: work area for RS-232C or disk

#### TOCNT (FB03H, 1)
* **contents**: used internally by RS-232C routine

#### RSFCB (FB04H, 2)
* **contents**:

  * FB04H + 0: LOW address of RS-232C
  * FB04H + 1: HIGH address of RS-232C

#### RSIQLN (FB06H, 5)
* **contents**: used internally by RS-232C routine

#### MEXBIH (FB07H, 5)
* **contents**:
  * FB07H +0: RST 30H (0F7H)
  * FB07H +1: byte data
  * FB07H +2: (Low)
  * FB07H +3: (High)
  * FB07H +4: RET (0C9H)

#### OLDSTT (FB0CH, 5)
* **contents**:
  * FB0CH +0: RST 30H (0F7H)
  * FB0CH +1: byte data
  * FB0CH +2: (Low)
  * FB0CH +3: (High)
  * FB0CH +4: RET (0C9H)

#### OLDINT (FB12H, 5)
* **contents**:
  * FB12H +0: RST 30H (0F7H)
  * FB12H +1: byte data
  * FB12H +2: (Low)
  * FB12H +3: (High)
  * FB12H +4: RET (0C9H)

#### DEVNUM (FB17H, 1)
* **contents**: used internally by RS-232C routine

#### DATCNT (FB18H, 3)
* **contents**:
  * FB18H +0: byte data
  * FB18H +1: byte pointer
  * FB18H +2: byte pointer

#### ERRORS (FB1BH, 1)
* **contents**: used internally by RS-232C routine

#### FLAGS (FB1CH, 1)
* **contents**: used internally by RS-232C routine

#### ESTBLS (FB1DH, 1)
* **contents**: used internally by RS-232C routine

#### COMMSK (FB1EH, 1)
* **contents**: used internally by RS-232C routine

#### LSTCOM (FB1FH, 1)
* **contents**: used internally by RS-232C routine

#### LSTMOD (FB20H, 1)
* **contents**: used internally by RS-232C routine

<p>&nbsp;</p>

## Data area used by DOS

#### reserved (FB21H to FB34H)
* **contents**: used by DOS


<p>&nbsp;</p>

## Data area used by PLAY statement

_(the following is the same as with MSX1)_

#### PRSCNT (FB35H, 1)
* **contents**:
  * D1 to D0: string parse
  * D7 = 0: 1 pass

#### SAVSP (FB36H, 2)
* **contents**: reserves stack pointer in play

#### VOICEN (FB38H, 1)
* **contents**: current interpreted voice

#### SAVVOL (FB39H, 2)
* **contents**: reserves volume for the pause

#### MCLLEN (FB3BH, 1)
* **contents**: used internally by PLAY statement

#### MCLPTR (FB3CH, 1)
* **contents**: used internally by PLAY statement

#### QUEUEN (FB3EH, 1)
* **contents**: used internally by PLAY statement

#### MUSICF (FC3FH, 1)
* **contents**: interrupt flag for playing music

#### PLYCNT (FB40H, 1)
* **contents**: number of PLAY statements stored in the queue


<p>&nbsp;</p>

### Offset from voice static data area
  
_(offset is in decimal)_

#### METREX (+0, 2)
* **contents**: timer count down

#### VCXLEN (+2, 1)
* **contents**: MCLLEN for this voice

#### VCXPTR (+3, 2)
* **contents**: MCLPTR for this voice

#### VCXSTP (+5, 2)
* **contents**: reserves the top of the stack pointer

#### QLENGX (+7, 1)
* **contents**: number of bytes stored in the queue

#### NTICSX (+8, 2)
* **contents**: new count down

#### TONPRX (+10, 2)
* **contents**: area to set tone period

#### AMPPRX (+12, 1)
* **contents**: discrimination of volume and enveloppe

#### ENVPRX (+13, 2)
* **contents**: area to set enveloppe period

#### OCTAVX (+15, 1)
* **contents**: area to set octave

#### NOTELX (+16, 1)
* **contents**: area to set tone length

#### TEMPOX (+17, 1)
* **contents**: area to set tempo

#### VOLUMX (+18, 1)
* **contents**: area to set volume

#### ENVLPX (+19, 14)
* **contents**: area to set enveloppe wave form

#### MCLSTX (+33, 3)
* **contents**: reservation area of stack

#### MCLSEX (+36, 1)
* **contents**: initialisation stack

#### VCBSIZ (+37, 1)
* **contents**: static buffer size


<p>&nbsp;</p>

### Voice static data area


#### VCBA (FB41H, 37)
* **contents**: static data for voice 0

#### VCBB (FB66H, 37)
* **contents**: static data for voice 1

#### VCBC (FB8BH, 37)
* **contents**: static data for voice 2


<p>&nbsp;</p>

## Data area

#### ENSTOP (FBB0H, 1)
* **contents**: flag to enable warm start by [SHIFT+Ctrl+Kana key] (0 = disable, otherwise enable)

#### BASROM (FBB1H, 1)
* **contents**: indicates BASIC text location (0 = on RAM, otherwise in ROM)

#### LINTTB (FBB2H, 24)
* **contents**: line terminal table; area to keep information about each line of text screen

#### FSTPOS (FBCAH, 2)
* **contents**: first character location of line from INLIN (00B1H) of BIOS

#### CODSAV (FBCCH, 1)
* **contents**: area to reserve the character where the cursor is stacked

#### FNKSW1 (FBCDH, 1)
* **contents**: indicates which function key is displayed at KEY ON (1 = F1 to F5 is displayed, 0 = F6 to F10 is displayed)

#### FNKFLG (FBCEH, 10)
* **contents**: area to allow, inhibit, or stop the execution of the line defined in ON KEY GOSUB statement, or to reserve it for each function key; set by KEY(n)ON/OFF/STOP statement (0 = KEY(n)OFF/STOP, 1= KEY(n)ON)

#### ONGSBF (FBD8H, 1)
* **contents**: flag to indicate whether event waiting in TRPTBL (FC4CH) occurred

#### CLIKFL (FBD9H, 1)
* **contents**: key click flag

#### OLDKEY (FBDAH, 11)
* **contents**: key matrix status (old)

#### NEWKEY (FBE5H, 11)
* **contents**: key matrix status (new)

#### KEYBUF (FBF0H, 40)
* **contents**: key code buffer

#### LINWRK (FC18H, 40)
* **contents**: temporary reservation location used by screen handler

#### PATWRK (FC40H, 8)
* **contents**: temporary reservation location used by pattern converter

#### BOTTOM (FC48H, 2)
* **contents**: installed RAM starting (low) address; ordinarily 8000H in MSX2

#### HIMEM (FC4AH, 2)
* **contents**: highest address of available memory; set by `<memory upper limit>` of CLEAR statement

#### TRAPTBL (FC4CH, 78)
* **contents**: trap table used to handle interrupt; one table consists of three bytes, where first byte indicates ON/OFF/STOP status and the rest indicate the text address to be jumped to
  * FC4CH to FC69H (3 * 10 bytes): used in ON KEY GOSUB
  * FC6AH to FC6CH (3 * 1 byte): used in ON STOP GOSUB
  * FC6DH to FC6FH (3 * 1 byte): used in ON SPRITE GOSUB
  * FC70H to FC7EH (3 * 5 bytes): used in ON STRIG GOSUB
  * FC7FH to FC81H (3 * 1 byte): used in ON INTERVAL GOSUB
  * FC82H to FC99H: for expansion

#### RTYCNT (FC9AH, 1)
* **contents**: used internally by BASIC

#### INTFLG (FC9BH, 1)
* **contents**: if Ctrl+STOP is pressed, setting 03H here causes a stop

#### PADY (FC9CH, 1)
* **contents**: Y-coordinate of the paddle)

#### PADX (FC9DH, 1)
* **contents**: X-coordinate of the paddle)

#### JIFFY (FC9EH, 2)
* **contents**: used internally by PLAY statement

#### INTVAL (FCA0H, 2)
* **contents**: interval period; set by ON INTERVAL GOSUB statement

#### INTCNT (FCA2H, 2)
* **contents**: counter for interval

#### LOWLIM (FCA4H, 1)
* **contents**: used during reading from cassette tape

#### WINWID (FCA5H, 1)
* **contents**: used during reading from cassette tape

#### GRPHED (FCA6H, 1)
* **contents**: flag to send graphic character (1 = graphic character, 0 = normal character)

#### ESCCNT (FCA7H, 1)
* **contents**: area to count from escape code

#### INSFLG (FCA8H, 1)
* **contents**: flag to indicate insert mode (0 = normal mode, otherwise = insert mode)

#### CSRSW (FCA9H, 1)
* **contents**: whether cursor is displayed (0 = no, otherwise = yes); set by `<cursor swicth>` of LOCATE statement

#### CSTYLE (FCAAH, 1)
* **contents**: cursor shape (0 = block, otherwise = underline)

#### CAPST (FCABH, 1)
* **contents**: CAPS key status (0 = CAP OFF, otherwise = CAP ON)

#### KANAST (FCACH, 1)
* **contents**: kana key status (0 = kaka OFF, otherwise = kana ON)

#### KANAMD (FCADH, 1)
* **contents**: kana key arrangement status (0 = 50-sound arrangement, otherwise = JIS arrangement)

#### FLBMEM (FCAEH, 1)
* **contents**: 0 when loading BASIC program

#### SCRMOD (FCAFH, 1)
* **contents**: current screen mode number

#### OLDSCR (FCB0H, 1)
* **contents**: screen mode reservation area

#### CASPRV (FCB1H, 1)
* **contents**: character reservation area used by CAS:

#### BRDATR (FCB2H, 1)
* **contents**: border colour code used by PAINT; set by `<border colour>` in PAINT statement

#### GXPOS (FCB3H, 2)
* **contents**: X-coordinate

#### GYPOS (FCB5H, 2)
* **contents**: Y-coordinate

#### GRPACX (FCB7H, 2)
* **contents**: graphic accumulator (X-coordinate)

#### GRPACY (FCB9H, 2)
* **contents**: graphic accumulator (Y-coordinate)

#### DRWFLG (FCBBH, 1)
* **contents**: flag used in DRAW statement

#### DRWSCL (FCBCH, 1)
* **contents**: DRAW scaling factor (0 = no scaling, otherwise = scaling)

#### DRWANG (FCBDH, 1)
* **contents**: angle at DRAW

#### RUNBNF (FCBEH, 1)
* **contents**: flag to indicate BLOAD in progress, BSAVE in progress, or neither

#### SAVENT (FCBFH, 2)
* **contents**: starting address of BSAVE

#### EXPTBL (FCC1H, 4)
* **contents**: flag table for expansion slot; whether the slot is expanded

#### SLTTBL (FCC5H, 4)
* **contents**: current slot selection status for each expansion slot register

#### SLTATR (FCC9H, 64)
* **contents**: reserves attribute for each slot

#### SLTWRK (FD09H, 128)
* **contents**: allocates specific work area for each slot

#### PROCNM (FD89H, 16)
* **contents**: stores name of expanded statement (after CALL statement) or expansion device (after OPEN); 0 indicates the end

#### DEVICE (FD99H, 1)
* **contents**: used to identify cartridge device


<p>&nbsp;</p>

## Hooks

#### H.KEYI (FD9AH)
* **meaning**: beginning of MSXIO interrupt handling
* **purpose**: adds the interrupt operation such as RS-232C

#### H.TIMI (FD9FH)
* **meaning**: MSXIO timer interrupt handling
* **purpose**: adds the timer interrupt handling

#### H.CHPH (FDA4H)
* **meaning**: beginning of MSXIO CHPUT (one character output)
* **purpose**: connects other console device

#### H.DSPC (FDA9H)
* **meaning**: beginning of MSXIO DSPCSR (cursor display)
* **purpose**: connects other console device

#### H.ERAC (FDAEH)
* **meaning**: beginning of MSXIO ERACSR (erase cursor)
* **purpose**: connects other console device

#### H.DSPF (FDB3H)
* **meaning**: beginning of MSXIO DSPFNK (function key display)
* **purpose**: connects other console device

#### H.ERAF (FDB8H)
* **meaning**: beginning of MSXIO ERAFNK (erase function key)
* **purpose**: connects other console device

#### H.TOTE (FDBDH)
* **meaning**: beginning of MSXIO TOTEXT (set screen in text mode)
* **purpose**: connects other console device

#### H.CHGE (FDC2H)
* **meaning**: beginning of MSXIO CHGET (get one character)
* **purpose**: connects other console device

#### H.INIP (FDC7H)
* **meaning**: beginning of MSXIO INIPAT (character pattern initialisation)
* **purpose**: uses other character set

#### H.KEYC (FDCCH)
* **meaning**: beginning of MSXIO KEYCOD (key code translation)
* **purpose**: uses other key arrangement

#### H.KYEA (FDD1H)
* **meaning**: beginning of MSXIO NMI routine (Key Easy)
* **purpose**: uses other key arrangement

#### H.NMI (FDD6H)
* **meaning**: beginning of MSXIO NMI (non-maskable interrupt)
* **purpose**: handles NMI

#### H.PINL (FDDBH)
* **meaning**: beginning of MSXIO PINLIN (one line input)
* **purpose**: uses other console input device or other input method

#### H.QINL (FDE0H)
* **meaning**: beginning of MSXINL QINLIN (one line input displaying "?")
* **purpose**: uses other console input device or other input method

#### H.INLI (FDE5H)
* **meaning**: beginning of MSXINL INLIN (one line input)
* **purpose**: uses other console input device or other input method

#### H.ONGO (FDEAH)
* **meaning**: beginning of MSXSTS INGOTP (ON GOTO)
* **purpose**: uses other interrupt handling device

#### H.DSKO (FDEFH)
* **meaning**: beginning of MSXSTS DSKO$ (disk output)
* **purpose**: connects disk device

#### H.SETS (FDF4H)
* **meaning**: beginning of MSXSTS SETS (set attribute)
* **purpose**: connects disk device

#### H.NAME (FDF9H)
* **meaning**: beginning of MSXSTS NAME (rename)
* **purpose**: connects disk device

#### H.KILL (FDFEH)
* **meaning**: beginning of MSXSTS KILL (delete file)
* **purpose**: connects disk device

#### H.IPL (FE03H)
* **meaning**: beginning of MSXSTS IPL (initial program loading)
* **purpose**: connects disk device

#### H.COPY (FE08H)
* **meaning**: beginning of MSXSTS COPY (file copy)
* **purpose**: connects disk device

#### H.CMD (FE0DH)
* **meaning**: beginning of MSXSTS CMD (expanded command)
* **purpose**: connects disk device

#### H.DSKF (FE12H)
* **meaning**: beginning of MSXSTS DSKF (unusde disk space)
* **purpose**: connects disk device

#### H.DSKI (FE17H)
* **meaning**: beginning of MSXSTS DSKI (disk input)
* **purpose**: connects disk device

#### H.ATTR (FE1CH)
* **meaning**: beginning of MSXSTS ATTR$ (attribute)
* **purpose**: connects disk device

#### H.LSET (FE21H)
* **meaning**: beginning of MSXSTS LSET (left-padded assignment)
* **purpose**: connects disk device

#### H.RSET (FE26H)
* **meaning**: beginning of MSXSTS RSET (right-padded assignment)
* **purpose**: connects disk device

#### H.FIEL (FE2BH)
* **meaning**: beginning of MSXSTS FIELD (field)
* **purpose**: connects disk device

#### H.MKI$ (FE30H)
* **meaning**: beginning of MSXSTS MKI$ (create integer)
* **purpose**: connects disk device

#### H.MKS$ (FE35H)
* **meaning**: beginning of MSXSTS MKS$ (create single precision real)
* **purpose**: connects disk device

#### H.MKD$ (FE3AH)
* **meaning**:  beginning of MSXSTS MKD$ (create double precision real)
* **purpose**: connects disk device

#### H.CVI (FE3FH)
* **meaning**: beginning of MSXSTS CVI (convert integer)
* **purpose**: connects disk device

#### H.CVS (FE44H)
* **meaning**: beginning of MSXSTS CVS (convert single precision real)
* **purpose**: connects disk device

#### H.CVD (FE49H)
* **meaning**: beginning of MSXSTS CVS (convert double precision real)
* **purpose**: connects disk device

#### H.GETP (FE4EH)
* **meaning**: SPDSK GETPTR (get file pointer)
* **purpose**: connects disk device

#### H.SETF (FE53H)
* **meaning**: SPCDSK SETFIL (set file pointer)
* **purpose**: connects disk device

#### H.NOFO (FE58H)
* **meaning**: SPDSK NOFOR (OPEN statement without FOR)
* **purpose**: connects disk device

#### H.NULO (FE5DH)
* **meaning**: SPCDSK NULOPN (open unused file)
* **purpose**: connects disk device

#### H.NTFL (FE62H)
* **meaning**: SPCDSK NTFLO (file number is not 0)
* **purpose**: connects disk device

#### H.MERG (FE67H)
* **meaning**: SPCDSK MERGE (program file merge)
* **purpose**: connects disk device

#### H.SAVE (FE6CH)
* **meaning**: SPCDSK SAVE (save)
* **purpose**: connects disk device

#### H.BINS (FE71H)
* **meaning**: SPCDSK BINSAV (save in binary)
* **purpose**: connects disk device

#### H.BINL (FE76H)
* **meaning**: SPCDSK BINLOD (load in binary)
* **purpose**: connects disk device

#### H.FILE (FD7BH)
* **meaning**: SPCDSK FILES (displey filename)
* **purpose**: connects disk device

#### H.DGET (FE80H)
* **meaning**: SPCDSK DGET (disk GET)
* **purpose**: connects disk device

#### H.FILO (FE85H)
* **meaning**: SPCDSK FILOU1 (file output)
* **purpose**: connects disk device

#### H.INDS (FE8AH)
* **meaning**: SPCDSK INDSKC (disk attribute input)
* **purpose**: connects disk device

#### H.RSLF (FE8FH)
* **meaning**: SPCDSK; re-select previous drive
* **purpose**: connects disk device

#### H.SAVD (FE94H)
* **meaning**: SPCDSK; reserve current disk
* **purpose**: connects disk device

#### H.LOC (FE99H)
* **meaning**: SPCDSK LOC function (indicate location)
* **purpose**: connects disk device

#### H.LOF (FE9EH)
* **meaning**: SPCDSK LOC function (file length)
* **purpose**: connects disk device

#### H.EOF (FEA3H)
* **meaning**: SPCDSK EOF function (end of file)
* **purpose**: connects disk device

#### H.FPOS (FEA8H)
* **meaning**: SPCDSK FPOS function (file location)
* **purpose**: connects disk device

#### H.BAKU (FEADH)
* **meaning**: SPCDSK BAKUPT (backup)
* **purpose**: connects disk device

#### H.PARD (FEB2H)
* **meaning**: SPCDEV PARDEV (get peripheral name)
* **purpose**: expands logical device name

#### H.NODE (FEB7H)
* **meaning**: SPCDEV NODEVN (no device name)
* **purpose**: sets default device name to other device

#### H.POSD (FEBCH)
* **meaning**: SPCDEV POSDSK
* **purpose**: connects disk device

#### H.DEVN (FEC1H)
* **meaning**: SPCDEV DEVNAM (process device name)
* **purpose**: expands logical device name

#### H.GEND (FEC6H)
* **meaning**: SPCDEV GENDSP (FEC6H)
* **purpose**: expands logical device name

#### H.RUNC (FECBH)
* **meaning**: BIMISC RUNC (clear for RUN)

#### H.CLEAR (FED0H)
* **meaning**: BIMISC CLEARC (clear for CLEAR statement)

#### H.LOPD (FED5H)
* **meaning**: BIMISC LOPDFT (set loop and default value)
* **purpose**: uses other default value for variable

#### H.STKE (FEDAH)
* **meaning**: BIMISC STKERR (stack error)

#### H.ISFL (FEDFH)
* **meaning**: BIMISC ISFLIO (file input-output or not)

#### H.OUTD (FEE4H)
* **meaning**: BIO OUTDO (execute OUT)

#### H.CRDO (FEE9H)
* **meaning**: BIO CRDO (execute CRLF)

#### H.DSKC (FEEEH)
* **meaning**: BIO DSKCHI (input disk attribute)

#### H.DOGR (FEF3H)
* **meaning**: GENGRP DOGRPH (execute graphic operation)

#### H.PRGE (FEF8H)
* **meaning**: BINTRP PRGEND (program end)

#### H.ERRP (FEFDH)
* **meaning**: BINTRP ERRPTR (error display)

#### H.ERRF (FF02H)
* **meaning**: BINTRP

#### H.READ (FF07H)
* **meaning**: BINTRP READY

#### H.MAIN (FF0CH)
* **meaning**: BINTRP MAIN

#### H.DIRD (FF11H)
* **meaning**: BINTRP DIRDO (execute direct statement)

#### H.FINI (FF16H)
* **meaning**: BINTRP

#### H.FINE (FF1BH)
* **meaning**: BINTRP

#### H.CRUN (FF20H)
* **meaning**: BINTRP

#### H.CRUN (FF20H)
* **meaning**: BINTRP

#### H.CRUS (FF25H)
* **meaning**: BINTRP

#### H.ISRE (FF2AH)
* **meaning**: BINTRP

#### H.NTFN (FF2FH)
* **meaning**: BINTRP

#### H.NOTR (FF34H)
* **meaning**: BINTRP

#### H.SNGF (FF39H)
* **meaning**: BINTRP

#### H.NEWS (FF3EH)
* **meaning**: BINTRP

#### H.GONE (FF43H)
* **meaning**: BINTRP

#### H.CHRG (FF48H)
* **meaning**: BINTRP

#### H.RETU (FF4DH)
* **meaning**: BINTRP

#### H.PRTF (FF52H)
* **meaning**: BINTRP

#### H.COMP (FF57H)
* **meaning**: BINTRP

#### H.FINP (FF5CH)
* **meaning**: BINTRP

#### H.TRMN (FF61H)
* **meaning**: BINTRP

#### H.FRME (FF66H)
* **meaning**: BINTRP

#### H.NTPL (FF6BH)
* **meaning**: BINTRP

#### H.EVAL (FF70H)
* **meaning**: BINTRP

#### H.OKNO (FF75H)
* **meaning**: BINTRP

#### H.FING (FF7AH)
* **meaning**: BINTRP

#### H.ISMI (FF7FH)
* **meaning**: BINTRP ISMID$ (MID$ or not)

#### H.WIDT (FF84H)
* **meaning**: BINTRP WIDTHS (WIDTH)

#### H.LIST (FF89H)
* **meaning**: BINTRP LIST

#### H.BUFL (FF8EH)
* **meaning**: BINTRP BUFLIN (buffer line)

#### H.FRQI (FF93H)
* **meaning**: BINTRP FRQINT

#### H.SCNE (FF98H)
* **meaning**: BINTRP

#### H.FRET (FF9DH)
* **meaning**: BINTRP FRETMP

#### H.PTRG (FFA2H)
* **meaning**: BIPTRG PTRGET (get pointer)
* **purpose**: uses variable other than default value

#### H.PHYD (FFA7H)
* **meaning**: MSXIO PHYDIO (physical disk input-output)
* **purpose**: connects disk device

#### H.FORM (FFACH)
* **meaning**: MSXIO FORMAT (format disk)
* **purpose**: connects disk device

#### H.ERRO (FFB1H)
* **meaning**: BINTRP ERROR
* **purpose**: error handling for application program

#### H.LPTO (FFB6H)
* **meaning**: MSXIO LPTOUT (printer output)
* **purpose**: uses printer other than default value

#### H.LPTS (FFBBH)
* **meaning**: MSXIO LPTSTT (printer status)
* **purpose**: uses printer other than default value

#### H.SCRE (FFC0H)
* **meaning**: MSXSTS SCREEN statement entry
* **purpose**: expands SCREEN statement


<p>&nbsp;</p>

## Changes from the original

- Address of [FLAGS](#flags-fb1ch-1) variable is corrected from FB1BH to FB1CH.

- Address of [MCLLEN](#mcllen-fb3bh-1) variable is corrected from FB39H to FB3BH.

- Address of [H.FIEL](#hfiel-fe2bh) hook is corrected from DE2BH to FE2BH.
