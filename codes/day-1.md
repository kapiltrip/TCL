# Day 1 — Tcl code and notes

[← Back to index](../README.md#day-1-codes) · [Assignment review](../assignments/day-1.md)

**Kapil’s practice · reviewed 4 October 2026 · Tcl 8.6.18**

Your five final assignment solutions are correct. This file preserves the commands you practised, explains the errors visible in your console, and adds the Day 1 topics that are not demonstrated in the screenshots. The separate [Day 1 Assignments](../assignments/day-1.md) file compares each solution with the course question.

Course: [Foundation Series 3: TCL fundamentals — Day 1](https://namaste-fpga.com/student/learn/37?contentId=1801). The course outline and assignment questions were reviewed in Chrome. These notes explain your screenshots using the official Tcl manual and examples checked in your installed interpreter.

## Contents

- [Your original practice](#your-original-practice)
- [Commands, values, and output](#commands-values-and-output)
- [Variable names and substitution](#variable-names-and-substitution)
- [Incrementing variables](#incrementing-variables)
- [Command substitution](#command-substitution)
- [Backslashes and literal text](#backslashes-and-literal-text)
- [The five assignment commands](#the-five-assignment-commands)
- [Earlier errors: assignment syntax and abbreviations](#earlier-errors-assignment-syntax-and-abbreviations)
- [Missing from the screenshots: unset and execution order](#missing-from-the-screenshots-unset-and-execution-order)
- [Save scripts and write comments](#save-scripts-and-write-comments)
- [A short bridge to Day 2](#a-short-bridge-to-day-2)
- [Complete practice script](#complete-practice-script)
- [Verification and references](#verification-and-references)

## Your original practice

### Screenshot 1 — variables, increments, and substitutions

<img src="../images/day-1-console-part-1.png" alt="Your Day 1 console, first portion" width="1260" height="1033">

The console begins with `set var2_3 23` and continues through the assignment variables. The `%` characters are interpreter prompts. The lines beneath commands are results or output; neither belongs in a saved script.

### Screenshot 2 — continuation and the five assignments

<img src="../images/day-1-console-part-2.png" alt="Your Day 1 console, continuation" width="919" height="968">

The screenshots overlap. Read them as two views of the same sequence of practice, rather than two separate sets of assignments. The second view includes your final `puts $vdd` and `puts $clk_freq` results.

[← Back to index](../README.md#day-1-codes) · [This day’s contents](#contents)

## Commands, values, and output

Tcl commands follow this shape:

```text
command argument1 argument2 ...
```

For your command `set vdd 5`, the first word is the command `set`, the second word names the variable, and the third supplies its value. Spaces separate words. A newline or `;` separates commands. Tcl processes substitutions while preparing the words, then calls the command. [Official Tcl syntax](https://www.tcl-lang.org/man/tcl8.6/TclCmd/Tcl.htm#M6).

```tcl
set vdd 5
set clk_freq 50
set bus_width 64
```

`set` both stores a value and returns it. With only a variable name, `set` reads its current value:

```tcl
set vdd 5
set vdd
puts $vdd
```

In the interactive console, the first two commands each show `5` because the shell displays their nonempty results. The third explicitly writes `5` to the output channel. In a saved script, `set vdd 5` alone does not print anything; use `puts` when you want visible output. [Official `set` manual](https://www.tcl-lang.org/man/tcl8.6/TclCmd/set.htm).

The course calls Tcl a string based language. For these exercises, a variable holds a value without an `int` or `float` declaration. Commands decide how to interpret that value: `puts` prints it, while `incr` requires an integer. Tcl can maintain internal numeric representations; “string based” does not mean every operation is merely text concatenation.

`vdd`, `clk_freq`, and `bus_width` are ordinary variable names here. The units come from the problem description. Setting `vdd` does not configure a physical supply, and setting `clk_freq` does not create a Vivado clock constraint.

[← Back to index](../README.md#day-1-codes) · [This day’s contents](#contents)

## Variable names and substitution

Your first pair is correct:

```tcl
set var2_3 23
puts $var2_3
```

Output from `puts`:

```text
23
```

The underscore is part of the name. Use the name without `$` when assigning it; use `$var2_3` when reading its value inside another command. Names are case sensitive: `vdd` and `VDD` are different variables.

Your next example is also correct:

```tcl
set res LUT
puts ${res}6
```

Output:

```text
LUT6
```

`${res}` marks exactly where the variable name ends; the `6` is then ordinary text in the same word. `puts $res6` would instead try to read a variable named `res6`. This command constructs the output word `LUT6`; it does not change `res`, which still contains `LUT`. [Variable substitution rules](https://www.tcl-lang.org/man/tcl8.6/TclCmd/Tcl.htm#M12).

[← Back to index](../README.md#day-1-codes) · [This day’s contents](#contents)

## Incrementing variables

These are the commands shown in your console:

```tcl
incr var3 5
incr var2
puts $var2
```

You saw `5`, `1`, and `1`. Those results fit `var3` and `var2` being unset or zero before the increments. In Tcl 8.6, incrementing an unset variable creates it with the requested increment; the default increment is `1`.

If a variable already exists, the increment is added to its current integer value:

```tcl
set count 10
incr count 5
puts $count
```

Output from `puts`:

```text
15
```

Use `incr count`, because this command expects a variable **name**. `incr $count` would use the value of `count` as the name of another variable. A fresh console and an old console can give different results if earlier commands left variables behind. [Official `incr` manual](https://www.tcl-lang.org/man/tcl8.6/TclCmd/incr.htm).

[← Back to index](../README.md#day-1-codes) · [This day’s contents](#contents)

## Command substitution

Your code:

```tcl
set var1 56
set var2 [set var1 87 ]
puts $var2
```

The space before `]` is allowed. Execution proceeds as follows:

1. `set var1 56` stores `56` in `var1`.
2. Tcl executes the command inside `[...]`: `set var1 87`.
3. That inner command changes `var1` to `87` and returns `87`.
4. The outer command becomes `set var2 87`.
5. `puts $var2` prints `87`.

Both variables now contain `87`. If your intention were to copy the original `56`, you would use:

```tcl
set var1 56
set var2 $var1
puts $var2
```

That prints `56`. Your bracket example is valid; its extra effect is that it overwrites `var1`. [Command substitution rules](https://www.tcl-lang.org/man/tcl8.6/TclCmd/Tcl.htm#M11).

[← Back to index](../README.md#day-1-codes) · [This day’s contents](#contents)

## Backslashes and literal text

### A literal dollar sign

Your failed attempt was:

```tcl
set var1 $5
```

Tcl interpreted `$5` as “read the variable named `5`”. That variable did not exist, so the console reported:

```text
can't read "5": no such variable
```

Your correction is correct:

```tcl
set var1 \$5
puts $var1
```

Output:

```text
$5
```

The backslash makes `$` literal. Reading `var1` later inserts its stored value; Tcl does not automatically reinterpret that value as another variable reference.

### Literal square brackets

Your failed attempt was:

```tcl
set var2 mem[addr]
```

Tcl tried to execute `addr` as a command because of `[addr]`. There was no such command, producing:

```text
invalid command name "addr"
```

Your correction also works:

```tcl
set var2 mem\[addr]
puts $var2
```

Output:

```text
mem[addr]
```

Escaping the opening bracket prevents command substitution. For a complete piece of literal text, braces are often easier to read:

```tcl
set var2 {mem[addr]}
puts $var2
```

This is a small preview of Day 2 grouping, rather than a correction to your working backslash example.

### The text `\n` versus a newline character

Your command contains two consecutive backslashes before `n`:

```tcl
set var3 \\n
puts $var3
```

It stores the two characters backslash and `n`, so `puts` displays:

```text
\n
```

Tcl turns `\\` into one literal backslash. It does not process the resulting `\n` a second time. To place an actual newline inside text, use one backslash in a quoted string:

```tcl
set message "first\nsecond"
puts $message
```

Output:

```text
first
second
```

The distinction was verified by checking the stored characters: your value has length `2` and bytes `5c 6e`; a newline has length `1` and byte `0a`. [Backslash substitution rules](https://www.tcl-lang.org/man/tcl8.6/TclCmd/Tcl.htm#M16).

[← Back to index](../README.md#day-1-codes) · [This day’s contents](#contents)

## The five assignment commands

These final commands from your screenshots are all correct:

```tcl
# Assignment 1: set the supply voltage.
set vdd 5

# Assignment 2: set the clock frequency.
set clk_freq 50

# Assignment 3: set the bus width.
set bus_width 64

# Assignment 4: print the supply voltage.
set vdd 1.0
puts $vdd

# Assignment 5: print the clock frequency.
set clk_freq 100
puts $clk_freq
```

The assignment answers, in order, are `5`, `50`, `64`, `1.0`, and `100`. The first three are the return values displayed by the interactive shell. The last two are the text printed by `puts`. See the [assignment review](../assignments/day-1.md) for the question matching and earlier attempts.

### Why the earlier attempts failed

| Your attempt | What Tcl did | Working form |
| --- | --- | --- |
| `bus_width 64` | Looked for a command named `bus_width`; it did not assign a variable. | `set bus_width 64` |
| `puts vdd` | Printed the literal word `vdd`. This is valid Tcl, but does not print the voltage. | `puts $vdd` |
| `puts $ vdd` | Treated `$` and `vdd` as separate arguments: channel name `$`, text `vdd`. | `puts $vdd` |

The third command produced `can not find channel named "$"`. With two ordinary arguments, `puts` treats the first as an output channel. Keep the dollar sign attached to the variable name. [Official `puts` manual](https://www.tcl-lang.org/man/tcl8.6/TclCmd/puts.htm).

[← Back to index](../README.md#day-1-codes) · [This day’s contents](#contents)

## Earlier errors: assignment syntax and abbreviations

Your earlier console screenshot from this conversation also showed these attempts:

<img src="../images/day-1-earlier-console.png" alt="Earlier Day 1 console showing assignment syntax errors" width="1856" height="884">

```tcl
int i ; i=5 ;
set var1 = 12
```

Tcl does not declare a variable using the C keyword `int`, and `=` is not an assignment operator in this command. Write:

```tcl
set i 5
set var1 12
puts $i
puts $var1
```

Output:

```text
5
12
```

`set var1 = 12` supplies three arguments after `set`; the command accepts a variable name and an optional value. This is why you saw the “wrong # args” message. A semicolon merely ends a command; it does not introduce C-style syntax.

The earlier screenshot contains `put var`, which printed `var` in that interactive console. Tcl’s default interactive handler can expand a unique abbreviated command name, so `put` can resolve to `puts`. It can also explain the unexpected `interp` subcommand error from your `int i` attempt. Always write the full command `puts` in saved scripts; interactive abbreviation is not dependable script syntax. [Official `unknown` manual](https://www.tcl-lang.org/man/tcl8.6/TclCmd/unknown.htm).

[← Back to index](../README.md#day-1-codes) · [This day’s contents](#contents)

## Missing from the screenshots: unset and execution order

The Day 1 course outline includes **Unset Command** and **Understanding TCL code execution**. The supplied screenshots do not demonstrate deleting a variable; this is a practice gap, rather than evidence that you missed the lecture.

### Delete a variable

```tcl
set temporary 23
puts $temporary
unset temporary
puts [info exists temporary]
```

Output:

```text
23
0
```

`unset temporary` removes the variable; it does not set it to zero or an empty string. `info exists` returns `0` because the variable is gone. Trying `puts $temporary` afterward would produce a “no such variable” error.

Use the name without `$`: `unset temporary`. To make a reset safe when a variable might already be absent, use `unset -nocomplain temporary`. Successful `unset` returns an empty result, so the interactive console normally shows only the next prompt. [Official `unset` manual](https://www.tcl-lang.org/man/tcl8.6/TclCmd/unset.htm).

### Follow the sequence

```tcl
set clk_freq 50
set clk_freq 100
puts $clk_freq
```

The final print is `100` because the second assignment replaces the first. Each command completes before the next begins. Nested commands such as `[set var1 87]` finish while preparing the outer command, before the outer `set` runs.

An error in an ordinary sourced script stops that script at the failing command. In an interactive console, you can enter a new command after the error. That is why your screenshots can show a failed attempt followed by a correction. Keep intentional error demonstrations separate from the clean script below.

[← Back to index](../README.md#day-1-codes) · [This day’s contents](#contents)

## Save scripts and write comments

The console executes commands immediately. To keep reusable code, place commands in a text file ending in `.tcl`; copying prompts and output into the file would make them commands too.

1. Open a text editor such as Notepad and paste the [complete practice script](#complete-practice-script).
2. Save as `day-1.tcl` inside this repository’s `codes` folder. In Notepad, choose **Save as type: All files** so the name does not become `day-1.tcl.txt`.
3. Save edits with **Ctrl+S**.
4. Double-click `start-tcl.cmd` in that folder, then run the following Tcl command:

```tcl
source codes/day-1.tcl
```

`source` reads and executes the saved file. It does not save the console session. After editing the file, save it and source it again. Variables from an earlier run can remain in the current interpreter; the practice script below resets its increment examples to give repeatable results. [Official `source` manual](https://www.tcl-lang.org/man/tcl8.6/TclCmd/source.htm).

For comments, use a line beginning with `#`, or start a comment command after `;`:

```tcl
# Supply voltage from Assignment 4.
set vdd 1.0 ;# Voltage in volts.
puts $vdd
```

Do not write `set vdd 1.0 # Voltage in volts`: without the semicolon, the extra words are arguments to `set`. Tcl recognises `#` as a comment marker where a new command can begin. [Comment rules](https://www.tcl-lang.org/man/tcl8.6/TclCmd/Tcl.htm#M30).

[← Back to index](../README.md#day-1-codes) · [This day’s contents](#contents)

## A short bridge to Day 2

The next course section is **Day 2: Strings**, beginning with grouping, special characters, and multiline strings. Quotes and braces directly help with the errors you practised on Day 1:

```tcl
set vdd 1.0
puts "Voltage = $vdd V"
puts {Voltage = $vdd V}
```

Output:

```text
Voltage = 1.0 V
Voltage = $vdd V
```

Both quotes and braces group a phrase into one word. Quotes allow variable, command, and backslash substitutions. Braces preserve literal content at this parsing stage, except for backslash followed by a physical newline. Quotes alone would therefore not fix your `[addr]` error; `{mem[addr]}` would. [Grouping rules](https://www.tcl-lang.org/man/tcl8.6/TclCmd/Tcl.htm#M8).

Braces around a whole word and braces around a variable name have different purposes:

| Form | Meaning |
| --- | --- |
| `puts {res}` | Print the literal text `res`. |
| `puts ${res}` | Read the value of variable `res`. |
| `puts ${res}6` | Read `res`, then add the literal suffix `6` to the output word. |

A quoted string may span lines:

```tcl
set report "Day 1 complete
Ready for strings"
puts $report
```

Output:

```text
Day 1 complete
Ready for strings
```

This is enough preparation for the opening Day 2 lessons. The remaining string commands and Assignments 6–10 belong to your later Day 2 work and have not been assessed here.

[← Back to index](../README.md#day-1-codes) · [This day’s contents](#contents)

## Complete practice script

[Open the runnable Day 1 script](day-1.tcl).

This clean version combines your successful commands with the small additions above. The reset before `incr` is added for repeatability; the screenshots do not show that reset. Save only the code inside this block as `codes/day-1.tcl`.

```tcl
# Day 1: variables, substitution, literal text, and assignment checks.

puts "Variable naming"
set var2_3 23
puts $var2_3
set res LUT
puts ${res}6

puts "Incrementing from an unset state"
unset -nocomplain var2 var3
incr var3 5
incr var2
puts $var3
puts $var2

puts "Command substitution"
set var1 56
set var2 [set var1 87 ]
puts $var1
puts $var2

puts "Literal characters"
set var1 \$5
puts $var1
set var2 mem\[addr]
puts $var2
set var3 \\n
puts $var3

puts "Assignment 1"
set vdd 5
puts $vdd

puts "Assignment 2"
set clk_freq 50
puts $clk_freq

puts "Assignment 3"
set bus_width 64
puts $bus_width

puts "Assignment 4"
set vdd 1.0
puts $vdd

puts "Assignment 5"
set clk_freq 100
puts $clk_freq

puts "Deleting a variable"
set temporary 23
unset temporary
puts [info exists temporary]

puts "Grouping preview"
puts "Voltage = $vdd V"
puts {Voltage = $vdd V}
```

Expected output when run as a saved script:

```text
Variable naming
23
LUT6
Incrementing from an unset state
5
1
Command substitution
87
87
Literal characters
$5
mem[addr]
\n
Assignment 1
5
Assignment 2
50
Assignment 3
64
Assignment 4
1.0
Assignment 5
100
Deleting a variable
0
Grouping preview
Voltage = 1.0 V
Voltage = $vdd V
```

The explicit `puts` calls added to Assignments 1–3 make their values visible in a saved script. Your original `set` commands were already sufficient for the questions about the interactive interpreter.

[← Back to index](../README.md#day-1-codes) · [This day’s contents](#contents)

## Verification and references

The assignment results, substitution examples, deliberate error messages, newline distinction, and complete practice script were checked using this folder’s Tcl 8.6.18 runtime. The complete script was also sourced twice to check repeatability. The runnable script and its expected output are included above.

Use these references for the exact command forms:

- [Tcl language syntax](https://www.tcl-lang.org/man/tcl8.6/TclCmd/Tcl.htm) — words, grouping, substitutions, and comments.
- [set](https://www.tcl-lang.org/man/tcl8.6/TclCmd/set.htm) · [incr](https://www.tcl-lang.org/man/tcl8.6/TclCmd/incr.htm) · [unset](https://www.tcl-lang.org/man/tcl8.6/TclCmd/unset.htm) — variable operations.
- [puts](https://www.tcl-lang.org/man/tcl8.6/TclCmd/puts.htm) · [source](https://www.tcl-lang.org/man/tcl8.6/TclCmd/source.htm) · [unknown](https://www.tcl-lang.org/man/tcl8.6/TclCmd/unknown.htm) — output, saved scripts, and interactive abbreviations.

[← Back to index](../README.md#day-1-codes) · [This day’s contents](#contents)
