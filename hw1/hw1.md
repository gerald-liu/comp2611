# COMP 2611 Homework 1
COMP 2611 &ndash; Computer Organization, Spring 2018, HKUST  

LIU Weiyang, 20413306  

[wliuax@connect.ust.hk](mailto:wliuax@connect.ust.hk)

[TOC]

## Question 1: Data Representation
### a) Signed int on 16 bits
I. 8CE~(16)~
- 2's complement = 1111 1000 1100 1110
- Decimal = -1842

II. -114~(10)~
- 2's complement = 1111 1111 1000 1110
- Hexadecimal = 0xFF8E

### b) Signed int on 32 bits
I. BEAD~(16)~
- 2’s complement = 1111 1111 1111 1111 1011 1110 1010 1101
- Decimal = -16723

II. -357821~(10)~
- 2’s complement = 1111 1111 1111 1010 1000 1010 0100 0011
- Hexadecimal = 0xFFFA8A43

### c) Floating point &ndash; decimal to binary
I. -2843.625

$2843 = \text{0xB1B} = {1011\ 0001\ 1011}_2$
$-2843.625 = {1011\ 0001\ 1011.101}_2 = {1.0110\ 0011\ 0111\ 01}_2 \times 2^{11}$
$S = 1\text{, Significand} = 0110\ 0011\ 0111\ 0100\ 0000\ 000$
$\text{Biased Exponent} = 11 + 127 = 138 = {1000\ 1010}_2$

Therefore, $-2843.625 = 1\quad1000\ 1010\quad0110\ 0011\ 0111\ 0100\ 0000\ 000$

II. 0.085

Bit|f|f $\times$ 2|Bit
:--:|:---:|:---:|:---:
|0.085|0.17|0
|0.17|0.34|0
|0.34|0.68|0
Implicit|0.68|1.36|1
22|0.36|0.72|0
21|0.72|1.44|1
20|0.44|0.88|0
...|...|...|...
1|0.72|1.44|1
0|0.44|0.88|**1**

(As $|0.88-1|<|0.88-0|$, we choose **1** as the last bit.)  

$0.085={1.0101\ 1100\ 0010\ 1000\ 1111\ 011}_2 \times 2^{-4}$
$S = 0\text{, Significand} = 0101\ 1100\ 0010\ 1000\ 1111\ 011$
$\text{Biased Exponent} = -4 + 127 = 123 = {0111\ 1011}_2 $

Therefore, $0.085 = 0\quad0111\ 1011\quad0101\ 1100\ 0010\ 1000\ 1111\ 011$

### d) Floating point &ndash; binary to decimal
I. 0 1001 0011 11101100101110110110000

$S = 0\text{, Exponent}= {1001\ 0011}_2 = 147 $
$$
\begin{aligned}
&(-1)^S \times (1 + \text{Significand}) \times 2^{\text{Exponent} - \text{Bias}} \\
= &(-1)^0 \times {1.1110\ 1100\ 1011\ 1011\ 0110\ 000}_2 \times 2^{147-127} \\
= &{1\ 1110\ 1100\ 1011\ 1011\ 0110.000}_2 \\
= &\mathrm{0x1ECBB6} \\
= &2018230
\end{aligned}
$$
II. 1 0000 0000 11100000000000000000000

$S = 1\text{, Exponent}= {0000\ 0000}_2 = 0$
$$
\begin{aligned} \text{Significand}&={.1110\ 0000...000}_2 \\
&= .111_2 \\
&= .875 \end{aligned}\\ \ \\
\begin{aligned}&(-1)^S \times \text{Significand} \times 2^{-126} \\
=&(-1)^1 \times 0.875 \times 2^{-126} \\
=&-0.875 \times 2^{-126}\end{aligned}
$$

## Question 2: Boolean Algebra
I.

$$
\begin{aligned}&AB+AB\overline{C}D+ABD\overline{E}+\overline{A}B\overline{C}E+\overline{A}\ \overline{B}\ \overline{C}E \\
=&AB + \overline{A}\overline{C}E(B+\overline{B}) \\
=&AB+\overline{A}\overline{C}E \end{aligned}
$$
II.

