# APPENDIX 2 - MATH-PACK

The Math-Pack is the core for the mathematical routines of MSX-BASIC and, by calling these routines from an assembly language program, floating-point operations and trigonometrical functions are available.


<p>&nbsp;</p>

## Index

[Math-Pack work area](#math-pack-work-area)

[Basic operation](#basic-operation)

[Function 1](#function-1)

[Function 2](#function-2)

[Movement](#movement)

[Comparison](#comparison)

[Floating-point input/output](#floating-point-inputoutput)

[Type conversion](#type-conversion)

[Integer operation](#integer-operation)

[Power](#power)

[Changes from the original](#changes-from-the-original)


<p>&nbsp;</p>

Any operations involving real numbers in Math-Pack are done in BCD (Binary Coded Decimal). There are two ways of expressing a real number, "single precision" and "double precision"; a single precision real number (6 digits) is expressed by 4 bytes and a double precision real number (14 digits) by 8 bytes (see [Figure A.1](#figure-a1--bcd-format-for-expressing-real-numbers) and [Figure A.2](#figure-a2--examples-of-expressions-for-real-numbers)).


##### _Figure A.1  BCD format for expressing real numbers_

```
                     MSB   7     6     5     4     3     2     1     0   LSB
  ---          ---      -------------------------------------------------
   ^            ^       |sign |                exponent                 |  0
   |            |       -------------------------------------------------
   |            |       -------------------------------------------------
   |            |       |  mantissa 1st place   |  mantissa 2nd place   |  1
   |          single    -------------------------------------------------
   |         precision  -------------------------------------------------
   |            |       |  mantissa 3rd place   |  mantissa 4th place   |  2
   |            |       -------------------------------------------------
   |            |       -------------------------------------------------
   |            V       |  mantissa 5th place   |  mantissa 6th place   |  3
 double        ---      -------------------------------------------------
precision               -------------------------------------------------
   |                    |  mantissa 7th place   |  mantissa 8th place   |  4
   |                    -------------------------------------------------
   |                    -------------------------------------------------
   |                    |  mantissa 9th place   |  mantissa 10th place  |  5
   |                    -------------------------------------------------
   |                    -------------------------------------------------
   |                    |  mantissa 11th place  |  mantissa 12th place  |  6
   |                    -------------------------------------------------
   |                    -------------------------------------------------
   V                    |  mantissa 13th place  |  mantissa 14th place  |  7
  ---                   -------------------------------------------------
```


##### _Figure A.2  Examples of expressions for real numbers_

```
        Example of the single precision expression

         123456 --> 0.123456 E+6

                       1     2     3     4
                    -------------------------
                DAC |  46 |  12 |  34 |  56 |
                    -------------------------

        Example of the double precision expression

         123456.78901234 --> 0.12345678901234 E+6

                       1     2     3     4     5     6     7     8
                    -------------------------------------------------
                DAC |  46 |  12 |  34 |  56 |  78 |  90 |  12 |  34 |
                    -------------------------------------------------
```

A real number consists of a sign, an exponent, and a mantissa. The sign represents the sign of the mantissa; 0 for positive, 1 for negative. The exponent is a binary expression and can be expressed as a power from +63 to -63, with an excess of 64 (see [Figure A.3](#figure-a3--exponent-format)). [Figure A.4](#figure-a4--valid-range-for-double-precision-real-numbers) shows the valid range of double precision real numbers.


##### _Figure A.3  Exponent format_

```
|sign |<--------------- exponent -------------->|       meaning
-------------------------------------------------
|  0  |  0     0     0     0     0     0     0  | ..... 0
-------------------------------------------------
-------------------------------------------------
|  1  |  0     0     0     0     0     0     0  | ..... undefined (-0?)
-------------------------------------------------
-------------------------------------------------
|  x  |  0     0     0     0     0     0     1  | ..... -63rd power of 10
-------------------------------------------------
-------------------------------------------------
|  x  |  1     0     0     0     0     0     0  | ..... 0th power of 10
-------------------------------------------------
-------------------------------------------------
|  x  |  1     1     1     1     1     1     1  | ..... +63rd power of 10
-------------------------------------------------
```

**Note:** "x" is 1 or 0, both of which are allowed.


##### _Figure A.4  Valid range for double precision real numbers_

```
       7     6     5     4     3     2     1     0     (byte)
    -------------------------------------------------
DAC |  FF |  99 |  99 |  99 |  99 |  99 |  99 |  99 |  -0.99999999999999 E+63
    -------------------------------------------------
                            .
                            .
                            .
    -------------------------------------------------
    |  81 |  10 |  00 |  00 |  00 |  00 |  00 |  00 |  -0.10000000000000 E-63
    -------------------------------------------------
    -------------------------------------------------
    |  00 |  x  |  x  |  x  |  x  |  x  |  x  |  x  |   0
    -------------------------------------------------
    -------------------------------------------------
    |  01 |  10 |  00 |  00 |  00 |  00 |  00 |  00 |  +0.10000000000000 E-63
    -------------------------------------------------
                            .
                            .
                            .
    -------------------------------------------------
    |  7F |  99 |  99 |  99 |  99 |  99 |  99 |  99 |  +0.99999999999999 E+63
    -------------------------------------------------
```

In Math-Pack, the memory is predefined for operation. This memory area is called "DAC (Decimal ACumulator (F7F6H)" and the area which reserves the numerical value to be operated is called "ARG (F847H)". For example, in multiplication, the product of the numbers in DAC and ARG is calculated and the result is returned in the DAC.

In the DAC, single precision real numbers, double precision real numbers, and two-byte integers can be stored. In order to distinguish them, "VALTYP (F663H)" is used and its value is 4 for single precision real numbers, 8 for double precision real numbers, and 2 for two-byte integers.

Single and double precision numbers must be stored from the top of the DAC. For two-byte integers, the low and high bytes should be stored in DAC + 2 and DAC + 3.

Since Math-Pack is an internal routine of BASIC, when an error occurs (such as division by 0 or overflow), control automatically jumps to the corresponding error routine, then returns to BASIC command level. To prevent this, change H.ERRO (FFB1H).


<p>&nbsp;</p>

## Math-Pack work area

```
-----------------------------------------------------------------------------
|   Label   |  Address  |  Size  |                 Meaning                  |
|-----------+-----------+--------+------------------------------------------|
|  VALTYP   |   F663H   |    1   | format of the number in DAC              |
|  DAC      |   F7F6H   |   16   | floating point accumulator in BCD format |
|  ARG      |   F847H   |   16   | argument of DAC                          |
-----------------------------------------------------------------------------
```


<p>&nbsp;</p>

## Math-Pack entry


<p>&nbsp;</p>

### Basic operation

```
-------------------------------------------------
|   Label   |  Address  |       Function        |
|-----------+-----------+-----------------------|
|  DECSUB   |   268CH   |   DAC <-- DAC - ARG   |
|  DECADD   |   269AH   |   DAC <-- DAC + ARG   |
|  DECNRM   |   26FAH   |   normalises DAC (*1) |
|  DECROU   |   273CH   |   rounds DAC          |
|  DECMUL   |   27E6H   |   DAC <-- DAC * ARG   |
|  DECDIV   |   289FH   |   DAC <-- DAC / ARG   |
-------------------------------------------------
```

**Note:** These operations treat numbers in DAC and ARG as the double precision number. Registers are not preserved.

**\*1** Excessive zeros in mantissa are removed. (0.00123 ⟶ 0.123 E-2)


<p>&nbsp;</p>

### Function 1

```
----------------------------------------------------------------------
|   Label   |  Address  |       Function       |  Register modified  |
|-----------+-----------+----------------------+---------------------|
|   COS     |   2993H   |   DAC <-- COS(DAC)   |         all         |
|   SIN     |   29ACH   |   DAC <-- SIN(DAC)   |         all         |
|   TAN     |   29FBH   |   DAC <-- TAN(DAC)   |         all         |
|   ATN     |   2A14H   |   DAC <-- ATN(DAC)   |         all         |
|   LOG     |   2A72H   |   DAC <-- LOG(DAC)   |         all         |
|   SQR     |   2AFFH   |   DAC <-- SQR(DAC)   |         all         |
|   EXP     |   2B4AH   |   DAC <-- EXP(DAC)   |         all         |
|   RND     |   2BDFH   |   DAC <-- RND(DAC)   |         all         |
----------------------------------------------------------------------
```

**Note:** These processing routines all have the same function names as those in BASIC. "All" registers are A, B, C, D, E, H, and L.


<p>&nbsp;</p>

### Function 2

```
----------------------------------------------------------------------
|   Label   |  Address  |       Function       |  Register modified  |
|-----------+-----------+----------------------+---------------------|
|   SIGN    |   2E71H   |   A <-- sign of DAC  |          A          |
|   ABSFN   |   2E82H   |   DAC <-- ABS(DAC)   |         all         |
|   NEG     |   2E8DH   |   DAC <-- NEG(DAC)   |         A,HL        |
|   SGN     |   2E97H   |   DAC <-- SGN(DAC)   |         A,HL        |
----------------------------------------------------------------------
```

**Note:** Except for SIGN, these processing routines all have the same function names as those in BASIC. Registers are A, B, C, D, E, H, and L. Note that for SGN, the result is represented as a 2-byte integer.


<p>&nbsp;</p>

### Movement

```
----------------------------------------------------------------------------
|   Label   |  Address  |      Function       |    Object    |  Reg. mod.  |
|-----------+-----------+---------------------+--------------+-------------|
|   MAF     |   2C4DH   |   ARG <-- DAC       | double prec. | A,B,D,E,H,L |
|   MAM     |   2C50H   |   ARG <-- (HL)      | double prec. | A,B,D,E,H,L |
|   MOV8DH  |   2C53H   |   (DE) <-- (HL)     | double prec. | A,B,D,E,H,L |
|   MFA     |   2C59H   |   DAC <-- ARG       | double prec. | A,B,D,E,H,L |
|   MFM     |   2C5CH   |   DAC <-- (HL)      | double prec. | A,B,D,E,H,L |
|   MMF     |   2C67H   |   (HL) <-- DAC      | double prec. | A,B,D,E,H,L |
|   MOV8HD  |   2C6AH   |   (HL) <-- (DE)     | double prec. | A,B,D,E,H,L |
|   XTF     |   2C6FH   |   (SP) <--> DAC     | double prec. | A,B,D,E,H,L |
|   PHA     |   2CC7H   |   ARG <-- (SP)      | double prec. | A,B,D,E,H,L |
|   PHF     |   2CCCH   |   DAC <-- (SP)      | double prec. | A,B,D,E,H,L |
|   PPA     |   2CDCH   |   (SP) <-- ARG      | double prec. | A,B,D,E,H,L |
|   PPF     |   2CE1H   |   (SP) <-- DAC      | double prec. | A,B,D,E,H,L |
|   PUSHF   |   2EB1H   |   DAC <-- (SP)      | single prec. | D,E         |
|   MOVFM   |   2EBEH   |   DAC <-- (HL)      | single prec. | B,C,D,E,H,L |
|   MOVFR   |   2EC1H   |   DAC <-- (CBED)    | single prec. | D,E         |
|   MOVRF   |   2ECCH   |   (CBED) <-- DAC    | single prec. | B,C,D,E,H,L |
|   MOVRMI  |   2ED6H   |   (CBED) <-- (HL)   | single prec. | B,C,D,E,H,L |
|   MOVRM   |   2EDFH   |   (BCDE) <-- (HL)   | single prec. | B,C,D,E,H,L |
|   MOVMF   |   2EE8H   |   (HL) <-- DAC      | single prec. | A,B,D,E,H,L |
|   MOVE    |   2EEBH   |   (HL) <-- (DE)     | single prec. | B,C,D,E,H,L |
|   VMOVAM  |   2EEFH   |   ARG <-- (HL)      | VALTYP       | B,C,D,E,H,L |
|   MOVVFM  |   2EF2H   |   (DE) <-- (HL)     | VALTYP       | B,C,D,E,H,L |
|   VMOVE   |   2EF3H   |   (HL) <-- (DE)     | VALTYP       | B,C,D,E,H,L |
|   VMOVFA  |   2F05H   |   DAC <-- ARG       | VALTYP       | B,C,D,E,H,L |
|   VMOVFM  |   2F08H   |   DAC <-- (HL)      | VALTYP       | B,C,D,E,H,L |
|   VMOVAF  |   2F0DH   |   ARG <-- DAC       | VALTYP       | B,C,D,E,H,L |
|   VMOVMF  |   2F10H   |   (HL) <-- DAC      | VALTYP       | B,C,D,E,H,L |
----------------------------------------------------------------------------
```

**Note:** (HL), (DE) means the values in memory pointed to by HL or DE. Four
      register names in the parentheses are the single precision real numbers
      which indicate (sign + exponent), (mantissa 1st and 2nd places),
      (mantissa 3th and 4th places), (mantissa 5th and 6th places) from left
      to right. Where the object is VALTYP, the movement (2, 4, 8 bytes) is
      according to the type indicated in VALTYP (F663H).


<p>&nbsp;</p>

### Comparison

```
-----------------------------------------------------------------------------
|   Label   |  Address  |      Object              | Left | Right |Reg. mod.|
|-----------+-----------+--------------------------+------+-------+---------|
|   FCOMP   |   2F21H   | single prec. real number | CBED |  DAC  |    HL   |
|   ICOMP   |   2F4DH   | 2-byte integer           | DE   |  HL   |    HL   |
|   XDCOMP  |   2F5CH   | double prec. real number | ARG  |  DAC  |    all  |
-----------------------------------------------------------------------------
```

**Note:** Results will be in A register. Meanings of A register are:

* A = 1 ⟶ left < right
* A = 0 ⟶ left = right
* A = -1 ⟶ left > right

In the comparison of single precision real numbers, CBED means that each register has single precision (sign + exponent),v      (mantissa 1st and 2nd places), (mantissa 3th and 4th places), and (mantissa 5th and 6th places).


<p>&nbsp;</p>

### Floating-point input/output

```
-----------------------------------------------------------------------------
|   Label   |  Address  |                     Function                      |
|-----------+-----------+---------------------------------------------------|
|   FIN     |   3299H   |  Stores a string representing the floating-point  |
|           |           |  number in DAC, converting it in real.            |
|---------------------------------------------------------------------------|
|  Entry condition    HL  <--  Starting address of the string               |
|                     A   <--  First character of the string                |
|  Return condition   DAC <--  Real number                                  |
|                     C   <--  FFH: without a decimal point                 |
|                              0:   with a decimal point                    |
|                     B   <--  Number of places after the decimal point     |
|                     D   <--  Number of digits                             |
-----------------------------------------------------------------------------
```

```
-----------------------------------------------------------------------------
|   Label   |  Address  |                     Function                      |
|-----------+-----------+---------------------------------------------------|
|   FOUT    |   3425H   |  Converts the real number in DAC to the string    |
|           |           |    (unformatted)                                  |
|   PUFOUT  |   3426H   |  Converts the real number in DAC to the string    |
|           |           |    (formatted)                                    |
|---------------------------------------------------------------------------|
|   Entry condition   A   <-- format                                        |
|     bit 7   0: unformatted     1: formatted                               |
|     bit 6   0: without commas  1: with commas every three digits          |
|     bit 5   0: meaningless     1: leading spaces are padded with "."      |
|     bit 4   0: meaningless     1: "$" is added before the numerical value |
|     bit 3   0: meaningless     1: "+" is added even for positive values   |
|     bit 2   0: meaningless     1: the sign comes after the value          |
|     bit 1   unused                                                        |
|     bit 0:  0: fixed point     1: floating-point                          |
|       B <-- number of digits before and not including the decimal point   |
|       C <-- number of digits after and including the decimal point        |
|   Return condition  HL <-- starting address of the string                 |
-----------------------------------------------------------------------------
```

```
-----------------------------------------------------------------------------
|   Label   |  Address  |                     Function                      |
|-----------+-----------+---------------------------------------------------|
|   FOUTB   |   371AH   | Converts 2-byte integer in DAC+2, 3 to a          |
|           |           |   binary expression string.                       |
|   FOUTO   |   371EH   | Converts 2-byte integer in DAC+2, 3 to an         |
|           |           |   octal expression string.                        |
|   FOUTH   |   3722H   | Converts 2-byte integer in DAC+2, 3 to a          |
|           |           |   hexadecimal expression string.                  |
|---------------------------------------------------------------------------|
|   Entry condition    DAC + 2  <-- 2-byte integer                          |
|                      VALTYP   <-- 2                                       |
|   Return condition   HL       <-- starting address of the string          |
-----------------------------------------------------------------------------
```

**Note:** no strings are reserved. The starting address of the string in the
      output routine is normally in FBUFFR (from F7C5H). In some cases it
      may differ slightly. For the integer in DAC + 2, VALTYP (F663H) must
      be 2, even in cases other than FOUTB, FOUTO and FOUTH.


<p>&nbsp;</p>

### Type conversion

```
-----------------------------------------------------------------------------
|   Label   |  Address  |                     Function                      |
|-----------+-----------+---------------------------------------------------|
|   FRCINT  |   2F8AH   | Converts DAC to a 2-byte integer (DAC + 2, 3)     |
|   FRCSNG  |   2FB2H   | Converts DAC to a single precision real number    |
|   FRCDBL  |   303AH   | Converts DAC to a double precision real number    |
|   FIXER   |   30BEH   | DAC <-- SGN(DAC) * INT(ABS(DAC))                  |
-----------------------------------------------------------------------------
```

**Note:** after execution, VALTYP (F663H) will contain the number (2, 4 or 8) representing DAC type. No registers are reserved.


<p>&nbsp;</p>

### Integer operation

```
-----------------------------------------------------------------------
|   Label   |  Address  |       Function       |  Registers modified  |
|-----------+-----------+----------------------+----------------------|
|   UMULT   |   314AH   |    DE <-- BC * DE    |    A, B, C, D, E     |
|   ISUB    |   3167H   |    HL <-- DE - HL    |         all          |
|   IADD    |   3172H   |    HL <-- DE + HL    |         all          |
|   IMULT   |   3193H   |    HL <-- DE * HL    |         all          |
|   IDIV    |   31E6H   |    HL <-- DE / HL    |         all          |
|   IMOD    |   323AH   |    HL <-- DE mod HL  |         alle         |
|           |           |    (DE <-- DE/HL)    |                      |
-----------------------------------------------------------------------
```


<p>&nbsp;</p>

### Power

```
-----------------------------------------------------------------------------
|   Label   |  Address  |    Function                | Base | Exp. | Result |
|-----------+-----------+----------------------------+------+------+--------|
|   SGNEXP  |   37C8H   | power of single-prec. real | DAC  | ARG  |  DAC   |
|   DBLEXP  |   37D7H   | power of double-prec. real | DAC  | ARG  |  DAC   |
|   INTEXP  |   383FH   | power of 2-byte integer    | DE   | HL   |  DAC   |
-----------------------------------------------------------------------------
```

**Note:** No registers are reserved.


<p>&nbsp;</p>

## Changes from the original

- In the explanation before [Figure A.3](#figure-a3--exponent-format), the indication about the excess 64 method has been added.

- In [Figure A.3](#figure-a3--exponent-format), in the third byte, "63rd power of 10" has been corrected to "-63rd power of 10".

- In the explanation before [Figure A.3](#figure-a3--exponent-format), the indication about the excess 64 method has been added.

- In [Figure A.3](#figure-a3--exponent-format), in the third byte, "63rd power of 10" has been corrected to "-63rd power of 10".