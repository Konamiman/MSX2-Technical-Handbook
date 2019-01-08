

=============================================================================

Changes from the original in APPENDIX 5:

- The original VRAM mapping figures have been converted to simple text tables.

- In SCREEN 0 (WIDTH 80) map, different end addresses for the blink table are indicated for 24 lines mode and 26.5 lines mode.

-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-


APPENDIX 5 - VRAM MAP


* SCREEN 0 (WIDTH 40) / TEXT 1

0000H - 03BFH   -->     Pattern name table
0400H - 042FH   -->     Palette table
0800H - 0FFFH   -->     Pattern generator table


* SCREEN 0 (WIDTH 80) / TEXT 2

0000H - 077FH   -->     Pattern name table
0800H - 08EFH   -->     Blink table (24 lines mode)
        090DH                       (26.5 lines mode)
0F00H - 0F2FH   -->     Palette table
1000H - 17FFH   -->     Pattern generator table


* SCREEN 1 / GRAPHIC 1

0000H - 07FFH   -->     Pattern generator table
1800H - 1AFFH   -->     Pattern name table
1B00H - 1B7FH   -->     Sprite attribute table
2000H - 201FH   -->     Colour table
2020H - 204FH   -->     Palette table
3800H - 3FFFH   -->     Sprite generator table


* SCREEN 2 / GRAPHIC 2

0000H - 07FFH   -->     Pattern generator table 1
0800H - 0FFFH   -->     Pattern generator table 2
1000H - 17FFH   -->     Pattern generator table 3
1800H - 18FFH   -->     Pattern name table 1
1900H - 19FFH   -->     Pattern name table 2
1A00H - 1AFFH   -->     Pattern name table 3
1B00H - 1B7FH   -->     Sprite attribute table
1B80H - 1BAFH   -->     Palette table
2000H - 27FFH   -->     Colour table 1
2800H - 2FFFH   -->     Colour table 2
3000H - 37FFH   -->     Colour table 3
3800H - 3FFFH   -->     Sprite generator table


* SCREEN 3 / MULTI COLOUR

0000H - 07FFH   -->     Pattern generator table
0800H - 0AFFH   -->     Pattern name table
1B00H - 1B7FH   -->     Sprite attribute table
2020H - 204FH   -->     Palette table
3800H - 3FFFH   -->     Sprite generator table


* SCREEN 4 / GRAPHIC 3

0000H - 07FFH   -->     Pattern generator table 1
0800H - 0FFFH   -->     Pattern generator table 2
1000H - 17FFH   -->     Pattern generator table 3
1800H - 18FFH   -->     Pattern name table 1
1900H - 19FFH   -->     Pattern name table 2
1A00H - 1AFFH   -->     Pattern name table 3
1B80H - 1BAFH   -->     Palette table
1C00H - 1DFFH   -->     Sprite colour table
1E00H - 1E7FH   -->     Sprite attribute table
2000H - 27FFH   -->     Colour table 1
2800H - 2FFFH   -->     Colour table 2
3000H - 37FFH   -->     Colour table 3
3800H - 3FFFH   -->     Sprite generator table


* SCREEN 5, 6 / GRAPHIC 4, 5

0000H - 5FFFH   -->     Pattern name table (192 lines)
        69FFH                              (212 lines)
7400H - 75FFH   -->     Sprite colour table
7600H - 767FH   -->     Sprite attribute table
7680H - 76AFH   -->     Palette table
7A00H - 7FFFH   -->     Sprite generator table


* SCREEN 7, 8 / GRAPHIC 6, 7

0000H - BFFFH   -->     Pattern name table (192 lines)
        D3FFH                              (212 lines)
F000H - F7FFH   -->     Sprite generator table
F800H - F9FFH   -->     Sprite colour table
FA00H - FA7FH   -->     Sprite attribute table
FA80H - FAAFH   -->     Palette table


=============================================================================

Changes from the original in APPENDIX 6:

none

-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-


APPENDIX 6 - I/O MAP


00H to 3FH      user defined

40H to 7FH      reserved