$$
\begin{aligned}&\overline{A}B\overline{C}+\overline{A}BC+A\overline{B}C+AB\overline{C}+ABC \\
=&\overline{A}B(\overline{C}+C)+AC(\overline{B}+B)+AB\overline{C} \\
=&\overline{A}B+AC+AB\overline{C} \\
=&\overline{A}B+AC+ABC+AB\overline{C} \\
=&\overline{A}B+AB+AC \\
=&B+AC\end{aligned}
$$
III.

$$
\begin{aligned}&\overline{(\overline{AB+\overline{A}\ \overline{B}})(\overline{BC+\overline{B}\ \overline{C}})} =AB+\overline{A}\ \overline{B} + BC+\overline{B}\ \overline{C}\end{aligned}
$$
IV.

$$
\begin{aligned}&\overline{\overline{A\overline{AB}}\cdot\overline{B\overline{AB}}} \\
=&A\overline{AB}+B\overline{AB} \\
=&A(\overline{A}+\overline{B})+B(\overline{A}+\overline{B}) \\
=&A\overline{B}+B\overline{A}\end{aligned}
$$

## Question 3: Combinational Logic
### a) Truth table
N~3~|N~2~|N~1~|N~0~|P
:---:|:---:|:---:|:---:|:---:
0|0|0|0|0
0|0|0|1|1
0|0|1|0|1
0|0|1|1|1
0|1|0|0|0
0|1|0|1|1
0|1|1|0|0
0|1|1|1|1
1|0|0|0|0
1|0|0|1|0
1|0|1|0|0
1|0|1|1|1
1|1|0|0|0
1|1|0|1|1
1|1|1|0|0
1|1|1|1|0

### b) Logic expression
$$
\begin{aligned}P=&\overline{N_3}\ \overline{N_2}\ \overline{N_1}\  N_0 + \overline{N_3}\ \overline{N_2}\  N_1\ \overline{N_0} +  \overline{N_3}\ \overline{N_2}\  N_1\  N_0 \\
+&\overline{N_3}\  N_2\  \overline{N_1}\  N_0 + \overline{N_3}\  N_2\  N_1\  N_0 + N_3\  \overline{N_2}\  N_1\  N_0 \\
+&N_3\  N_2\  \overline{N_1}\  N_0 \end{aligned}
$$

$$
\begin{aligned}P=&(N_3+N_2+N_1+N_0)(N_3+\overline{N_2}+N_1+N_0) \\
&(N_3+\overline{N_2}+\overline{N_1}+N_0)(\overline{N_3}+N_2+N_1+N_0) \\
&(\overline{N_3}+N_2+N_1+\overline{N_0})(\overline{N_3}+N_2+\overline{N_1}+N_0) \\
&(\overline{N_3}+\overline{N_2}+N_1+N_0)(\overline{N_3}+\overline{N_2}+\overline{N_1}+N_0) \\
&(\overline{N_3}+\overline{N_2}+\overline{N_1}+\overline{N_0})\end{aligned}
$$

### c) Simplify with K-map
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;$\quad$N~1~N~0~ <br />N~3~N~2~|00<br />&nbsp;|01<br/>&nbsp;|11<br/>&nbsp;|10<br/>&nbsp;
:---|:---:|:---:|:---:|:---:
**00**|0|1|1|1
**01**|0|1|1|0
**11**|0|1|0|0
**10**|0|0|1|0

$ P = \overline{N_3}N_0+N_2\overline{N_1}N_0+\overline{N_3}\ \overline{N_2}N_1+\overline{N_2}N_1N_0 $

### d) Implement with gates
![Q3d Circuit](Q3d.png)

## Question 4: Sequential Logic
### a) S-R latch
I.

| $X$  | $Y$  |  $Q$  | $\overline{Q}$ |
| :--: | :--: | :---: | :------------: |
|  0   |  0   |   1   |       0        |
|  0   |  1   |   1   |       0        |
|  1   |  0   | latch |     latch      |
|  1   |  1   |   1   |       0        |
II. No, because the value stored (Q) is always 1 and **cannot be reset** to 0.

### b) D flip-flop
As it's positive edge trigged, its timing diagram is as follows:

![Q4b timing diagram](Q4b.png)