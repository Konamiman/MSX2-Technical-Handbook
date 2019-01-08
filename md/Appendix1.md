# APPENDIX 1 - BIOS LISTING

This chapter lists the 126 BIOS entries available to the user.


<p>&nbsp;</p>

## Index

[RSTs](#rsts)

[I/O initialisation](#io-initialisation)

[VDP access](#vdp-access)

[PSG](#psg)

[Keyboard, CRT, printer input-output](#keyboard-crt-printer-input-output)

[Game I/O access](#game-io-access)

[Cassette input-output routine](#cassette-input-output-routine)

[Miscellaneous](#miscellaneous)

[Entries appended for MSX2](#entries-appended-for-msx2)

[SUB-ROM](#sub-rom)

[Changes from the original](#changes-from-the-original)


<p>&nbsp;</p>

There are two kinds of BIOS routines, the ones in MAIN-ROM and the ones in SUB-ROM. They each have different calling sequences which will be described later. The following is the entry notation.


**Label name (address)**    \*n*
* **Function**: descriptions and notes about the function
* **Input**: parameters used by call
* **Output**: parameters returned by call
* **Registers**: registers which will be used (original contentes are lost)


The value of **\*n** has the following meanings.

* **\*1**: same as MSX1
* **\*2**: call SUB-ROM internally in screen modes 5 to 8
* **\*3**: always call SUB-ROM
* **\*4**: do not call SUB-ROM while screen modes 4 to 8 are changed

Routines without **\*n** are appended for MSX2.


<p>&nbsp;</p>

## MAIN-ROM

To call routines in MAIN-ROM, the CALL or RTS instruction is used as an ordinary subroutine call.


<p>&nbsp;</p>

### RSTs

Among the following RSTs, RST 00H to RST 28H are used by the BASIC interpreter. RST 30H is used for inter-slot calls and RST 38H is used for hardware interrupts.


<p>&nbsp;</p>

#### CHKRAM (0000H) *1
* **Function**: tests RAM and sets RAM slot for the system
* **Input**: none
* **Output**: none
* **Registers**: all


<p>&nbsp;</p>

#### SYNCHR (0008H) *1
* **Function**: tests whether the character of [HL] is the specified character. If not, it generates SYNTAX ERROR, otherwise it goes to [CHRGTR](#chrgtr-0010h-1) (0010H).
* **Input**: set the character to be tested in [HL] and the character to be compared next to RST instruction which calls this routine (inline parameter).
```
Example:        LD      HL,LETTER
                RST     08H
                DB      "A"
                         .
                         .
                         .
        LETTER: DB      "B"
```

* **Output**: HL is increased by one and A receives [HL]. When the tested character is numerical, the CY flag is set; the end of the statement (00H or 3AH) causes the Z flag to be set.
* **Registers**: AF, HL


<p>&nbsp;</p>

#### RDSLT (000CH) *1
* **Function**: selects the slot corresponding to the value of A and reads one byte from the memory of the slot. When this routine is called, the interrupt is inhibited and remains inhibited even after execution ends.
* **Input**: A for the slot number (see format below), HL for the address of memory to be read
```
 F000EEPP
 -   ----
 |   ||++-------------- Basic slot number (0 to 3)
 |   ++---------------- Expansion slot number (0 to 3)
 +--------------------- "1" when using expansion slot
```

* **Output**: the value of memory which has been read in A
* **Registers**: AF, BC, DE


<p>&nbsp;</p>

#### CHRGTR (0010H) *1
* **Function**: gets a character (or a token) from BASIC text
* **Input**: [HL] for the character to be read
* **Output**: HL is incremented by one and A receives [HL]. When the character is numerical, the CY flag is set; the end of the statement causes the Z flag to be set.
* **Registers**: AF, HL


<p>&nbsp;</p>

#### WRSLT (0014H) *1
* **Function**: selects the slot corresponding to the value of A and writes one byte to the memory of the slot. When this routine is called, interrupts are inhibited and remain so even after execution ends.
* **Input**: specifies a slot with A (same as [RDSLT](#rdslt-000ch-1))
* **Output**: none
* **Registers**: AF, BC, D


<p>&nbsp;</p>

#### OUTDO (0018H) *2
* **Function**: sends the value to current device
* **Input**: A for the value to be sent
  * sends output to the printer when PTRFLG (F416H) is other than 0
  * sends output to the file specified by PTRFIL (F864H) when PTRFIL is other than 0
* **Output**: none
* **Registers**: none


<p>&nbsp;</p>

#### CALSLT (001CH) *1
* **Function**: calls the routine in another slot (inter-slot call)
* **Input**: specify the slot in the 8 high order buts of the IY register (same as [RDSLT](#rdslt-000ch-1)). IX is for the address to be called.
* **Output**: depends on the calling routine
* **Registers**: depends on the calling routine


<p>&nbsp;</p>

#### DCOMPR (0020H) *1
* **Function**: compares the contents of HL and DE
* **Input**: HL, DE
* **Output**: sets the Z flag for HL = DE, CY flag for HL < DE
* **Registers**: AF


<p>&nbsp;</p>

#### ENASLT (0024H) *1
* **Function**: selects the slot corresponding to the value of A and enables the slot to be used. When this routine is called, interrupts are inhibited and remain so even after execution ends.
* **Input**: 
  * specify the slot by A (same as [RDSLT](#rdslt-000ch-1)) 
  * specify the page to switch the slot by 2 high order bits of HL
* **Output**: none
* **Registers**: all


<p>&nbsp;</p>

#### GETYPR (0028H) *1
* **Function**: returns the type of DAC (decimal accumulator)
* **Input**: none
* **Output**: S, Z, P/V flags are changed depending on the type of DAC:

```
integer type                    single precision real type
   C = 1                                C = 1
   S = 1 *                              S = 0
   Z = 0                                Z = 0
   P/V = 1                              P/V = 0 *

string type                     double precision real type
   C = 1                                C = 0 *
   S = 0                                S = 0
   Z = 1 *                              Z = 0
   P/V = 1                              P/V = 1

Types can be recognised by the flag marked by "*".
```

* **Registers**: AF


<p>&nbsp;</p>

#### CALLF (0030H) *1
* **Function**: calls the routine in another slot. The following is the calling sequence:
```
        RST     30H
        DB      n       ;n is the slot number (same as RDSLT)
        DW      nn      ;nn is the called address
```

* **Input**: In the method described above
* **Output**: depends on the calling routine
* **Registers**: AF, and other registers depending on the calling routine


<p>&nbsp;</p>

#### KEYINT (0038H) *1
* **Function**: executes the timer interrupt process routine
* **Input**: none
* **Output**: none
* **Registers**: none


<p>&nbsp;</p>

### I/O initialisation


<p>&nbsp;</p>

#### INITIO (003BH) *1
* **Function**: initialises the device
* **Input**: none
* **Output**: none
* **Registers**: all


<p>&nbsp;</p>

#### INIFNK (003EH) *1
* **Function**: initialises the contents of function keys
* **Input**: none
* **Output**: none
* **Registers**: all



<p>&nbsp;</p>

### VDP access


<p>&nbsp;</p>

#### DISSCR (0041H) *1
* **Function**: inhibits the screen display
* **Input**: none
* **Output**: none
* **Registers**: AF, BC


<p>&nbsp;</p>

#### ENASCR (0044H) *1
* **Function**: displays the screen
* **Input**: none
* **Output**: none
* **Registers**: all


<p>&nbsp;</p>

#### WRTVDP (0047H) *2
* **Function**: writes data in the VDP register
* **Input**: C for the register number, B for data; the register number is 0 to 23 and 32 to 46
* **Output**: none
* **Registers**: AF, BC


<p>&nbsp;</p>

#### RDVRM (004AH) *1
* **Function**: reads the contents of VRAM. This is for TMS9918, so only the 14 low order bits of the VRAM address are valid. To use all bits, call [NRDVRM](#nrdvrm-0174h).
* **Input**: HL for VRAM address to be read
* **Output**: A for the value which was read
* **Registers**: AF


<p>&nbsp;</p>

#### WRTVRM (004DH) *1
* **Function**: writes data in VRAM. This is for TMS9918, so only the 14 low order bits of the VRAM address are valid. To use all bits, call [NWRVRM](#nwrvrm-0177h).
* **Input**: HL for VRAM address, A for data
* **Output**: none
* **Registers**: AF


<p>&nbsp;</p>

#### SETRD (0050H) *1
* **Function**: sets VRAM address to VDP and enables it to be read. This is used to read data from the sequential VRAM area by using the address auto-increment function of VDP. This enables faster readout than using [RDVRM](#rdvrm-004ah-1) in a loop. This is for TMS9918, so only the 14 low order bits of VRAM address are valid. To use all bits, call [NSETRD](#nsetrd-016eh).
* **Input**: HL for VRAM address
* **Output**: none
* **Registers**: AF


<p>&nbsp;</p>

#### SETWRT (0053H) *1
* **Function**: sets VRAM address to VDP and enables it to be written. The purpose is the same as [SETRD](#setrd-0050h-1). This is for TMS9918, so only the 14 low order bits of VRAM address are valid. To use all bits, call [NSETRD](#nsetrd-016eh).
* **Input**: HL for VRAM address
* **Output**: none
* **Registers**: AF


<p>&nbsp;</p>

#### FILVRM (0056H) *4
* **Function**: fills the specified VRAM area with the same data. This is for TMS9918, so only the 14 low order bits of the VRAM address are valid. To use all bits, see [BIGFIL](#bigfil-016bh).
* **Input**: HL for VRAM address to begin writing, BC for the length of the area to be written, A for data.
* **Output**: none
* **Registers**: AF, BC


<p>&nbsp;</p>

#### LDIRMV (0059H) *4
* **Function**: block transfer from VRAM to memory
* **Input**: HL for source address (VRAM), DE for destination address (memory), BC for the length. All bits of the VRAM address are valid.
* **Output**: none
* **Registers**: all


<p>&nbsp;</p>

#### LDIRVM (005CH) *4
* **Function**: block transfer from memory to VRAM
* **Input**: HL for source address (memory), DE for destination address (VRAM), BC for the length. All bits of the VRAM address are valid.
* **Output**: none
* **Registers**: all


<p>&nbsp;</p>

#### CHGMOD (005FH) *3
* **Function**: changes the screen mode. The palette is not initialised. To initialise it, see [CHGMDP](#chgmdp-01b5h) in SUB-ROM.
* **Input**: A for the screen mode (0 to 8)
* **Output**: none
* **Registers**: all


<p>&nbsp;</p>

#### CHGCLR (0062H) *1
* **Function**: changes the screen colour
* **Input**:
  * A for the mode 
  * FORCLR (F3E9H) for foreground color 
  * BAKCLR (F3EAH) for background color
  * BDRCLR (F3EBH) for border colour
* **Output**: none
* **Registers**: all


<p>&nbsp;</p>

#### NMI (0066H) *1
* **Function**: executes NMI (Non-Maskable Interrupt) handling routine
* **Input**: none
* **Output**: none
* **Registers**: none


<p>&nbsp;</p>

#### CLRSPR (0069H) *3
* **Function**: initialises all sprites. The sprite pattern is cleared to null, the sprite number to the sprite plane number, the sprite colour to the foregtound colour. The vertical location of the sprite is set to 209 (mode 0 to 3) or 217 (mode 4 to 8).
* **Input**: SCRMOD (FCAFH) for the screen mode
* **Output**: none
* **Registers**: all


<p>&nbsp;</p>

#### INITXT (006CH) *3
* **Function**: initialises the screen to TEXT1 mode (40 x 24). In this routine, the palette is not initialised. To initialise the palette, call [INIPLT](#iniplt-0141h) in SUB-ROM after this call.
* **Input**: 
  * TXTNAM (F3B3H) for the pattern name table
  * TXTCGP (F3B7H) for the pattern generator table 
  * LINL40 (F3AEH) for the length of one line
* **Output**: none
* **Registers**: all


<p>&nbsp;</p>

#### INIT32 (006FH) *3
* **Function**: initialises the screen to GRAPHIC1 mode (32x24). In this routine, the palette is not initialised.
* **Input**:
  * T32NAM (F3BDH) for the pattern name table
  * T32COL (F3BFH) for the colour table
  * T32CGP (F3C1H) for the pattern generator table
  * T32ATR (F3C3H) for the sprite attribute table
  * T32PAT (F3C5H) for the sprite generator table
* **Output**: none
* **Registers**: all


<p>&nbsp;</p>

#### INIGRP (0072H) *3
* **Function**: initialises the screen to the high-resolution graphics mode. In this routine, the palette is not initialised.
* **Input**: 
  * GRPNAM (F3C7H) for the pattern name table
  * GRPCOL (F3C9H) for the colour table
  * GRPCGP (F3CBH) for the pattern generator table
  * GRPATR (F3CDH) for the sprite attribute table 
  * GRPPAT (F3CFH) for the sprite generator table
* **Output**: none
* **Registers**: all


<p>&nbsp;</p>

#### INIMLT (0075H) *3
* **Function**: initialises the screen to MULTI colour mode. In this routine, the palette is not initialised.
* **Input**:
  * MLTNAM (F3D1H) for the pattern name table 
  * MLTCOL (F3D3H) for the colour table
  * MLTCGP (F3D5H) for the pattern generator table
  * MLTATR (F3D7H) for the sprite attribute table 
  * MLTPAT (F3D9H) for the sprite generator table
* **Output**: none
* **Registers**: all


<p>&nbsp;</p>

#### SETTXT (0078H) *3
* **Function**: set only VDP in TEXT1 mode (40x24)
* **Input**: same as [INITXT](#initxt-006ch-3)
* **Output**: none
* **Registers**: all


<p>&nbsp;</p>

#### SETT32 (007BH) *3
* **Function**: set only VDP in GRAPHIC1 mode (32x24)
* **Input**: same as [INIT32](#init32-006fh-3)
* **Output**: none
* **Registers**: all


<p>&nbsp;</p>

#### SETGRP (007EH) *3
* **Function**: set only VDP in GRAPHIC2 mode
* **Input**: same as [INIGRP](#inigrp-0072h-3)
* **Output**: none
* **Registers**: all


<p>&nbsp;</p>

#### SETMLT (0081H) *3
* **Function**: set only VDP in MULTI colour mode
* **Input**: same as [INIMLT](#inimlt-0075h-3)
* **Output**: none
* **Registers**: all


#### CALPAT (0084H) *1
* **Function**: returns the address of the sprite generator table
* **Input**: A for the sprite number
* **Output**: HL for the address
* **Registers**: AF, DE, HL


<p>&nbsp;</p>

#### CALATR (0087H) *1
* **Function**: returns the address of the sprite attribute table
* **Input**: A for the sprite number
* **Output**: HL for the address
* **Registers**: AF, DE, HL


<p>&nbsp;</p>

#### GSPSIZ (008AH) *1
* **Function**: returns the current sprite size
* **Input**: none
* **Output**: A for the sprite size (in bytes). Only when the size is 16 x 16, the CY flag is set; otherwise the CY flag is reset.
* **Registers**: AF


<p>&nbsp;</p>

#### GRPPRT (008DH) *2
* **Function**: displays a character on the graphic screen
* **Input**: A for the character code. When the screen mode is 0 to 8, set the logical operation code in LOGOPR (FB02H).
* **Output**: none
* **Registers**: none


<p>&nbsp;</p>

### PSG


<p>&nbsp;</p>

#### GICINI (0090H) *1
* **Function**: initialises PSG and sets the initial value for the PLAY statement
* **Input**: none
* **Output**: none
* **Registers**: all


<p>&nbsp;</p>

#### WRTPSG (0093H) *1
* **Function**: writes data in the PSG register
* **Input**: A for PSG register number, E for data
* **Output**: none
* **Registers**: none


<p>&nbsp;</p>

#### RDPSG (0096H) *1
* **Function**: reads the PSG register value
* **Input**: A for PSG register number
* **Output**: A for the value which was read
* **Registers**: none


<p>&nbsp;</p>

#### STRTMS (0099H) *1
* **Function**: tests whether the PLAY statement is being executed as a background task. If not, begins to execute the PLAY statement
* **Input**: none
* **Output**: none
* **Registers**: all


<p>&nbsp;</p>


### Keyboard, CRT, printer input-output


<p>&nbsp;</p>

#### CHSNS (009CH) *1
* **Function**: tests the status of the keyboard buffer
* **Input**: none
* **Output**: the Z flag is set when the buffer is empty, otherwise the Z flag is reset
* **Registers**: AF


<p>&nbsp;</p>

#### CHGET (009FH) *1
* **Function**: one character input (waiting)
* **Input**: none
* **Output**: A for the code of the input character
* **Registers**: AF


<p>&nbsp;</p>

#### CHPUT (00A2H) *1
* **Function**: displays the character
* **Input**: A for the character code to be displayed
* **Output**: none
* **Registers**: none


<p>&nbsp;</p>

#### LPTOUT (00A5H) *1
* **Function**: sends one character to the printer
* **Input**: A for the character code to be sent
* **Output**: if failed, the CY flag is set
* **Registers**: F


<p>&nbsp;</p>

#### LPTSTT (00A8H) *1
* **Function**: tests the printer status
* **Input**: none
* **Output**: 
  * when A is 255 and the Z flag is reset, the printer is READY.
  * when A is 0 and the Z flag is set, the printer is NOT READY.
* **Registers**: AF


<p>&nbsp;</p>

#### CNVCHR (00ABH) *1
* **Function**: test for the graphic header and transforms the code
* **Input**: A for the character code
* **Output**:
  * the CY flag is reset to not the graphic header 
  * the CY flag and the Z flag are set to the transformed code is set in A 
  * the CY flag is set and the CY flag is reset to the untransformed code is set in A
* **Registers**: AF


<p>&nbsp;</p>

#### PINLIN (00AEH) *1
* **Function**: stores in the specified buffer the character codes input until the return key or STOP key is pressed.
* **Input**: none
* **Output**: HL for the starting address of the buffer minus 1, the CY flag is set only when it ends with the STOP key.
* **Registers**: all


<p>&nbsp;</p>

#### INLIN (00B1H) *1
* **Function**: same as [PINLIN](#pinlin-00aeh-1) except that AUTFLG (F6AAH) is set
* **Input**: none
* **Output**: HL for the starting address of the buffer minus 1, the CY flag is set only when it ends with the STOP key.
* **Registers**: all


<p>&nbsp;</p>

#### QINLIN (00B4H) *1
* **Function**: executes [INLIN](#inlin-00b1h-1) with displaying "?" and one space
* **Input**: none
* **Output**: HL for the starting address of the buffer minus 1, the CY flag is set only when it ends with the STOP key.
* **Registers**: all


<p>&nbsp;</p>

#### BREAKX (00B7H) *1
* **Function**: tests Ctrl-STOP key. In this routine, interrupts are inhibited.
* **Input**: none
* **Output**: the CY flag is set when pressed
* **Registers**: AF


<p>&nbsp;</p>

#### BEEP (00C0H) *3
* **Function**: generates BEEP
* **Input**: none
* **Output**: none
* **Registers**: all


<p>&nbsp;</p>

#### CLS (00C3H) *3
* **Function**: clears the screen
* **Input**: set zero flag
* **Output**: none
* **Registers**: AF, BC, DE


<p>&nbsp;</p>

#### POSIT (00C6H) *1
* **Function**: moves the cursor
* **Input**: H for the X-coordinate of the cursor, L for the Y-coordinate
* **Output**: none
* **Registers**: AF


<p>&nbsp;</p>

#### FNKSB (00C9H) *1
* **Function**: tests whether the function key display is active (FNKFLG). If so, displays them, otherwise erases them.
* **Input**: FNKFLG (FBCEH)
* **Output**: none
* **Registers**: all


<p>&nbsp;</p>

#### ERAFNK (00CCH) *1
* **Function**: erases the function key display
* **Input**: none
* **Output**: none
* **Registers**: all


<p>&nbsp;</p>

#### DSPFNK (00CFH) *2
* **Function**: displays the function keys
* **Input**: none
* **Output**: none
* **Registers**: all


<p>&nbsp;</p>

#### TOTEXT (00D2H) *1
* **Function**: forces the screen to be in the text mode
* **Input**: none
* **Output**: none
* **Registers**: all


<p>&nbsp;</p>

### Game I/O access


<p>&nbsp;</p>

#### GTSTCK (00D5H) *1
* **Function**: returns the joystick status
* **Input**: A for the joystick number to be tested
* **Output**: A for the joystick direction
* **Registers**: all


<p>&nbsp;</p>

#### GTTRIG (00D8H) *1
* **Function**: returns the trigger button status
* **Input**: A for the trigger button number to be tested
* **Output**:
  * When A is 0, the trigger button is not being pressed.
  * When A is FFH, the trigger button is being pressed.
* **Registers**: AF


<p>&nbsp;</p>

#### GTPAD (00DBH) *1
* **Function**: returns the touch pad status
* **Input**: A for the touch pad number to be tested
* **Output**: A for the value
* **Registers**: all


<p>&nbsp;</p>

#### GTPDL (00DEH) *2
* **Function**: returns the paddle value
* **Input**: A for the paddle number
* **Output**: A for the value
* **Registers**: all


<p>&nbsp;</p>


### Cassette input-output routine


<p>&nbsp;</p>

#### TAPION (00E1H) *1
* **Function**: reads the header block after turning the cassette motor ON.
* **Input**: none
* **Output**: if failed, the CY flag is set
* **Registers**: all


<p>&nbsp;</p>

#### TAPIN (00E4H) *1
* **Function**: reads data from the tape
* **Input**: none
* **Output**: A for data. If failed, the CY flag is set.
* **Registers**: all


<p>&nbsp;</p>

#### TAPIOF (00E7H) *1
* **Function**: stops reading the tape
* **Input**: none
* **Output**: none
* **Registers**: none


<p>&nbsp;</p>

#### TAPOON (00EAH) *1
* **Function**: writes the header block after turning the cassette motor ON
* **Input**: A = 0, short header; A <> 0, long header
* **Output**: if failed, the CY flag is set
* **Registers**: all


<p>&nbsp;</p>

#### TAPOUT (00EDH) *1
* **Function**: writes data on the tape
* **Input**: A for data
* **Output**: if failed, the CY flag is set
* **Registers**: all


<p>&nbsp;</p>

#### TAPOOF (00F0H) *1
* **Function**: stops writing to the tape
* **Input**: A for data
* **Output**: if failed, the CY flag is set
* **Registers**: all


<p>&nbsp;</p>

#### STMOTR (00F3H) *1
* **Function**: sets the cassette motor action
* **Input**:
  * A = 0 ⟶ stop
  * A = 1 ⟶ start
  * A = 0FFH ⟶ reverse the current action
* **Output**: none
* **Registers**: AF


<p>&nbsp;</p>

### Miscellaneous


<p>&nbsp;</p>

#### CHGCAP (0132H) *1
* **Function**: alternates the CAP lamp status
* **Input**:
  * A = 0 ⟶ lamp off
  * A <>0 ⟶ lamp on
* **Output**: none
* **Registers**: AF


<p>&nbsp;</p>

#### CHGSND (0135H) *1
* **Function**: alternates the 1-bit sound port status
* **Input**:
  * A = 0 ⟶ OFF
  * A <>0 ⟶ ON
* **Output**: none
* **Registers**: AF


<p>&nbsp;</p>

#### RSLREG (0138H) *1
* **Function**: reads the contents of current output to the basic slot register
* **Input**: none
* **Output**: A for the value which was read
* **Registers**: A


<p>&nbsp;</p>

#### WSLREG (013BH) *1
* **Function**: writes to the primary slot register
* **Input**: A for the value to be written
* **Output**: none
* **Registers**: none


<p>&nbsp;</p>

#### RDVDP (013EH) *1
* **Function**: reads VDP status register
* **Input**: none
* **Output**: A for the value which was read
* **Registers**: A


<p>&nbsp;</p>

#### SNSMAT (0141H) *1
* **Function**: reads the value of the specified line from the keyboard matrix
* **Input**: A for the specified line
* **Output**: A for data (the bit corresponding to the pressed key will be 0)
* **Registers**: AF, C


<p>&nbsp;</p>

#### PHYDIO (0144H)
* **Function**: Physical input/output for disk devices
* **Input**: 
  * A for the drive number (0 = A:, 1 = B:,...)
  * B for the number of sector to be read from or written to 
  * C for the media ID DE for the first sector number to be read rom or written to
  * HL for the startinga address of the RAM buffer to be read from or written to specified sectors
  * CY set for sector writing; reset for sector reading
* **Output**: 
  * CY set if failed 
  * B for the number of sectors actually read or written
  * A for the error code (only if CY set):
    * 0 = Write protected 
    * 2 = Not ready
    * 4 = Data error 
    * 6 = Seek error 
    * 8 = Record not found
    * 10 = Write error
    * 12 = Bad parameter 
    * 14 = Out of memory 
    * 16 = Other error
* **Registers**: all


<p>&nbsp;</p>

#### ISFLIO (014AH) *1
* **Function**: tests whether the device is active
* **Input**: none
* **Output**: 
  * A = 0 ⟶ active 
  * A <>0 ⟶ inactive
* **Registers**: AF


<p>&nbsp;</p>

#### OUTDLP (014DH) *1
* **Function**: printer output. Different from [LPTOUT](#lptout-00a5h-1) in the following points:
1. TAB is expanded to spaces
2. For non-MSX printers, hiragana is transformed to katakana and graphic characters are transformed to 1-byte characters.
3. If failed, device I/O error occurs.
* **Input**: A for data
* **Output**: none
* **Registers**: F


<p>&nbsp;</p>

#### KILBUF (0156H) *1
* **Function**: clears the keyboard buffer
* **Input**: none
* **Output**: none
* **Registers**: HL


<p>&nbsp;</p>

#### CALBAS (0159H) *1
* **Function**: executes inter-slot call to the routine in BASIC interpreter
* **Input**: IX for the calling address
* **Output**: depends on the called routine
* **Registers**: depends on the called routine


<p>&nbsp;</p>

### Entries appended for MSX2


<p>&nbsp;</p>

#### SUBROM (015CH)
* **Function**: executes inter-slot call to SUB-ROM
* **Input**: IX for the calling address and, at the same time, pushes IX on the stack
* **Output**: depends on the called routine
* **Registers**: background registers and IY are reserved


<p>&nbsp;</p>

#### EXTROM (015FH)
* **Function**: executes inter-slot call to SUB-ROM
* **Input**: IX for the calling address
* **Output**: depends on the called routine
* **Registers**: background registers and IY are reserved


<p>&nbsp;</p>

#### EOL (0168H)
* **Function**: deletes to the end of the line
* **Input**: H for X-coordinate of the cursor, L for Y-coordinate
* **Output**: none
* **Registers**: all


<p>&nbsp;</p>

#### BIGFIL (016BH)
* **Function**: same function as [FILVRM](#filvrm-0056h-4). Differences are as follows: 
  * In [FILVRM](#filvrm-0056h-4), it is tested whether the screen mode is 0 to 3. If so, it treats VDP as the one which has only 16K bytes VRAM (for the compatibility with MSX1). 
  * In [BIGFIL](#bigfil-016bh), the mode is not tested and actions are carried out by the given parameters.
* **Input**: same as [FILVRM](#filvrm-0056h-4)
* **Output**: same as [FILVRM](#filvrm-0056h-4)
* **Registers**: same as [FILVRM](#filvrm-0056h-4)


<p>&nbsp;</p>

#### NSETRD (016EH)
* **Function**: enables VRAM to be read by setting the address
* **Input**: HL for VRAM address
* **Output**: none
* **Registers**: AF


<p>&nbsp;</p>

#### NSTWRT (0171H)
* **Function**: enables VRAM to be written by setting the address
* **Input**: HL for VRAM address
* **Output**: none
* **Registers**: AF


<p>&nbsp;</p>

#### NRDVRM (0174H)
* **Function**: reads the contents of VRAM
* **Input**: HL for VRAM address to be read
* **Output**: A for the value which was read
* **Registers**: F


<p>&nbsp;</p>

#### NWRVRM (0177H)
* **Function**: writes data in VRAM
* **Input**: HL for VRAM address, A for data
* **Output**: none
* **Registers**: AF


<p>&nbsp;</p>

## SUB-ROM

The calling sequence of SUB-ROM is as follows:

```
                .
                .
                .
        LD      IX, INIPLT
                         ; Set BIOS entry address
        CALL    EXTROM
                         ; Returns here
                .
                .
                .
```

When the contents of IX should not be destroyed, use the call as shown below.

```
                .
                .
                .
INIPAL: PUSH    IX
                         ; Save IX
        LD      IX, INIPLT
                         ; Set BIOS entry address
        JP      SUBROM
                         ;Returns caller of INIPAL
                .
                .
                .
```

<p>&nbsp;</p>

#### GRPRT (0089H)
* **Function**: one character output to the graphic screen (active only in screen modes 5 to 8)
* **Input**: A for the character code
* **Output**: none
* **Registers**: none


<p>&nbsp;</p>

#### NVBXLN (00C9H)
* **Function**: draws a box
* **Input**: 
  * start point: BC for X-coordinate, DE for Y-coordinate 
  * end point:
    * GXPOS (FCB3H) for X-coordinate
    * GYPOS (FCB5H) for Y-coordinate 
  * colour: ATRBYT (F3F3H) for the attribute
  * logical operation code: LOGOPR (FB02H)
* **Output**: none
* **Registers**: all


<p>&nbsp;</p>

#### NVBXFL (00CDH)
* **Function**: draws a painted box
* **Input**: 
  * start point: BC for X-coordinate, DE for Y-coordinate 
  * end point:
    * GXPOS (FCB3H) for X-coordinate
    * GYPOS (FCB5H) for Y-coordinate
  * colour: ATRBYT (F3F3H) for the attribute 
  * logical operation code: LOGOPR (FB02H)
* **Output**: none
* **Registers**: all


<p>&nbsp;</p>

#### CHGMOD (00D1H)
* **Function**: changes the screen mode
* **Input**: A for the screen mode (0 to 8)
* **Output**: none
* **Registers**: all


<p>&nbsp;</p>

#### INITXT (00D5H)
* **Function**: initialises the screen to TEXT1 mode (40 x 24)
* **Input**:
  * TXTNAM (F3B3H) for the pattern name table
  * TXTCGP (F3B7H) for the pattern generator table 
  * LINL40 (F3AEH) for the length of one line
* **Output**: none
* **Registers**: all


<p>&nbsp;</p>

#### INIT32 (00D9H)
* **Function**: initialises the screen to GRAPHIC1 mode (32x24)
* **Input**:
  * T32NAM (F3BDH) for the pattern name table
  * T32COL (F3BFH) for the colour table
  * T32CGP (F3C1H) for the pattern generator table
  * T32ATR (F3C3H) for the sprite attribute table
  * T32PAT (F3C5H) for the sprite generator table
* **Output**: none
* **Registers**: all


<p>&nbsp;</p>

#### INIGRP (00DDH)
* **Function**: initialises the screen to the high-resolution graphics mode
* **Input**: 
  * GRPNAM (F3C7H) for the pattern name table 
  * GRPCOL (F3C9H) for the colour table 
  * GRPCGP (F3CBH) for the pattern generator table 
  * GRPATR (F3CDH) for the sprite attribute table 
  * GRPPAT (F3CFH) for the sprite generator table
* **Output**: none
* **Registers**: all


<p>&nbsp;</p>

#### INIMLT (00E1H)
* **Function**: initialises the screen to MULTI colour mode
* **Input**: 
  * MLTNAM (F3D1H) for the pattern name table 
  * MLTCOL (F3D3H) for the colour table
  * MLTCGP (F3D5H) for the pattern generator table 
  * MLTATR (F3D7H) for the sprite attribute table 
  * MLTPAT (F3D9H) for the sprite generator table
* **Output**: none
* **Registers**: all


<p>&nbsp;</p>

#### SETTXT (00E5H)
* **Function**: sets VDP in the text mode (40x24)
* **Input**: same as [INITXT](#initxt-00d5h)
* **Output**: none
* **Registers**: all


<p>&nbsp;</p>

#### SETT32 (00E9H)
* **Function**: ses VDP in the text mode (32x24)
* **Input**: same as [INIT32](#init32-00d9h)
* **Output**: none
* **Registers**: all


<p>&nbsp;</p>

#### SETGRP (00EDH)
* **Function**: sets VDP in the high-resolution mode
* **Input**: same as [INIGRP](#inigrp-00ddh)
* **Output**: none
* **Registers**: all


<p>&nbsp;</p>

#### SETMLT (00F1H)
* **Function**: sets VDP in MULTI COLOUR mode
* **Input**: same as [INIMLT](#inimlt-00e1h)
* **Output**: none
* **Registers**: all


<p>&nbsp;</p>

#### CLRSPR (00F5H)
* **Function**: initialises all sprites. The sprite pattern is set to null, sprite number to sprite plane number, and sprite colour to the foreground colour. The vertical location of the sprite is set to 217.
* **Input**: SCRMOD (FCAFH) for the screen mode
* **Output**: none
* **Registers**: all


<p>&nbsp;</p>

#### CALPAT (00F9H)
* **Function**: returns the address of the sprite generator table (this routine is the same as [CALPAT](#calpat-0084h-1) in MAIN-ROM)
* **Input**: A for the sprite number
* **Output**: HL for the address
* **Registers**: AF, DE, HL


<p>&nbsp;</p>

#### CALATR (00FDH)
* **Function**: returns the address of the sprite attribute table (this routine is the same as [CALATR](#calatr-0087h-1) in MAIN-ROM)
* **Input**: A for the sprite number
* **Output**: HL for the address
* **Registers**: AF, DE, HL


<p>&nbsp;</p>

#### GSPSIZ (0101H)
* **Function**: returns the current sprite size (this routine is the same as [GSPSIZ](#gspsiz-008ah-1) in MAIN-ROM)
* **Input**: none
* **Output**: A for the sprite size. The CY flag is set only for the size 16 x 16.
* **Registers**: AF


<p>&nbsp;</p>

#### GETPAT (0105H)
* **Function**: returns the character pattern
* **Input**: A for the character code
* **Output**: PATWRK (FC40H) for the character pattern
* **Registers**: all


<p>&nbsp;</p>

#### WRTVRM (0109H)
* **Function**: writes data in VRAM
* **Input**: HL for VRAM address (0 TO FFFFH), A for data
* **Output**: none
* **Registers**: AF


<p>&nbsp;</p>

#### RDVRM (010DH)
* **Function**: reads the contents of VRAM
* **Input**: HL for VRAM address (0 TO FFFFH) to be read
* **Output**: A for the value which was read
* **Registers**: AF


<p>&nbsp;</p>

#### CHGCLR (0111H)
* **Function**: changes the screen colour
* **Input**: 
  * A for the mode 
  * FORCLR (F3E9H) for the foreground color
  * BAKCLR (F3EAH) for the background color
  * BDRCLR (F3EBH) for the border colour
* **Output**: none
* **Registers**: all


<p>&nbsp;</p>

#### CLSSUB (0115H)
* **Function**: clears the screen
* **Input**: none
* **Output**: none
* **Registers**: all


<p>&nbsp;</p>

#### DSPFNK (011DH)
* **Function**: displays the function keys
* **Input**: none
* **Output**: none
* **Registers**: all


<p>&nbsp;</p>

#### WRTVDP (012DH)
* **Function**: writes data in the VDP register
* **Input**: C for the register number, B for data
* **Output**: none
* **Registers**: AF, BC


<p>&nbsp;</p>

#### VDPSTA (0131H)
* **Function**: reads the VDP register
* **Input**: A for the register number (0 to 9)
* **Output**: A for data
* **Registers**: F


<p>&nbsp;</p>

#### SETPAG (013DH)
* **Function**: switches the page
* **Input**:
  * DPPAGE (FAF5H) for the display page number 
  * ACPAGE (FAF6H) for the active page number
* **Output**: none
* **Registers**: AF


<p>&nbsp;</p>

#### INIPLT (0141H)
* **Function**: initialises the palette (the current palette is saved in VRAM)
* **Input**: none
* **Output**: none
* **Registers**: AF, BC, DE


<p>&nbsp;</p>

#### RSTPLT (0145H)
* **Function**: restores the palette from VRAM
* **Input**: none
* **Output**: none
* **Registers**: AF, BC, DE


<p>&nbsp;</p>

#### GETPLT (0149H)
* **Function**: obtains the colour code from the palette
* **Input**: D for the palette number (0 to 15)
* **Output**: 
  * 4 high order bits of B for red code 
  * 4 low order bits of B for blue code
  * 4 low order bits of C for green code
* **Registers**: AF, DE


<p>&nbsp;</p>

#### SETPLT (014DH)
* **Function**: sets the colour code to the palette
* **Input**: 
  * D for the palette number (0 to 15)
  * 4 high order bits of A for red code
  * 4 low order bits of A for blue code 
  * 4 low order bits of E for green code
* **Output**: none
* **Registers**: AF


<p>&nbsp;</p>

#### BEEP (017DH)
* **Function**: generates BEEP
* **Input**: none
* **Output**: none
* **Registers**: all


<p>&nbsp;</p>

#### PROMPT (0181H)
* **Function**: displays the prompt
* **Input**: none
* **Output**: none
* **Registers**: all


<p>&nbsp;</p>

#### NEWPAD (01ADH)
* **Function**: reads the status of mouse or light pen
* **Input**: call with setting the following data in A; descriptions in parenthesis are return values.
  * 8: light pen check (valid at 0FFH)
  * 9: returns X-coordinate 
  * 10: returns Y-coordinate 
  * 11: returns the light pen switch status (0FFH, when pressed)
  * 12: whether the mouse is connected to the port 1 (valid at 0FFH) 
  * 13: returns the offset in X direction
  * 14: returns the offset in Y direction 
  * 15: (always 0)
  * 16: whether the mouse is connected to the port 2 (valid at 0FFH)
  * 17: returns the offset in X direction 
  * 18: returns the offset in Y direction
  * 19: (always 0)
* **Output**: A
* **Registers**: all


<p>&nbsp;</p>

#### CHGMDP (01B5H)
* **Function**: changes VDP mode. The palette is initialised.
* **Input**: A for the screen mode (0 to 8)
* **Output**: none
* **Registers**: all


<p>&nbsp;</p>

#### KNJPRT (01BDH)
* **Function**: sends a kanki to the graphic screen (modes 5 to 8)
* **Input**: BC for JIS kanji code, A for the display mode. The display mode has the following meaning, similar to the PUT KANJI command of BASIC.
  * 0: display in 16 x 16 dot 
  * 1: display even dots 
  * 2: display odd dots


<p>&nbsp;</p>

#### REDCLK (01F5H)
* **Function**: reads the clock data
* **Input**: C for RAM address of the clock

```
  00MMAAAA
    ------
    ||++++--- Address (0 to 15)
    ++------- Mode (0 to 3)
```

* **Output**: A for the data which were read (only 4 low order bits are valid)
* **Registers**: F


<p>&nbsp;</p>

#### WRTCLK (01F9H)
* **Function**: writes the clock data
* **Input**: A for the data to be written, C for RAM address of the clock
* **Output**: none
* **Registers**: F


<p>&nbsp;</p>

## Changes from the original

- In description of [ENASLT](#enaslt-0024h-1), the needed input in HL has been added.

- In description of [GETYPR](#getypr-0028h-1), the Input field has been added.

- In description of [INITXT](#initxt-006ch-3) (MAIN), the reference to "INIPLOT" has been corrected to "[INIPLT](#iniplt-0141h)".

- In description of [SUBROM](#subrom-015ch) routine, the mark "*1" has been erased.

- In description of [INITXT](#initxt-006ch-3) (SUB), the needed input in LINL40 has been added.

- Description of [PHYDIO](#phydio-0144h) routine has been added.


