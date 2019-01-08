# APPENDIX 3 - BIT BLOCK TRANSFER

The bit block transfer corresponds to the COPY command in BASIC and is used to transfer data from RAM, VRAM, and the disk. It is easily executed by the routine in expansion ROM and available from the assembly language program. Since it is in expansion ROM, use SUBROM or EXTROM of BIOS for this routine.


<p>&nbsp;</p>

## Index

[1. Transferring in VRAM](#1-transferring-in-vram)

[2. Transferring data between RAM and VRAM](#2-transferring-data-between-ram-and-vram)

[3. Transferring between the disk and RAM or VRAM](#3-transferring-between-the-disk-and-ram-or-vram)


<p>&nbsp;</p>

## 1. Transferring in VRAM

#### BLTVV (0191H/SUB)
* **Function**: transfers data in VRAM area
* **Input**:
  * HL register ⟵ F562H
  * The following parameters should be set:
    * SX (F562H, 2): X-coordinate of the source
    * SY (F564H, 2): Y-coordinate of the source
    * DX (F566H, 2): X-coordinate of the destination
    * DY (F568H, 2): Y-coordinate of the destination
    * NX (F56AH, 2): number of dots in the X direction
    * NY (F56CH, 2): number of dots in the Y direction
    * CDUMMY (F56EH, 1): dummy (not required to be set)
    * ARG (F56FH, 1): selects the direction and expansion RAM (same as VDP R#45)
    * LOGOP (F570H, 1): logical operation code (same as the logical operation code of VDP)
* **Output**: the CY flag is reset
* **Registers**: all


<p>&nbsp;</p>

## 2. Transferring data between RAM and VRAM

To use the routines below, the following memory space should be allocated as graphic area for screen modes.

* **screen mode 6:** number of dots in X direction times number of dots in Y direction/4 + 4

* **screen mode 5 or 7:** number of dots in X direction times number of dots in Y direction/2 + 4

* **screen mode 8:** number of dots in X direction times number of dots in Y direction/2 + 4

Note to raise fractions.

For disk or RAM, data to indicate the size is added as the array data. The first two bytes of data indicate the number of dots in X direction; the next two bytes indicate the number of dots in the Y direction.


<p>&nbsp;</p>

#### BLTVM (0195H/SUB)

* **Function**: transfers the array to VRAM
* **Input**: 
  * HL register ⟵ F562H
  * The following parameters should be set:
    * DPTR (F562H, 2): source address of memory
    * DUMMY (F564H, 2): dummy (not required to be set)
    * DX (F566H, 2): X-coordinate of the destination
    * DY (F568H, 2): Y-coordinate of the destination
    * NX (F56AH, 2): number of dots in the X direction (not required to be set; this is already in the top of data to be transferred)
    * NY (F56CH, 2): number of dots in the Y direction (not required to be set; this is already in the top of data to be transferred)
    * CDUMMY (F56EH, 1): dummy (not required to be set)
    * ARG (F56FH, 1): selects the direction and expansion RAM (same as VDP R#45)
    * LOGOP (F570H, 1): logical operation code (same as the logical operation code of VDP)
* **Output**: the CY flag is set when the number of data bytes to be transferred is incorrect
* **Registers**: all


<p>&nbsp;</p>

#### BLTMV (0199H/SUB)

* **Function**: transfers to the array from VRAM
* **Input**: 
  * HL register ⟵ F562H
  * The following parameters should be set:
    * SX (F562H, 2): X-coordinate of the source
    * SY (F564H, 2): Y-coordinate of the source
    * DPTR (F566H, 2): destination address of memory
    * DUMMY (F568H, 2): dummy (not required to be set)
    * NX (F56AH, 2): number of dots in the X direction
    * NY (F56CH, 2): number of dots in the Y direction
    * CDUMMY (F56EH, 1): dummy (not required to be set)
    * ARG (F56FH, 1): selects the direction and expansion RAM (same as VDP R#45)
* **Output**:   the CY flag is reset
* **Registers**: all


<p>&nbsp;</p>

## 3. Transferring between the disk and RAM or VRAM

The filename should be set first to use the disk (specify the filename as BASIC). The following is an example:

```
                .
                .
                .
        LD      HL,FNAME                ; Get pointer to file name
        LD      (FNPTR),HL              ; Set it to parameter area
                .
                .
                .
FNAME:  DB 22H,"B:TEST.PIC",22H,0       ; "TEST.PIC", end mark
```

When an error occurs, control jumps to the error handler of the BASIC interpreter. Set the hook to handle the error in the user program or to call this routine from MSX-DOS or a ROM cartridge. This hook is H.ERRO (FFB1H).


<p>&nbsp;</p>

#### BLTVD (019DH/SUB)
* **Function**: transfers from disk to VRAM
* **Input**:
  * HL register ⟵ F562H
  * The following parameters should be set:
    * FNPTR (F562H, 2): address of the filename
    * DUMMY (F564H, 2): dummy (not required to be set)
    * DX (F566H, 2): X-coordinate of the destination
    * DY (F568H, 2): Y-coordinate of the destination
    * NX (F56AH, 2): number of dots in the X direction (not required to be set; this is already in the top of data to be transferred)
    * NY (F56CH, 2): number of dots in the Y direction (not required to be set; this is already in the top of data to be transferred)
    * CDUMMY (F56EH, 1): dummy (not required to be set)
    * ARG (F56FH, 1): selects the direction and expansion RAM (same as VDP R#45)
    * LOGOP (F570H, 1): logical operation code (same as the logical operation code of VDP)
* **Output**:   the CY flag is set when there is an error in the parameter
* **Registers**: all


<p>&nbsp;</p>

#### BLTDV (01A1H/SUB)

* **Function**: transfers from VRAM to disk
* **Input**:
  * HL register ⟵ F562H
  * The following parameters should be set:
    * SX (F562H, 2): X-coordinate of the source
    * SY (F564H, 2): Y-coordinate of the source
    * FNPTR (F566H, 2): address of the filename
    * DUMMY (F568H, 2): dummy (not required to be set)
    * NX (F56AH, 2): number of dots in the X direction
    * NY (F56CH, 2): number of dots in the Y direction
    * CDUMMY (F56EH, 1): dummy (not required to be set)
* **Output**: the CY flag is reset
* **Registers**: all


<p>&nbsp;</p>

#### BLTMD (01A5H/SUB)

* **Function**: loads array data from disk
* **Input**:
  * HL register ⟵ F562H
  * The following parameters should be set:
    * FNPTR (F562H, 2): address of the filename
    * SY (F564H, 2): dummy (not required to be set)
    * SPTR (F566H, 2): the starting address for loading
    * EPTR (F568H, 2): the end address for loading
* **Output**: the CY flag is reset
* **Registers**: all


<p>&nbsp;</p>

#### BLTDM (01A9H/SUB)
* **Function**: saves array data to disk
* **Input**:
  * HL register ⟵ F562H
  * The following parameters should be set:
    * SPTR (F562H, 2): the starting address for saving
    * EPTR (F564H, 2): the end address for saving
    * FNPTR (F566H, 2): address of the filename
* **Output**: the CY flag is reset
* **Registers**: all
