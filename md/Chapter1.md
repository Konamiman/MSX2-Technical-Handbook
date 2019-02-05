# CHAPTER 1 - MSX SYSTEM OVERVIEW

The MSX2 was designed to be fully compatible with the MSX1, but there are many enhanced features in the MSX2. Chapter 1 introduces the enhanced features of the MSX2, and shows block figures and standard tables. This information is conceptual, but will be needed to understand descriptions in volume 2 and later.


<p>&nbsp;</p>

## Index

[1. FROM MSX1 TO MSX2](#1-from-msx1-to-msx2)

[1.1 What is MSX?](#11-what-is-msx)

[1.2 Environment of the MSX](#12-environment-of-the-msx)

[1.3 Extended Contents of MSX2](#13-extended-contents-of-msx2)

[2. MSX2 SYSTEM OVERVIEW](#2-msx2-system-overview)

[2.1 Hardware overview](#21-hardware-overview)

[2.1.1 Address map](#211-address-map)

[2.1.2 Interfacing with peripherals](#212-interfacing-with-peripherals)

[2.2 Software Overview](#22-software-overview)


<p>&nbsp;</p>

## 1. FROM MSX1 TO MSX2

To begin with, let us took back to the original purpose or intention of MSX and then sum up the transition from MSX1 to MSX2.


<p>&nbsp;</p>

### 1.1 What is MSX?

MSX was announced as a new 8-bit computer standard in the autumn of 1983. In early days the word "compatibility" was not understood correctly and there were misunderstandings that MSX could execute programs from other computers. Since MSX can execute programs only for MSX, it was said that were was no difference from the PC series (NEC) or FM series (Fujitsu) personal computers, which could only execute programs using their format.

Several years passed before personal computers became popular. In the early days only dedicated enthusiasts bought computers, which were difficult to use, and, needless to say, incompatible. They were satisfied to tinker with the computer and study it. But now computer use has expanded to include several classes of users. In other words, the personal computer is becoming a commodity item such as televisions or radio cassette recorders. Therefore, "compatibility" is coming to be a problem. If each TV station needs a different television set or if each radio cassette recorder needs a different tape, do you suppose they would be popular? Software or programs of the computer as a home electric product must be compatible.

The design team for MSX considered these problems. Since a computer is most powerful when left flexible and easy to expand, a "final" standard format was not practical. There are too many matters to define and hardware is constantly improving. Therefore MSX started with fixing format of the most fundamental harware and software such as DOS and BASIC, and the hardware bus which is the basis for expansion. Since the computer is used by itself and does not interact with other computers, the problem is small. But formats must be fixed if the computer is to be connected to "peripherals" and handle or accumulate various data. Fortunately MSX had the approval of many home appliance electric companies and an MSX format was established early. This allowed the system to be well known so that several manufacturers could make compatible peripherals for the MSX standard.

Some of the useful features included in the MSX system include the use of double precision BCD for normal BASIC arithmetic and the same file format as MS-DOS. The real capabilities of the MSX machine will come to light as it is used across several fields.


<p>&nbsp;</p>

### 1.2 Environment of the MSX

Over one million MSX machines had been sold by December 1985 and are used mainly as game machines or primers by primary and junior high school students. But MSX use has gradually spread to include such uses as communication terminals, Japanese word processing, factory automation, and audio visual control. For improving its capabilities, a disk system and MSX-DOS have been prepared, and languages such as C, FORTH, and LOGO are available. BIOS, which is the collection of input/output routines in BASIC ROM, and BDOS, which resides in the disk interface ROM and has compatibility with CP/M system calls, have both been improved. So an excellent programming environment is now available. Chinese Character input, light pen and mouse input, and the RS-232C interface have been standardised, and stantardisation of other peripherals is proceeding. The keyboard and character set are consistent with international standards, and there are minor variations to satisfy the needs of individual countries.

Several new peripherals have been developed. Standard devices include printers, disk drives, and mice; audio/visual devices include laser drives, VTRs, synthesizer controllers, and video acquisition systems. Factory Automation devices include robot controllers, room temperature controllers, various adaptors for modem and telephone lines, and a health controller combined with a hemadynamometer has been developed. So you can see that the potential uses for MSX computers has really grown.

Many applications other than games are now supplied on disks and are becoming more practical. There are now Japanese word processors capable of clause transformation, data bases which can exchange data with higher-level systems, and CAI and CAD systems.


<p>&nbsp;</p>

### 1.3 Extended Contents of MSX2

MSX2 was announced in May 1985 as a system having upgraded compatibility with MSX. Programs created under the MSX environment can be executed on MSX2 without any modifications, even at the assembly language level. Data and programs stored on cassette tapes or disks can be used without modification. Features added by the MSX2 system are improved screen display, higher resolution, more colours available, and higher graphics speed. A battery-powered clock and RAMDISK feature have also been added. In this manual the name MSX2 refers to the computer made along the MSX2 standard and the name MSX1 refers to the computer made along the previous MSX standard.

System configuration is shown in Figures [1.1](#figure-11--msx2-system-configuration) and [1.2](#figure-12--msx1-system-configuration) and [Table 1.1](#table-11-msx2msx1-standard-comparison) and indicate the differences between MSX1 and MSX2. The differences are described as follows:


##### _Table 1.1 MSX2/MSX1 standard comparison_

```
                             MSX2              |           MSX1
                -------------------------------+---------------------------
CPU             |    Z80A or equivalent (clock 3.579545 MHz +- 1%)        |
                |------------------------------+--------------------------|
                | 48K (MSX-BASIC version 2.0)  |  32K (MSX-BASIC ver 1.0) |
          ROM   |      MAIN-ROM 32K            |       MAIN-ROM 32K       |
                |      SUB-ROM  16K            |                          |
MEMORY    RAM   | 64K or more                  |  8K or more              |
          VRAM  | 64K or 128K                  |  16K                     |
                |------------------------------+--------------------------|
LSI for VDP     | V-9938 (MSX-VIDEO)           |  TMS9918 or equivalent   |
                |---------------------------------------------------------|
CMT             |                 FSK  1200/2400 baud                     |
                |---------------------------------------------------------|
PSG             |    8 octaves tri-chord output (AY-3-8910 compatible)    |
                |---------------------------------------------------------|
Keyboard        | Alphanumeric                 |  Alphanumeric            |
                | Graphic symbols              |  Graphic symbols         |
                |---------------------------------------------------------|
Floppy disk (*) |                Based on MS-DOS format                   |
                |---------------------------------------------------------|
Printer         | 8-bit parallel               |  (*)                     |
                |---------------------------------------------------------|
ROM cartridge   |                        I/O bus                          |
                |     with slot for game cartridge and expansion bus      |
                |---------------------------------------------------------|
Joystick        |              2               |  1 or 2 (*)              |
                |------------------------------+--------------------------|
CLOCK-IC        | Standard                     |  (*)                     |
                |------------------------------+--------------------------|
RAM disk        | Standard                     |  Different for           |
feature         |                              |  each maker              |
                -----------------------------------------------------------

                (*) Optional
```

##### _Figure 1.1  MSX2 system configuration_

![Figure 1.1](https://raw.githubusercontent.com/Konamiman/MSX2-Technical-Handbook/add-pics/pics/Figure%201.1.png)


##### _Figure 1.2  MSX1 system configuration_

![Figure 1.2](https://raw.githubusercontent.com/Konamiman/MSX2-Technical-Handbook/add-pics/pics/Figure%201.2.png)



#### MSX-BASIC

BASIC has also been extended from version 1.0 to version 2.0 in order to support a new VDP, backup RAM, CLOCK-IC, and so on. Compatibility with MSX1 is maintained. When using the newly extended screen mode, be careful when specifiyng range, since ranges are slightly different in MSX2.

MSX2 has three types of memory, ROM, RAM, VRAM, which are described below.


##### ROM

Standard ROM size is 48K bytes. The MSX ROM uses only 32K bytes. The extra 16K bytes portion of the MSX2 contains routines supporting the extended features.

The "MAIN-ROM" consists of 32K bytes and contains the BASIC interpreter, and the "extended ROM" or "SUB-ROM" consists of 16K bytes and contains routines for the extended features.


##### RAM

Standard RAM size is 64K bytes, which is large enough so that MSX-DOS can be executed. The RAM size of MSX1 varied from 8K to 64K bytes, so in some cases large programs could not be executed without expanding RAM. MSX2 does not have this problem.


##### VRAM

A minimum of 64K bytes are required for VRAM in order to execute the added features of the screen display. VRAM is thus four times larger than in MSX1, which had only 16 K bytes VRAM. But many machines actually use a VRAM size of 128K bytes, which is eight times larger. Machines with 128K bytes VRAM can display 256 colours at the same time.

MSX machines which have 64K bytes VRAM but cannot be expanded to 128K bytes are marked "VRAM64K" on their catalogue or packaging.


#### VDP

The MSX series computers use a video display processor (VDP) type LSI chip for controlling the screen output. The VDP used for MSX1 was the TMS9918, but the MSX2 uses the V9938 (MSX-VIDEO), which has upper and full compatibility with the TMS9918 and can execute software for TMS9918 without any modification.

[Table 1.2](#table-12--vdp-specifications) shows the VDP standard and [Table 1.3](#table-13--v9938-screen-mode) shows each screen mode. V9938 is an excellent LSI chip with digitising, superimposing, and hardware scrolling features. [Chapter 4](Chapter4a.md) of this manual describes it in detail.


##### _Table 1.2  VDP specifications_

```
                                    V9938           |       TMS9918
                        ----------------------------+----------------------
Screen mode             |  10 (see table 1.3)       |          4          |
                        |---------------------------+---------------------|
Number of dots          |  512 x 212 maximum        |                     |
(horizontal x           |  424 dots for vertical    |  256 x 192 maximum  |
vertical)               |  can be achieved by       |                     |
                        |  interlace feature        |                     |
                        |---------------------------+---------------------|
          Number of     |                           |                     |
          colours to    |  512 maximum              |   16 maximum        |
          specify       |                           |                     |
Colour                  |---------------------------+---------------------|
          Number of     |                           |                     |
          colours to    |  256 maximum              |   16 maximum        |
          display at    |                           |                     |
          the same time |                           |                     |
                        |-------------------------------------------------|
Character set           |           alphanumeric + graphic symbols        |
                        |             256 characters  8 x 8 dots          |
                        |-------------------------------------------------|
Sprite colour           |  16 maximum per sprite    |   1 per sprite      |
                        |---------------------------+---------------------|
Palette feature         |  Yes                      |   No                |
                        ---------------------------------------------------
```

##### _Table 1.3  V9938 screen mode_

```
Mode            Number of       Dots       Colours      Palette   Sprite
                characters
---------------------------------------------------------------------------
* Text 1      |  40 x 24   |           |   2 from 512 |   Yes   |   No
  Text 2      |  80 x 24   |           |   4 from 512 |   Yes   |   No
* Multi-colour|            |  64 x  48 |  16 from 512 |   Yes   |  Mode 1
* Graphic 1   |  32 x 24   |           |  16 from 512 |   Yes   |  Mode 1
* Graphic 2   |            | 256 x 192 |  16 from 512 |   Yes   |  Mode 1
  Graphic 3   |            | 256 x 192 |  16 from 512 |   Yes   |  Mode 2
  Graphic 4   |            | 256 x 212 |  16 from 512 |   Yes   |  Mode 2
  Graphic 5   |            | 512 x 212 |   4 from 512 |   Yes   |  Mode 2
  Graphic 6   |            | 512 x 212 |  16 from 512 |   Yes   |  Mode 2
  Graphic 7   |            | 256 x 212 | 256 from 256 |   No    |  Mode 2
---------------------------------------------------------------------------

(*) Feature modes available from TMS9918 (however, palette feature only from V9938).
```

#### Battery-powered Clock-IC

Battery-powered RAM is connected to the I/O port and is used for storage of setup information and for keeping track of the date and time. Setup information specifies the screen colour and mode at reset. This allows the user to set up the desired environment when the system is booted.

The CLOCK-IC works independently of the main power supply. After being set once new time settings are no longer required.


#### RAM Disk Feature

When using BASIC on MSX1 machines which had 64K bytes RAM, only 32K bytes of RAM were used; the other 32K bytes were unused since the BASIC interpreter occupied the address space. On MSX2 machines this unused RAM can be used as a RAMDISK. For users who do not have a disk drive, this feature is very useful when loading or saving BASIC programs temporarily.


<p>&nbsp;</p>

## 2. MSX2 SYSTEM OVERVIEW

This section gives a simple overview of the MSX2 software and hardware systems. To help you understand the concepts, diagrams which would be useful when developing software, such as [VRAM map](Appendix5.md), the [I/O map](Appendix6.md), and the interface standard, are found in the APPENDIX of this manual.


<p>&nbsp;</p>

### 2.1 Hardware overview

First of all, look at the block diagram in [Figure 1.3](#figure-13--msx2-block-diagram) to understand the hardware configuration of the MSX2 as a whole.


##### _Figure 1.3  MSX2 block diagram_

![Figure 1.3](https://raw.githubusercontent.com/Konamiman/MSX2-Technical-Handbook/add-pics/pics/Figure%201.3.png)


#### 2.1.1 Address map

##### Memory map

The MSX2 has three kinds of memory: MAIN-ROM, SUB-ROM, and RAM. Each memory resides in an independent 64K address space and is allocated as shown in [Figure 1.4](#figure-14--msx2-standard-memory) (1) (each 64K space is called a "slot", which consists of four 16K areas called "pages"). [Figures 1.3](#figure-13--msx2-block-diagram) (2) and (3) show memory usage when using BASIC and MSX-DOS, respectively.

For each class of memory, [Figure 1.5](#figure-15--main-rom-memory-map) shows the memory map of [Figure 1.4](#figure-14--msx2-standard-memory) (1)(a), [Figure 1.6](#figure-16--sub-rom-memory-map) for [Figure 1.4](#figure-14--msx2-standard-memory) (1)(b), and [Figure 1.7](#figure-17--main-ram-memory-map) for [Figure 1.4](#figure-14--msx2-standard-memory) (1)(c). There is also a [VRAM map](Appendix5.md) and [I/O map](Appendix6.md) whose standards are defined. They are found in the APPENDIX.


##### _Figure 1.4  MSX2 standard memory_

```
(1) Physical allocation of standard memories

             (a)            (b)            (c)
0000H   -------------  -------------  -------------
Page 0  |    (1)    |  |    (3)    |  |    (4)    |
        | MAIN-ROM  |  |  SUB-ROM  |  |    RAM    |
4000H   | - - - - - |  |-----------|  | - - - - - |
Page 1  |    (2)    |  |   not     |  |    (5)    |
        | MAIN-ROM  |  |   used    |  |    RAM    |
8000H   |-----------|  | - - - - - |  | - - - - - |
Page 2  |   not     |  |   not     |  |    (6)    |
        |   used    |  |   used    |  |    RAM    |
C000H   | - - - - - |  | - - - - - |  | - - - - - |
Page 3  |   not     |  |   not     |  |    (7)    |
        |   used    |  |   used    |  |    RAM    |
        -------------  -------------  -------------
          MAIN-ROM        SUB-ROM        64K-RAM
            SLOT           SLOT           SLOT

(2) CPU memory space when using BASIC           (3) CPU memory space
                                                    when using MSX-DOS
0000H   -------------  -------------                -------------
Page 0  |    (1)    |  |    (3)    |                |    (4)    |
        | MAIN-ROM  |  |  SUB-ROM  |                |    RAM    |
4000H   | - - - - - |  -------------                | - - - - - |
Page 1  |    (2)    |   1 and 3 are                 |    (5)    |
        | MAIN-ROM  |   switched                    |    RAM    |
8000H   |-----------|   under certain               | - - - - - |
Page 2  |    (6)    |   circumstances               |    (6)    |
        |    RAM    |                               |    RAM    |
C000H   | - - - - - |                               | - - - - - |
Page 3  |    (6)    |                               |    (7)    |
        |    RAM    |                               |    RAM    |
        -------------                               -------------

Note: Four pages (4 to 7) of 64K RAM are not always in the same slot.
```

##### _Figure 1.5  MAIN-ROM memory map_

```
0000H   --------------
        |    BIOS    |
        |    Entry   |
015CH   |------------|
        | Additional |
        | BIOS Entry |
017AH   |------------|
        |   Empty    |
01B6H   |------------|
        |   BASIC    |
        | Interpreter|
7FFDH   |------------|
        |    BDOS    |
7FFFH   |    Entry   |
8000H   |------------|
        |            |
```

##### _Figure 1.6  SUB-ROM memory map_


```
0000h   --------------
        |    BIOS    |
        |    Entry   |
01FDH   |------------|
        |    SLOT    |
        | Management |
        |   Control  |
0336H   |------------|
        |    BASIC   |
        | Interpreter|
3FFFH   |  and BIOS  |
        --------------
```

##### _Figure 1.7  MAIN-RAM memory map_


```
0000H    -------------
         |           |
         |  RAM Disk |
         |           |
         |   Area    |
         |           |
8000H    |-----------|
         |           |
         |   User    |
         |   Area    |
         |           |
F380H    |-----------|
         |  System   |
         | Work Area |
FD9AH    |-----------|
         |  RAM Hook |
         |   Area    |
FFCAH    |-----------|
         | Expanded  |
         | BIOS call |
         |  Entry    |
FFCFH    |-----------|
         | Interrupt |
         |  Control  |--> Note: Used for the disk
         | Hook Area |          and RS-232 interface
FFD9H    |-----------|
         | Interrupt |
         |  Control  |--> Note: Used for the RS-232
         |  Program  |          interface
         |   Area    |
FFE7H    |-----------|
         |  New VDP  |
         |  Register |
         | Subroutine|
         |   Area    |
FFF7H    |-----------|
         |  Main ROM |
         |    Slot   |
         |  Address  |
FFF8H    |-----------|
         | Reserved  |
FFFCH    |-----------|
         |   Slot    |
         | Selection |
FFFFH    | Register  |
         -------------
```

<p>&nbsp;</p>

#### 2.1.2 Interfacing with peripherals

MSX2 interfacing with peripherals is standardised in detail.

The following is a list of standardised interfaces:

- Display interface
- Audio interface
- Cassette interface
- General-purpose input/output interface
- Printer interface

The printer interface was optional on the MSX1 but is standard on the MSX2.

The disk drive interface is still an option but may be considered part of the standard specification because the MSX2 has 64K bytes of RAM.

For detailed information about the cartridge specifications, see the appendix.


<p>&nbsp;</p>

### 2.2 Software Overview

The MSX has two software environments: BASIC mode and DOS mode. BASIC mode enables easy development and execution of MSX-BASIC program and is the mode most often used by most users. A major reason why the use of personal computers has grown is that BASIC is easy to use.

The DOS mode enables various languages, utilities, and applications using MSX-DOS. Most programs in DOS can be executed on different machines. The computers automatically compensate for any differences in hardware. This allows the user to use accumulated software resources efficiently. MSX-DOS uses the same disk format as MS-DOS, which is popular on 16-bit machines. You should also note that software for CP/M, which has a great deal of applications available for 8-bit machines, can be executed only by doing file conversions.

A remarkable point is that BASIC and DOS use the same disk format in the MSX machines. This enables the sharing of resources. Both are, as shown in [Figure 1.8](#figure-18--software-hierarchy-of-msx1-and-msx2), on the united software environment which has BIOS (Basic I/O System) as a common basis. BDOS (Basic Disk Operating System), which is the basis of the disk operation, is also constructed on this BIOS. MSX offers the same programming environment to BASIC and DOS through common BDOS and BIOS.


##### _Figure 1.8  Software hierarchy of MSX1 and MSX2_

![Figure 1.8](https://raw.githubusercontent.com/Konamiman/MSX2-Technical-Handbook/add-pics/pics/Figure%201.8.png)