80H to 87H      for RS-232C
      80H       8251 data
      81H       8251 status/command
      82H       status read/interrupt mask
      83H       unused
      84H       8253
      85H       8253
      86H       8253
      87H       8253

88H to 8BH      VDP (9938) I/O port for MSX1 adaptor
                This is V9938 I/O for MSX1. To access VDP directly,
                examine 06H and 07H of MAIN-ROM to confirm the port
                address

8CH to 8DH      for the modem

8EH to 8FH      reserved

90H to 91H      printer port
      90H       bit 0: strobe output (write)
                bit 1: status input (read)
      91H       data to be printed

92H to 97H      reserved

98H to 9BH      for MSX2 VDP (V9938)
      98H       VRAM access
      99H       command register access
      9AH       palette register access (write only)
      9BH       register pointer (write only)

9CH to 9FH      reserved

A0H to A3H      sound generator (AY-3-8910)
      A0H       address latch
      A1H       data read
      A2H       data write

A4H to A7H      reserved

A8H to ABH      parallel port (8255)
      A8H       port A
      A9H       port B
      AAH       port C
      ABH       mode set

ACH to AFH      MSX engine (one chip MSX I/O)

B0H to B3H      expansion memory (SONY specification) (8255)
      A8H       port A, address (A0 to A7)
      A9H       port B, address (A8 to A10, A13 to A15), control R/"
      AAH       port C, address (A11 to A12), data (D0 - D7)
      ABH       mode set

B4H to B5H      CLOCK-IC (RP-5C01)
      B4H       address latch
      B5H       data

B6H to B7H      reserved

B8H to BBH      lightpen control (SANYO specification)
      B8H       read/write
      B9H       read/write
      BAH       read/write
      BBH       write only

BCH to BFH      VHD control (JVC) (8255)
      BCH       port A
      BDH       port B
      BEH       port C

C0H to C1H      MSX-Audio

C2H to C7H      reserved

C8H to CFH      MSX interface

D0H to D7H      floppy disk controller (FDC)
                The floppy disk controller can be interrupted by an
                external signal. Interrupt is possible only when the
                FDC is accessed. Thus, the system can treat different
                FDC interfaces.

D8 to D9H       kanji ROM (TOSHIBA specification)
     D8H        b5-b0           lower address (write only)
     D9H        b5-b0           upper address (write)
                b7-b0           data (read)

DAH to DBH      for future kanji expansion

DCH to F4H      reserved

F5H             system control (write only)
                setting bit to 1 enables available I/O devices
        b0      kanji ROM
        b1      reserved for kanji
        b2      MSX-AUDIO
        b3      superimpose
        b4      MSX interface
        b5      RS-232C
        b6      lightpen
        b7      CLOCK-IC (only on MSX2)
                Bits to void the conflict between internal I/O
                devices or those connected by cartridge. The bits
                can disable the internal devices. When BIOS is initialised,
                internal devices are valid if no external devices are
                connected. Applications may not write to or read from here.

F8H             colour bus I/O

F7H             A/V control
        b0      audio R                 mixing ON (write)
        b1      audio L                 mixing OFF (write)
        b2      select video input      21p RGB (write)
        b3      detect video input      no input (read)
        b4      AV control              TV (write)
        b5      Ym control              TV (write)
        b6      inverse of bit 4 of VDP register 9 (write)
        b7      inverse of bit 5 of VDP register 9 (write)

F8H to FBH      reserved

FCH to FFH      memory mapper


=============================================================================

Changes from the original in APPENDIX 8:

none

-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-


APPENDIX 8 - CONTROL CODES

