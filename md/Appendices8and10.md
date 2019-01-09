# APPENDIX 8 - CONTROL CODES

| Code (dec) | Code (hex) | Function|    Corresponding  key(s)    |
| --- | --- | --- | --- |
|   0  |  00H |                                   | CTRL + @            |
|   1  |  01H | header at input/output of graphic characters | CTRL + A |
|   2  |  02H | move cursor to the top of the previous word  | CTRL + B |
|   3  |  03H | end the input-waiting state       | CTRL + C            |
|   4  |  04H |                                   | CTRL + D            |
|   5  |  05H | delete below cursor               | CTRL + E            |
|   6  |  06H | move cursor to the top of the next word | CTRL + F      |
|   7  |  07H | speaker output (same as the BEEP statement) | CTRL + G  |
|   8  |  08H | delete a character before cursor  | CTRL + H or BS      |
|   9  |  09H | move to next horizontal tab stop  | CTRL + I or TAB     |
|  10  |  0AH | line feed                         | CTRL + J            |
|  11  |  0BH | home cursor                       | CTRL + K or HOME    |
|  12  |  0CH | clear screen and home cursor      | CTRL + L or CLS     |
|  13  |  0DH | carriage return                   | CTRL + M or RETURN  |
|  14  |  0EH | move cursor to the end of line    | CTRL + N            |
|  15  |  0FH |                                   | CTRL + O            |
|  16  |  10H |                                   | CTRL + P            |
|  17  |  11H |                                   | CTRL + Q            |
|  18  |  12H | insert mode ON/OFF                | CTRL + R or INS     |
|  19  |  13H |                                   | CTRL + S            |
|  20  |  14H |                                   | CTRL + T            |
|  21  |  15H | delete one line from screen       | CTRL + U            |
|  22  |  16H |                                   | CTRL + V            |
|  23  |  17H |                                   | CTRL + W            |
|  24  |  18H |                                   | CTRL + X or SELECT  |
|  25  |  19H |                                   | CTRL + Y            |
|  26  |  1AH |                                   | CTRL + Z            |
|  27  |  1BH |                                   | CTRL + [ or ESC     |
|  28  |  1CH | move cursor right                 | CTRL + \ or RIGHT   |
|  29  |  1DH | move cursor left                  | CTRL + ] or LEFT    |
|  30  |  1EH | move cursor up                    | CTRL + ^ or UP      |
|  31  |  1FH | move cursor down                  | CTRL + _ or DOWN    |
| 127  |  7FH | delete character under cursor     |             DEL     |


<p>&nbsp;</p>

# APPENDIX 10 - ESCAPE SEQUENCES


### Cursor movement

| Sequence | Function |
| --- | --- |
| \<ESC\> A | move cursor up |
| \<ESC\> B | move cursor down |
| \<ESC\> C | move cursor right |
| \<ESC\> D | move cursor left |
| \<ESC\> H | move cursor home |
| \<ESC\> Y \<Y-coordinate+20H\> \<X-coordinate+20H\> | move cursor to (X, Y) |


### Edit, delete

| Sequence | Function |
| --- | --- |
| \<ESC\> j | clear screen |
| \<ESC\> E | clear screen |
| \<ESC\> K | delete to end of line |
| \<ESC\> J | delete to end of screen |
| \<ESC\> L | insert one line |
| \<ESC\> M | delete one line |


### Miscellaneous

| Sequence | Function |
| --- | --- |
| \<ESC\> x4 | set block cursor |
| \<ESC\> x5 | hide cursor |
| \<ESC\> y4 | set underline cursor |
| \<ESC\> y5 | display cursor |
