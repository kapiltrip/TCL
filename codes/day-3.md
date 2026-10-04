# Day 3 — Tcl expressions: code and notes

[← Back to index](../README.md#day-3-codes) · [Assignment review](../assignments/day-3.md)

**Kapil’s console practice · reviewed 4 October 2026 · Tcl 8.6.18**

Your session practised arithmetic, logical operations, number formatting, and bitwise operations, then attempted Assignments 11–13. This file explains that work and adds the mathematical functions needed to finish Day 3. [Day 3 Assignments](../assignments/day-3.md) contains the six questions, complete solutions, and entered numeric drafts.

Source evidence: [your pasted console session](console-session.txt), beginning at `#day3`. Added examples are identified below; they are not presented as commands you already entered.

## Contents

- [Use expr for arithmetic](#use-expr-for-arithmetic)
- [Integer division and floating-point division](#integer-division-and-floating-point-division)
- [Logical and relational operations](#logical-and-relational-operations)
- [Print decimal, hexadecimal, and binary](#print-decimal-hexadecimal-and-binary)
- [Trace your bitwise operations](#trace-your-bitwise-operations)
- [Store a computed result before printing it](#store-a-computed-result-before-printing-it)
- [Mathematical functions and units](#mathematical-functions-and-units)
- [Assignment corrections and completion](#assignment-corrections-and-completion)
- [Complete practice script](#complete-practice-script)
- [References](#references)

## Use expr for arithmetic

Your first attempt was:

```text
% set a 4
4
% set b 5
5
% $a + $b
invalid command name "4"
```

Tcl substitutes the variables while building the command. The resulting words are `4`, `+`, and `5`; Tcl tries to execute `4` as the command name. An arithmetic expression needs the `expr` command:

```tcl
set a 4
set b 5
puts [expr {$a + $b}]
puts "add : [expr {$a + $b}]"
puts "subs : [expr {$a - $b}]"
```

Output:

```text
9
add : 9
subs : -1
```

There are three layers in `puts [expr {$a + $b}]`:

1. The braces pass the expression text as one argument to `expr`.
2. `expr` reads the variable values and evaluates the addition.
3. Command substitution inserts that result into the argument passed to `puts`.

This explains why braces can preserve `$var1` as literal text for `puts` on Day 2, yet work with variables inside `expr`: the receiving command decides how to interpret its argument.

Your `expr {a / b}` and `expr {!b}` attempts lacked the dollar signs. `a` and `b` are bare words there, rather than references to your numeric variables. Use `$a` and `$b`. [Official expression syntax](https://www.tcl-lang.org/man/tcl8.6/TclCmd/expr.htm).

Square brackets alone do not request arithmetic. Your `[$voltage * $totalr]` attempt tried to execute a command named `30`. `[expr {$voltage * $totalr}]` performs multiplication, although that multiplication was the wrong physical formula for Assignment 11.

[← Back to index](../README.md#day-3-codes) · [This day’s contents](#contents)

## Integer division and floating-point division

Your `a=4`, `b=5` division returned `0`, and the remainder returned `4`. That is consistent with integer operands:

```tcl
set a 4
set b 5
puts [expr {$a / $b}]
puts [expr {$a % $b}]
puts [expr {double($a) / $b}]
```

Output:

```text
0
4
0.8
```

For these positive operands, the integer quotient is zero and the remainder is four. Introducing a floating-point operand gives the fractional result. Tcl’s integer division rounds toward negative infinity for negative operands; it is not a universal truncation-toward-zero rule. [Numeric types and division](https://www.tcl-lang.org/man/tcl8.6/TclCmd/expr.htm).

| Operation, using the original `a=4`, `b=5` | Expression | Result |
| --- | --- | --- |
| Addition | `expr {$a + $b}` | `9` |
| Subtraction | `expr {$a - $b}` | `-1` |
| Multiplication | `expr {$a * $b}` | `20` |
| Integer division | `expr {$a / $b}` | `0` |
| Floating-point division | `expr {4.0 / $b}` | `0.8` |
| Integer remainder | `expr {$a % $b}` | `4` |
| Exponentiation | `expr {$a ** $b}` | `1024` |

Later you changed `b` to `0` for logical NOT. That later value should not be substituted into the earlier division example. The clean examples here initialise their own inputs so they can be run independently.

[← Back to index](../README.md#day-3-codes) · [This day’s contents](#contents)

## Logical and relational operations

Your `!$b` test returned `0` when `b` was `5`, then `1` after you set `b` to `0`. Logical NOT reverses the truth value of a numeric operand; it does not invert every binary bit.

```tcl
set a 4
set b 5
puts [expr {$a < $b}]
puts [expr {!$b}]
set b 0
puts [expr {!$b}]
puts [string is boolean $a]
puts [expr {!$a}]
```

Output:

```text
1
0
1
0
0
```

The final two results answer a subtle question raised by your console: `string is boolean 4` returns `0`, while a logical expression can still treat numeric `4` as true. The string command validates recognised Boolean representations; the expression operator evaluates the truth of a numeric operand.

Your `string is boolean $a l` had an extra argument. Tcl tried to interpret the substituted `4` as an option and reported that it expected `-strict` or `-failindex`. `string is boolean $a` is the correct call for checking that one value.

| Operators | Purpose |
| --- | --- |
| `<`, `>`, `<=`, `>=` | Relational tests. |
| `==`, `!=` | Equality and inequality, with numeric interpretation when applicable. |
| `eq`, `ne` | String equality and inequality. |
| `&&`, <code>&#124;&#124;</code>, `!` | Logical AND, OR, and NOT. |
| `&`, <code>&#124;</code>, `^`, `~` | Bitwise AND, OR, XOR, and NOT. |

Relational and logical tests return `0` or `1`. Bitwise operations return an integer assembled from the individual bit results. [Expression operators](https://www.tcl-lang.org/man/tcl8.6/TclCmd/expr.htm).

[← Back to index](../README.md#day-3-codes) · [This day’s contents](#contents)

## Print decimal, hexadecimal, and binary

Your `num=255` demonstrations produced decimal `255`, hexadecimal `ff`, and binary `11111111`:

```tcl
set num 255
puts [format %d $num]
puts [format %x $num]
puts [format %b $num]
set var2 12
puts [format %4b $var2]
puts [format %04b $var2]
puts [format %08b $var2]
```

Output:

```text
255
ff
11111111
1100
1100
00001100
```

`%x` is the hexadecimal conversion. Your `%h` attempt failed because `h` is a size modifier without a following conversion character, not the hexadecimal conversion.

The width is a minimum width. The binary value `1100` already occupies four characters, so `%4b` and `%04b` add no padding. `%08b` requests a width of eight with leading zeroes. Formatting changes the representation you print; it does not change the numeric variable. [Official `format` conversions](https://www.tcl-lang.org/man/tcl8.6/TclCmd/format.htm).

[← Back to index](../README.md#day-3-codes) · [This day’s contents](#contents)

## Trace your bitwise operations

You set `c=243` and `d=123`, giving the following eight-bit views:

| Value | Binary | Decimal |
| --- | --- | --- |
| `c` | `11110011` | `243` |
| `d` | `01111011` | `123` |
| `c & d` | `01110011` | `115` |
| <code>c &#124; d</code> | `11111011` | `251` |
| `c ^ d` — added XOR example | `10001000` | `136` |

For AND, a result bit is one only where both inputs have a one. OR sets a bit where either input has a one. XOR sets it where the inputs differ. Your final AND `115` and OR `251` were correct.

Your earlier `set aband [expr {$a & $b}]` returned `0`, because the variables at that point were `a=4` and `b=0`. It did not use the newly created `c` and `d`. Changing the operands to `$c` and `$d` produced the intended `115`.

Here is a clean reproduction, with XOR and an eight-bit complement added to complete the operator comparison:

```tcl
set c 243
set d 123
puts "c=[format %08b $c]"
puts "d=[format %08b $d]"
puts "AND=[format %08b [expr {$c & $d}]]"
puts "OR=[format %08b [expr {$c | $d}]]"
puts "XOR=[format %08b [expr {$c ^ $d}]]"
puts "NOT8=[format %08b [expr {(~$c) & 0xff}]]"
```

Output:

```text
c=11110011
d=01111011
AND=01110011
OR=11111011
XOR=10001000
NOT8=00001100
```

Tcl integers are not automatically eight-bit hardware registers. `~243` is `-244`; the `& 0xff` mask selects the low eight bits, giving `12`. The mask is an added teaching example, rather than something shown in your transcript.

[← Back to index](../README.md#day-3-codes) · [This day’s contents](#contents)

## Store a computed result before printing it

You fixed Assignment 12 by storing a result in `propdelay` and then printing it. This braced version keeps the same sum:

```tcl
set rise 3
set fall 4
set propdelay [expr {$rise + $fall}]
puts "The total prop delay is $propdelay"
```

Output:

```text
The total prop delay is 7
```

Your unbraced `set propdelay [expr $rise + $fall]` also computed `7` for these inputs: `expr` accepts multiple arguments and joins them into an expression. Braces keep the expression together and let `expr` handle its variable substitutions directly.

The earlier failures have different causes:

| Your attempt | Cause |
| --- | --- |
| `puts propdelay [$rise + $fall]` | The brackets tried to execute `3` as a command. |
| `puts propdelay [expr $rise + $fall]` | `puts` treated `propdelay` as an output channel name. |
| `puts $propdelay ...` after `unset propdelay` | The variable had been deleted. |
| `set $propdelay ...` after deleting it | Tcl tried to read its value before calling `set`. |

Use a name when storing: `set propdelay ...`. Use its value when printing: `puts $propdelay`. Assignment 12’s wording calls this a “total”; the assignment review explicitly records the sum interpretation used for the draft.

[← Back to index](../README.md#day-3-codes) · [This day’s contents](#contents)

## Mathematical functions and units

Your comment listed `abs`, `acos`, `asin`, and `ceil`, but the transcript does not show calls to those functions. These added examples make their usage concrete:

```tcl
puts [expr {abs(-4)}]
puts [expr {ceil(2.1)}]
puts [expr {round(2.6)}]
puts [format %.6f [expr {acos(0.0)}]]
puts [format %.6f [expr {asin(1.0)}]]
puts [format %.6f [expr {log(2.0)}]]
```

Output:

```text
4
3.0
3
1.570796
1.570796
0.693147
```

Call these functions inside `expr`. `acos` and `asin` return angles in radians. `ceil` rounds upward, while `round` chooses the nearest integer. Tcl’s `log` is the natural logarithm needed by Assignment 16. [Official mathematical functions](https://www.tcl-lang.org/man/tcl8.6/TclCmd/mathfunc.htm).

Units belong to the calculation you design; Tcl does not attach them to plain numeric variables. Assignment 13 supplies current in milliamperes, so multiplying that number by the voltage gives milliwatts. Assignment 14 supplies megahertz and requests nanoseconds, so the conversion factor is `1000.0`. Assignment 16 supplies picofarads, and the complete solution converts the computed seconds to nanoseconds **before** rounding.

[← Back to index](../README.md#day-3-codes) · [This day’s contents](#contents)

## Assignment corrections and completion

| Assignment | Console work | Draft prepared |
| --- | --- | --- |
| 11 | Calculated `30 * 15 = 450`. | Current is voltage divided by series resistance: `2.0` amperes. |
| 12 | Finished with the sum `7`. | Kept `7`; the review states the interpretation of “total”. |
| 13 | Finished with `9.0`. | Kept `9.0` milliwatts. |
| 14 | No attempt appears in the supplied transcript. | Completed the 200 MHz period calculation: `5.0` nanoseconds. |
| 15 | No attempt appears in the supplied transcript. | Completed the transistor count: `112`. |
| 16 | No attempt appears in the supplied transcript. | Completed the RC calculation and rounding: `1` nanosecond. |

The [assignment review](../assignments/day-3.md) shows each problem image, complete code, unit calculation, and the numeric draft entered in its dedicated Chrome tab. Every submission remains for you.

[← Back to index](../README.md#day-3-codes) · [This day’s contents](#contents)

## Complete practice script

[Open the runnable Day 3 script](day-3.tcl).

Save as `codes/day-3.tcl` in the workspace and run `source codes/day-3.tcl` in the Tcl console.

```tcl
set a 4
set b 5
puts "sum=[expr {$a + $b}]"
puts "integer division=[expr {$a / $b}]"
puts "fractional division=[expr {double($a) / $b}]"
puts "remainder=[expr {$a % $b}]"
puts "a less than b=[expr {$a < $b}]"
set b 0
puts "logical NOT of b=[expr {!$b}]"
set c 243
set d 123
set cdand [expr {$c & $d}]
set cdor [expr {$c | $d}]
puts "AND=$cdand ([format %08b $cdand])"
puts "OR=$cdor ([format %08b $cdor])"
set totalr [expr {10 + 5}]
set voltage 30.0
puts "current=[expr {$voltage / $totalr}] A"
set supply 1.8
set current_ma 5
puts "power=[expr {$supply * $current_ma}] mW"
set frequency_mhz 200.0
puts "period=[expr {1000.0 / $frequency_mhz}] ns"
set transition_ns [expr {500.0 * 2e-12 * log(2.0) * 1e9}]
puts "transition=[format %.6f $transition_ns] ns"
puts "rounded=[expr {round($transition_ns)}] ns"
```

Expected output:

```text
sum=9
integer division=0
fractional division=0.8
remainder=4
a less than b=1
logical NOT of b=1
AND=115 (01110011)
OR=251 (11111011)
current=2.0 A
power=9.0 mW
period=5.0 ns
transition=0.693147 ns
rounded=1 ns
```

[← Back to index](../README.md#day-3-codes) · [This day’s contents](#contents)

## References

- [expr](https://www.tcl-lang.org/man/tcl8.6/TclCmd/expr.htm) — operators, substitutions, numeric types, and division.
- [format](https://www.tcl-lang.org/man/tcl8.6/TclCmd/format.htm) — decimal, hexadecimal, binary, and padding.
- [Mathematical functions](https://www.tcl-lang.org/man/tcl8.6/TclCmd/mathfunc.htm) — logarithms, rounding, and the added function examples.
- [string](https://www.tcl-lang.org/man/tcl8.6/TclCmd/string.htm) — Boolean string validation.

[← Back to index](../README.md#day-3-codes) · [This day’s contents](#contents)
