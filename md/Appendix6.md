# APPENDIX 6 - I/O MAP


<p>&nbsp;</p>

* **00H to 3FH**: user defined

* **40H to 7FH**: reserved

* **80H to 87H**: for RS-232C
  * 80H: 8251 data
  * 81H: 8251 status/command
  * 82H: status read/interrupt mask
  * 83H: unused
  * 84H: 8253
  * 85H: 8253
  * 86H: 8253
  * 87H: 8253

* **88H to 8BH**: VDP (9938) I/O port for MSX1 adaptor

  This is V9938 I/O for MSX1. To access VDP directly, examine 06H and 07H of MAIN-ROM to confirm the port address

* **8CH to 8DH**: for the modem

* **8EH to 8FH**: reserved

* **90H to 91H**: printer port
  * 90H
    * bit 0: strobe output (write)
    * bit 1: status input (read)
  * 91H: data to be printed

* **92H to 97H**: reserved

* **98H to 9BH**: for MSX2 VDP (V9938)
  * 98H: VRAM access
  * 99H: command register access
  * 9AH: palette register access (write only)
  * 9BH: register pointer (write only)

* **9CH to 9FH**: reserved

* **A0H to A3H**: sound generator (AY-3-8910)
  * A0H: address latch
  * A1H: data read
  * A2H: data write

* **A4H to A7H**: reserved

* **A8H to ABH**: parallel port (8255)
  * A8H: port A
  * A9H: port B
  * AAH: port C
  * ABH: mode set

* **ACH to AFH**: MSX engine (one chip MSX I/O)

* **B0H to B3H**: expansion memory (SONY specification) (8255)
  * A8H: port A, address (A0 to A7)
  * A9H: port B, address (A8 to A10, A13 to A15), control R/W
  * AAH: port C, address (A11 to A12), data (D0 - D7)
  * ABH: mode set

* **B4H to B5H**: CLOCK-IC (RP-5C01)
  * B4H: address latch
  * B5H: data

* **B6H to B7H**: reserved

* **B8H to BBH**: lightpen control (SANYO specification)
  * B8H: read/write
  * B9H: read/write
  * BAH: read/write
  * BBH: write only

* **BCH to BFH**: VHD control (JVC) (8255)
  * BCH: port A
  * BDH: port B
  * BEH: port C

* **C0H to C1H**: MSX-Audio

* **C2H to C7H**: reserved

* **C8H to CFH**: MSX interface

* **D0H to D7H**: floppy disk controller (FDC)

  The floppy disk controller can be interrupted by an external signal. Interrupt is possible only when the FDC is accessed. Thus, the system can treat different FDC interfaces.

* **D8 to D9H**: kanji ROM (TOSHIBA specification)
  * D8H: b5-b0, lower address (write only)
  * D9H
    * b5-b0: upper address (write)
    * b7-b0: data (read)

* **DAH to DBH**: for future kanji expansion

* **DCH to F4H**: reserved

* **F5H**: system control (write only), setting bit to 1 enables available I/O devices
  * b0: kanji ROM
  * b1: reserved for kanji
  * b2: MSX-AUDIO
  * b3: superimpose
  * b4: MSX interface
  * b5: RS-232C
  * b6: lightpen
  * b7: CLOCK-IC (only on MSX2)

  Bits to void the conflict between internal I/O devices or those connected by cartridge. The bits can disable the internal devices. When BIOS is initialised, internal devices are valid if no external devices are connected. Applications may not write to or read from here.

* **F8H**: colour bus I/O

* **F7H**: A/V control
  * b0: audio R - mixing ON (write)
  * b1: audio L - mixing OFF (write)
  * b2: select video input - 21p RGB (write)
  * b3: detect video input - no input (read)
  * b4: AV control - TV (write)
  * b5: Ym control - TV (write)
  * b6: inverse of bit 4 of VDP register 9 (write)
  * b7: inverse of bit 5 of VDP register 9 (write)

* **F8H to FBH**: reserved

* **FCH to FFH**: memory mapper