-------------------------------------------------------------------------
| Code | Code |                                   |    Corresponding    |
| (dec)| (hex)|             Function              |        key(s)       |
|------+------+-----------------------------------+---------------------|
|   0  |  00H |                                   | CTRL + @            |
|      |      |                                   |                     |
|   1  |  01H | header at input/output of graphic | CTRL + A            |
|      |      | characters                        |                     |
|      |      |                                   |                     |
|   2  |  02H | move cursor to the top of the     | CTRL + B            |
|      |      | previous word                     |                     |
|      |      |                                   |                     |
|   3  |  03H | end the input-waiting state       | CTRL + C            |
|      |      |                                   |                     |
|   4  |  04H |                                   | CTRL + D            |
|      |      |                                   |                     |
|   5  |  05H | delete below cursor               | CTRL + E            |
|      |      |                                   |                     |
|   6  |  06H | move cursor to the top of the     | CTRL + F            |
|      |      | next word                         |                     |
|      |      |                                   |                     |
|   7  |  07H | speaker output                    | CTRL + G            |
|      |      | (same as the BEEP statement)      |                     |
|      |      |                                   |                     |
|   8  |  08H | delete a character before cursor  | CTRL + H or BS      |
|      |      |                                   |                     |
|   9  |  09H | move to next horizontal tab stop  | CTRL + I or TAB     |
|      |      |                                   |                     |
|  10  |  0AH | line feed                         | CTRL + J            |
|      |      |                                   |                     |
|  11  |  0BH | home cursor                       | CTRL + K or HOME    |
|      |      |                                   |                     |
|  12  |  0CH | clear screen and home cursor      | CTRL + L or CLS     |
|      |      |                                   |                     |
|  13  |  0DH | carriage return                   | CTRL + M or RETURN  |
|      |      |                                   |                     |
|  14  |  0EH | move cursor to the end of line    | CTRL + N            |
|      |      |                                   |                     |
|  15  |  0FH |                                   | CTRL + O            |
|      |      |                                   |                     |
|  16  |  10H |                                   | CTRL + P            |
|      |      |                                   |                     |
|  17  |  11H |                                   | CTRL + Q            |
|      |      |                                   |                     |
|  18  |  12H | insert mode ON/OFF                | CTRL + R or INS     |
|      |      |                                   |                     |
|  19  |  13H |                                   | CTRL + S            |
|      |      |                                   |                     |
|  20  |  14H |                                   | CTRL + T            |
|      |      |                                   |                     |
|  21  |  15H | delete one line from screen       | CTRL + U            |
|      |      |                                   |                     |
|  22  |  16H |                                   | CTRL + V            |
|      |      |                                   |                     |
|  23  |  17H |                                   | CTRL + W            |
|      |      |                                   |                     |
|  24  |  18H |                                   | CTRL + X or SELECT  |
|      |      |                                   |                     |
|  25  |  19H |                                   | CTRL + Y            |
|      |      |                                   |                     |
|  26  |  1AH |                                   | CTRL + Z            |
|      |      |                                   |                     |
|  27  |  1BH |                                   | CTRL + [ or ESC     |
|      |      |                                   |                     |
|  28  |  1CH | move cursor right                 | CTRL + \ or RIGHT   |
|      |      |                                   |                     |
|  29  |  1DH | move cursor left                  | CTRL + ] or LEFT    |
|      |      |                                   |                     |
|  30  |  1EH | move cursor up                    | CTRL + ^ or UP      |
|      |      |                                   |                     |
|  31  |  1FH | move cursor down                  | CTRL + _ or DOWN    |
|      |      |                                   |                     |
| 127  |  7FH | delete character under cursor     |             DEL     |
|      |      |                                   |                     |
-------------------------------------------------------------------------


=============================================================================

Changes from the original in APPENDIX 10:

none

-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-


APPENDIX 10 - ESCAPE SEQUENCES


* Cursor movement

<ESC> A         move cursor up
<ESC> B         move cursor down
<ESC> C         move cursor right
<ESC> D         move cursor left
<ESC> H         move cursor home
<ESC> Y <Y-coordinate+20H> <X-coordinate+20H>
                move cursor to (X, Y)


* Edit, delete

<ESC> j         clear screen
<ESC> E         clear screen
<ESC> K         delete to end of line
<ESC> J         delete to end of screen
<ESC> L         insert one line
<ESC> M         delete one line


* Miscellaneous

<ESC> x4        set block cursor
<ESC> x5        hide cursor
<ESC> y4        set underline cursor
<ESC> y5        display cursor


============================================================================

APPENDIX 7 - CARTRIDGE HARDWARE

and

APPENDIX 9 - CHARACTER SET

are not available here

