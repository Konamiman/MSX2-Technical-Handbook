# APPENDIX 5 - VRAM MAP


<p>&nbsp;</p>

## Index

[SCREEN 0 (WIDTH 40) / TEXT 1](#screen-0-width-40--text-1)

[SCREEN 0 (WIDTH 80) / TEXT 2](#screen-0-width-80--text-2)

[SCREEN 1 / GRAPHIC 1](#screen-1--graphic-1)

[SCREEN 2 / GRAPHIC 2](#screen-2--graphic-2)

[SCREEN 3 / MULTI COLOUR](#screen-3--multi-colour)

[SCREEN 4 / GRAPHIC 3](#screen-4--graphic-3)

[SCREEN 5, 6 / GRAPHIC 4, 5](#screen-5-6--graphic-4-5)

[SCREEN 7, 8 / GRAPHIC 6, 7](#screen-7-8--graphic-6-7)

[Changes from the original](#changes-from-the-original)


<p>&nbsp;</p>

## SCREEN 0 (WIDTH 40) / TEXT 1

| Address range | Usage |
| --- | --- |
| 0000H - 03BFH | Pattern name table |
| 0400H - 042FH | Palette table |
| 0800H - 0FFFH | Pattern generator table |


<p>&nbsp;</p>

## SCREEN 0 (WIDTH 80) / TEXT 2

| Address range | Usage |
| --- | --- |
| 0000H - 077FH | Pattern name table |
| 0800H - 08EFH | Blink table (24 lines mode) |
| 0800H - 090DH | Blink table (26.5 lines mode) |
| 0F00H - 0F2FH | Palette table |
| 1000H - 17FFH | Pattern generator table |


<p>&nbsp;</p>

## SCREEN 1 / GRAPHIC 1

| Address range | Usage |
| --- | --- |
| 0000H - 07FFH | Pattern generator table |
| 1800H - 1AFFH | Pattern name table |
| 1B00H - 1B7FH | Sprite attribute table |
| 2000H - 201FH | Colour table |
| 2020H - 204FH | Palette table |
| 3800H - 3FFFH | Sprite generator table |


<p>&nbsp;</p>

## SCREEN 2 / GRAPHIC 2

| Address range | Usage |
| --- | --- |
| 0000H - 07FFH | Pattern generator table 1 |
| 0800H - 0FFFH | Pattern generator table 2 |
| 1000H - 17FFH | Pattern generator table 3 |
| 1800H - 18FFH | Pattern name table 1 |
| 1900H - 19FFH | Pattern name table 2 |
| 1A00H - 1AFFH | Pattern name table 3 |
| 1B00H - 1B7FH | Sprite attribute table |
| 1B80H - 1BAFH | Palette table |
| 2000H - 27FFH | Colour table 1 |
| 2800H - 2FFFH | Colour table 2 |
| 3000H - 37FFH | Colour table 3 |
| 3800H - 3FFFH | Sprite generator table |


<p>&nbsp;</p>

## SCREEN 3 / MULTI COLOUR

| Address range | Usage |
| --- | --- |
| 0000H - 07FFH | Pattern generator table |
| 0800H - 0AFFH | Pattern name table |
| 1B00H - 1B7FH | Sprite attribute table |
| 2020H - 204FH | Palette table |
| 3800H - 3FFFH | Sprite generator table |


<p>&nbsp;</p>

## SCREEN 4 / GRAPHIC 3

| Address range | Usage |
| --- | --- |
| 0000H - 07FFH | Pattern generator table 1 |
| 0800H - 0FFFH | Pattern generator table 2 |
| 1000H - 17FFH | Pattern generator table 3 |
| 1800H - 18FFH | Pattern name table 1 |
| 1900H - 19FFH | Pattern name table 2 |
| 1A00H - 1AFFH | Pattern name table 3 |
| 1B80H - 1BAFH | Palette table |
| 1C00H - 1DFFH | Sprite colour table |
| 1E00H - 1E7FH | Sprite attribute table |
| 2000H - 27FFH | Colour table 1 |
| 2800H - 2FFFH | Colour table 2 |
| 3000H - 37FFH | Colour table 3 |
| 3800H - 3FFFH | Sprite generator table |


<p>&nbsp;</p>

## SCREEN 5, 6 / GRAPHIC 4, 5

| Address range | Usage |
| --- | --- |
| 0000H - 5FFFH | Pattern name table (192 lines) |
| 0000H - 69FFH | Pattern name table (212 lines) |
| 7400H - 75FFH | Sprite colour table |
| 7600H - 767FH | Sprite attribute table |
| 7680H - 76AFH | Palette table |
| 7A00H - 7FFFH | Sprite generator table |


<p>&nbsp;</p>

## SCREEN 7, 8 / GRAPHIC 6, 7

| Address range | Usage |
| --- | --- |
| 0000H - BFFFH | Pattern name table (192 lines) |
| 0000H - D3FFH | Pattern name table (212 lines) |
| F000H - F7FFH | Sprite generator table |
| F800H - F9FFH | Sprite colour table |
| FA00H - FA7FH | Sprite attribute table |
| FA80H - FAAFH | Palette table |


<p>&nbsp;</p>

## Changes from the original

- The original VRAM mapping figures have been converted to simple text tables.

- In [SCREEN 0 (WIDTH 80)](#screen-0-width-80--text-2) map, different end addresses for the blink table are indicated for 24 lines mode and 26.5 lines mode.
