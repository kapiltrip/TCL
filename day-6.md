# Day 6 — Tcl conditionals and loops: notes, code, and practice review

[← Back to index](README.md#day-6) · [Assignment ideas](ideas.md#day-6) · [Runnable Day 6 script](internal/scripts/day-6.tcl)

**Kapil’s practice · reviewed 5 October 2026 · Tcl 8.6.18**

Your [original session](internal/sources/console-session-2026-10-05-arrays-loops.txt) moves from arrays into `source`, `if`, `switch`, `while`, and `for`. This page explains the code you ran, the errors you corrected, and the remaining syntax issues. Checked examples are saved in the runnable script; the final assignments are not included.

The successful `while` and first `for` loop outputs are present in your transcript. The final `for {}` correction includes its closing body brace and is syntactically complete, but its output is not included in the pasted text. Assignments 28–33 remain for you; their detailed approaches are in [ideas.md](ideas.md#day-6).

## Contents

- [Progress at a glance](#progress-at-a-glance)
- [Run a saved script with source](#run-a-saved-script-with-source)
- [Separate the condition from the script body](#separate-the-condition-from-the-script-body)
- [if elseif and else](#if-elseif-and-else)
- [Match literal values with switch](#match-literal-values-with-switch)
- [Match filename patterns and regular expressions](#match-filename-patterns-and-regular-expressions)
- [Share switch bodies and handle whitespace deliberately](#share-switch-bodies-and-handle-whitespace-deliberately)
- [Repeat with while and a changing condition](#repeat-with-while-and-a-changing-condition)
- [Repeat with for and an optional initializer](#repeat-with-for-and-an-optional-initializer)
- [Choose an accumulator and verify loop boundaries](#choose-an-accumulator-and-verify-loop-boundaries)
- [Assignment map and stopping point](#assignment-map-and-stopping-point)
- [Complete practice script](#complete-practice-script)
- [References](#references)

## Progress at a glance

| Your practice | Review |
| --- | --- |
| `source` | Needs an existing filename; your saved file is `proj1.tcl.txt`, whereas you requested `proj_1.tcl` and `proj1.tcl` |
| Voting-age and equality examples | Your final braced `if` commands are correct |
| Early `if` attempts | Put a space between the condition and body; C-style parentheses do not group a Tcl argument |
| Grade and fruit switches | Your final literal matches work |
| Filename glob switch | Patterns matched, but the printed messages for `.jpg` and `.txt` were reversed |
| Grouped switch cases | Separate `--` from `$z`; remove unintended trailing space or explicitly normalize input |
| `while` | Correct: prints 10–19 and leaves `a` at 20 |
| First `for` loop | Correct: prints 0–9 and leaves `i` at 10 |
| `for {}` attempt | The first attempt needs a space before the body; your final correction is valid, with no output captured |
| Assignments 28–33 | Approaches only in `ideas.md`; implementation and submission remain yours |

[← Back to index](README.md#day-6) · [Day contents](#contents) · [Assignment ideas](ideas.md#day-6)

## Run a saved script with source

`source` reads a file and evaluates its Tcl commands in the current interpreter. The filename is required; `source` alone does not open a file picker. Relative paths are resolved from the current working directory, which you can read with `pwd`. The filename’s spelling and extension must match the actual file.

**Your session:** `source proj_1.tcl` and `source proj1.tcl` failed because those filenames did not exist. The local file is named `proj1.tcl.txt` and currently contains `puts "Hello world "`. Tcl can source a `.txt` file containing valid code; a `.tcl` extension simply makes the purpose clearer. Your original file is preserved. The saved example below lives under `internal/scripts`.

At the `%` prompt from the repository root, use:

```tcl
source internal/scripts/source-demo.tcl
```

For a path inside another saved script, derive the sibling path from that script’s location. This avoids depending on where the console was launched.

```tcl
set demo_file [file join [file dirname [file normalize [info script]]] source-demo.tcl]
puts "source demo exists=[file exists $demo_file]"
source -encoding utf-8 $demo_file
```

Output:

```text
source demo exists=1
Hello from the saved script.
```

The two lines above are intended to run **inside `internal/scripts/day-6.tcl`**. In an interactive prompt, `info script` is normally empty; use the direct repository-relative command there. `source` preserves the current working directory and does not start a separate Tcl process. Variables assigned by a sourced file are therefore available in the caller’s current scope. See [`source`](https://www.tcl-lang.org/man/tcl8.6/TclCmd/source.htm) and [`info script`](https://www.tcl-lang.org/man/tcl8.6/TclCmd/info.htm).

Your console’s `ls` became an ambiguous Tcl command abbreviation. Use Tcl’s `glob -nocomplain *` to list names, or use `dir` in PowerShell. In an editor’s Save As dialog, save a code file as `name.tcl` with **All files** selected, and check that Windows has not silently appended `.txt`. [Day 1 saving notes](day-1.md#save-scripts-and-write-comments) cover the editing workflow.

[← Back to index](README.md#day-6) · [Day contents](#contents) · [Assignment ideas](ideas.md#day-6)

## Separate the condition from the script body

**Your session:** `if {$age >= 18}{...}` failed with `extra characters after close-brace`. Braces group one word. After that word closes, Tcl needs whitespace before the next word. It cannot interpret adjacent braced words as separate arguments.

The command has three main words: `if`, a condition, and a script body. Parentheses are expression syntax, not Tcl argument grouping, so `if ($age >= 18){` is split incorrectly before `if` can evaluate it. Your final form has the correct separation.

```tcl
set age 18
if {$age >= 18} {
    puts "You are eligible for voting"
} else {
    puts "You are not eligible for voting"
}
set x 5
if {$x == 5} {
    puts "X is equal to 5"
} else {
    puts "X is not equal to 5"
}
```

Output:

```text
You are eligible for voting
X is equal to 5
```

The voting message is the output of your teaching example, not a statement about election law. Braces delay substitutions in the expression until `if` evaluates it. The body is also passed as one word, then evaluated as Tcl only if selected. Keep `} else {` on the same command line; a bare `else` on a new command line is not a separate Tcl command. See [`if`](https://www.tcl-lang.org/man/tcl8.6/TclCmd/if.htm) and the [word parsing rules](https://www.tcl-lang.org/man/tcl8.6/TclCmd/Tcl.htm).

[← Back to index](README.md#day-6) · [Day contents](#contents) · [Assignment ideas](ideas.md#day-6)

## if elseif and else

An `if` chain tests its conditions in order. The first true condition selects one body; later branches are skipped. `elseif` is one word. An `else` body covers the remaining cases and has no expression of its own.

The following extension uses independent lesson data to make the boundary behavior visible.

```tcl
foreach score {4 10 14 20} {
    if {$score < 10} {
        set category low
    } elseif {$score <= 15} {
        set category middle
    } else {
        set category high
    }
    puts "$score -> $category"
}
```

Output:

```text
4 -> low
10 -> middle
14 -> middle
20 -> high
```

When `score` is `10`, the first condition is false and the second is true. When the second condition is tested, the first branch has already established that the value is not below `10`; repeating that lower bound is optional here. For membership in a bounded range, combine the lower and upper comparisons with `&&`. A mathematical chained comparison such as `10 <= $score <= 15` does not express a Tcl range test.

**Related ideas:** [Q28: inclusive voltage range](ideas.md#assignment-28-count-nodes-in-an-inclusive-voltage-range), [Q29: mutually exclusive resistance bands](ideas.md#assignment-29-transform-and-sum-resistance-values).

[← Back to index](README.md#day-6) · [Day contents](#contents) · [Assignment ideas](ideas.md#day-6)

## Match literal values with switch

Your grade `b` selected its matching branch. Your later fruit input `banana` selected the `banana` branch; running the fruit patterns against the earlier grade `b` correctly selected `default`.

Use a descriptive variable name and make the matching mode explicit. `--` ends option parsing; it is a separate word before the input string.

```tcl
set grade b
switch -exact -- $grade {
    a {puts "Well done"}
    b {puts "Good; could be better"}
    c {puts "Try again"}
    default {puts "Unknown grade"}
}
set fruit banana
switch -exact -- $fruit {
    apple {puts "It is an apple"}
    banana {puts "It is a banana"}
    default {puts "Select a listed fruit"}
}
```

Output:

```text
Good; could be better
It is a banana
```

`switch` compares its input with patterns in order and executes the first matching body. It does not evaluate arithmetic conditions in exact mode. `default` belongs last. No C-style `break` is needed after a normal branch. In the braced pattern/body list, pattern words do not undergo variable substitution; `$some_pattern` there is literal pattern text. See [`switch`](https://www.tcl-lang.org/man/tcl8.6/TclCmd/switch.htm).

**Related idea:** [Q32: select a multiplier, then update a product](ideas.md#assignment-32-switch-selected-sampling-rate-multipliers).

[← Back to index](README.md#day-6) · [Day contents](#contents) · [Assignment ideas](ideas.md#day-6)

## Match filename patterns and regular expressions

**Your session:** `*.jpg` matched `Filetype.jpg`, but its body printed `ITs a text file`. The `.txt` branch printed the image message. The matching logic worked; the two labels were reversed. The first example corrects the labels and tests each path.

```tcl
foreach filename {Filetype.jpg notes.txt data.bin} {
    switch -glob -- $filename {
        *.jpg {set kind {JPEG image}}
        *.txt {set kind {text file}}
        default {set kind {unrecognized extension}}
    }
    puts "$filename -> $kind"
}
set message {warn: clock not locked}
switch -regexp -- $message {
    {^warn:} {puts "Warning message"}
    {^error:} {puts "Error message"}
    default {puts "Ordinary message"}
}
```

Output:

```text
Filetype.jpg -> JPEG image
notes.txt -> text file
data.bin -> unrecognized extension
Warning message
```

Glob `*.jpg` means any leading characters followed by `.jpg`; the dot is literal. In a regular expression, a dot normally matches any character, and `*` quantifies the preceding atom. Choose the matching mode before designing the pattern. Exact and glob comparisons are case-sensitive by default; `-nocase` is an explicit choice. [Day 4 regular-expression notes](day-4.md#trace-regular-expression-patterns) explain the pattern syntax used by the second example.

[← Back to index](README.md#day-6) · [Day contents](#contents) · [Assignment ideas](ideas.md#day-6)

## Share switch bodies and handle whitespace deliberately

**Your session:** you set `z` to `"apple "`, including a trailing space, then wrote `switch -exact --$z ...`. Because `--` and `$z` were joined, the input word became `--apple ` instead of `apple `. It could match none of your fruit patterns, so a switch without `default` could return quietly. Setting `z` to `apple` did not repair the missing separation; the word still became `--apple`.

The pattern/body lines belong inside the switch’s braced list. Typing `"apple" -` as its own command tries to run a command named `apple`. A body consisting of the literal `-` shares the next pattern’s body.

```tcl
set raw_item "apple "
puts "raw item=|$raw_item| length=[string length $raw_item]"
set item [string trim $raw_item]
switch -exact -- $item {
    apple -
    banana -
    orange {
        # This comment is inside an executable body.
        puts "Fruit"
    }
    diamond -
    emerald {puts "Stone"}
    default {puts "Unknown item"}
}
```

Output:

```text
raw item=|apple | length=6
Fruit
```

Trimming here is a deliberate rule for this demonstration. A trailing space can be meaningful in other inputs, so do not remove it automatically everywhere. Likewise, `Banana` and `banana` are different exact patterns unless you choose `-nocase`. Place comments inside branch bodies: the outer switch block is parsed as a list of pattern/body pairs, so an apparent standalone `#` comment between those pairs is not a Tcl comment at that stage. See the [`switch` list and shared-body rules](https://www.tcl-lang.org/man/tcl8.6/TclCmd/switch.htm).

[← Back to index](README.md#day-6) · [Day contents](#contents) · [Assignment ideas](ideas.md#day-6)

## Repeat with while and a changing condition

Your `while {$a < 20}` is correct: initialize `a`, test the condition, execute the body, and update `a`. The condition is tested again before each iteration. The final update makes the next test false.

```tcl
set a 10
while {$a < 20} {
    puts "Value of a: $a"
    incr a
}
puts "after loop: a=$a"
```

Output:

```text
Value of a: 10
Value of a: 11
Value of a: 12
Value of a: 13
Value of a: 14
Value of a: 15
Value of a: 16
Value of a: 17
Value of a: 18
Value of a: 19
after loop: a=20
```

| Stage | Value of `a` | Effect |
| --- | --- | --- |
| First test | 10 | Condition is true; print, then increment |
| Last executing iteration | 19 | Print 19, then increment to 20 |
| Final test | 20 | Condition is false; body is skipped |

The loop itself returns an empty string; printing or saving an accumulated result is a separate step. Keep the condition in braces. In `while "$a < 20" ...`, the initial substitution produces the fixed expression `10 < 20`, so updates of `a` would not make that expression false. Every loop needs a route toward termination. See [`while`](https://www.tcl-lang.org/man/tcl8.6/TclCmd/while.htm).

**Related ideas:** [Q30: consume digits from the end](ideas.md#assignment-30-reverse-a-number-one-digit-at-a-time), [Q31: count digit-removal steps](ideas.md#assignment-31-count-digits-with-while).

[← Back to index](README.md#day-6) · [Day contents](#contents) · [Assignment ideas](ideas.md#day-6)

## Repeat with for and an optional initializer

Your first `for` loop is correct. It has four grouped arguments after the command: initialization, test, next step, and body. The order is **initialize once → test → body → next step → test again**. There is no need to add semicolons between those four arguments.

```tcl
for {set i 0} {$i < 10} {incr i} {
    puts "Value of i: $i"
}
puts "after first loop: i=$i"
set b 0
for {} {$b < 3} {incr b} {
    puts "Existing counter: $b"
}
puts "after second loop: b=$b"
```

Output:

```text
Value of i: 0
Value of i: 1
Value of i: 2
Value of i: 3
Value of i: 4
Value of i: 5
Value of i: 6
Value of i: 7
Value of i: 8
Value of i: 9
after first loop: i=10
Existing counter: 0
Existing counter: 1
Existing counter: 2
after second loop: b=3
```

The first loop prints `0` through `9`, then leaves `i=10`. The second is an added short demonstration of your intended `for {}` form: `{}` is a valid empty initialization script because `b` was initialized before the loop.

Your earlier `{incr b}{` needs a space before the body brace. Your pasted final correction includes that space and closes its body correctly. `info complete` returns `1` for that final command, and the loop is valid with the recorded initial `b=0`. Its output is absent from the pasted text; that absence does not mean the syntax is wrong. The shorter demonstration above shows the same mechanism on a different bound. See [`for`](https://www.tcl-lang.org/man/tcl8.6/TclCmd/for.htm) and [`info complete`](https://www.tcl-lang.org/man/tcl8.6/TclCmd/info.htm).

**Related idea:** [Q33: factorial and the multiplication identity](ideas.md#assignment-33-factorial-with-a-loop).

[← Back to index](README.md#day-6) · [Day contents](#contents) · [Assignment ideas](ideas.md#day-6)

## Choose an accumulator and verify loop boundaries

The result variable’s initial value depends on the operation. This is a reasoning step to settle before writing the body.

| Goal | Initial value | Update idea | Why |
| --- | --- | --- | --- |
| Count accepted entries | `0` | Add one when an entry qualifies | No accepted entries means zero |
| Sum accepted values | `0.0` for real data | Add the accepted contribution | Zero leaves addition unchanged |
| Multiply selected factors | `1` | Multiply by each selected factor | One leaves multiplication unchanged |
| Find a maximum | First actual entry, when available | Retain the larger value and its key if needed | An arbitrary starting zero can fail on negative data |

Reset every accumulator before a new run, even in an interactive session. For a sum or product, trace a few iterations on different practice data and name what the accumulator represents after each step. Test exact endpoints separately: “below” excludes equality, while “inclusive” includes it.

`break` ends a loop immediately; `continue` skips the rest of the current iteration. In a `for`, `continue` still leads to the next-step script. In a `while`, it skips any later update in the body, so a misplaced `continue` can prevent termination. These controls should be used only when they express the intended traversal. For instance, skipping one rejected value is different from stopping at the first rejection.

[← Back to index](README.md#day-6) · [Day contents](#contents) · [Assignment ideas](ideas.md#day-6)

## Assignment map and stopping point

| Assignment | Main mechanism | Detailed approach |
| --- | --- | --- |
| 28 | `foreach` traversal and an inclusive `if` range | [Count safe voltage nodes](ideas.md#assignment-28-count-nodes-in-an-inclusive-voltage-range) |
| 29 | One `if`/`elseif`/`else` transformation per entry | [Transform and sum resistances](ideas.md#assignment-29-transform-and-sum-resistance-values) |
| 30 | Remainder, integer division, and a growing result | [Reverse a number one digit at a time](ideas.md#assignment-30-reverse-a-number-one-digit-at-a-time) |
| 31 | `while` and a shrinking integer | [Count digits with while](ideas.md#assignment-31-count-digits-with-while) |
| 32 | `switch` selection and a product accumulator | [Sampling-rate multipliers](ideas.md#assignment-32-switch-selected-sampling-rate-multipliers) |
| 33 | Loop bounds and successive integer multiplication | [Factorial with a loop](ideas.md#assignment-33-factorial-with-a-loop) |

The notes now reach Day 6 and cover the pasted lesson code. The saved scripts contain corrected practice examples. Assignment 17–33 approaches remain in the single root-level [ideas.md](ideas.md), without final answers, completed assignment scripts, filled course responses, or submissions.

[← Back to index](README.md#day-6) · [Day contents](#contents) · [Assignment ideas](ideas.md#day-6)

## Complete practice script

At the Tcl `%` prompt, with the repository root as the working directory, run `source internal/scripts/day-6.tcl`. The script initializes its own demonstration variables, prints its results, and can be sourced again. It contains lesson examples only.

```tcl
# Day 6: corrected lesson practice from Kapil's 5 October 2026 session.
# See day-6.md for original attempts and explanations.
# Assignment solutions are not included.

# Run a saved script with source.
set demo_file [file join [file dirname [file normalize [info script]]] source-demo.tcl]
puts "source demo exists=[file exists $demo_file]"
source -encoding utf-8 $demo_file

# Separate the condition from the script body.
set age 18
if {$age >= 18} {
    puts "You are eligible for voting"
} else {
    puts "You are not eligible for voting"
}
set x 5
if {$x == 5} {
    puts "X is equal to 5"
} else {
    puts "X is not equal to 5"
}

# if elseif and else.
foreach score {4 10 14 20} {
    if {$score < 10} {
        set category low
    } elseif {$score <= 15} {
        set category middle
    } else {
        set category high
    }
    puts "$score -> $category"
}

# Match literal values with switch.
set grade b
switch -exact -- $grade {
    a {puts "Well done"}
    b {puts "Good; could be better"}
    c {puts "Try again"}
    default {puts "Unknown grade"}
}
set fruit banana
switch -exact -- $fruit {
    apple {puts "It is an apple"}
    banana {puts "It is a banana"}
    default {puts "Select a listed fruit"}
}

# Match filename patterns and regular expressions.
foreach filename {Filetype.jpg notes.txt data.bin} {
    switch -glob -- $filename {
        *.jpg {set kind {JPEG image}}
        *.txt {set kind {text file}}
        default {set kind {unrecognized extension}}
    }
    puts "$filename -> $kind"
}
set message {warn: clock not locked}
switch -regexp -- $message {
    {^warn:} {puts "Warning message"}
    {^error:} {puts "Error message"}
    default {puts "Ordinary message"}
}

# Share switch bodies and handle whitespace deliberately.
set raw_item "apple "
puts "raw item=|$raw_item| length=[string length $raw_item]"
set item [string trim $raw_item]
switch -exact -- $item {
    apple -
    banana -
    orange {
        # This comment is inside an executable body.
        puts "Fruit"
    }
    diamond -
    emerald {puts "Stone"}
    default {puts "Unknown item"}
}

# Repeat with while and a changing condition.
set a 10
while {$a < 20} {
    puts "Value of a: $a"
    incr a
}
puts "after loop: a=$a"

# Repeat with for and an optional initializer.
for {set i 0} {$i < 10} {incr i} {
    puts "Value of i: $i"
}
puts "after first loop: i=$i"
set b 0
for {} {$b < 3} {incr b} {
    puts "Existing counter: $b"
}
puts "after second loop: b=$b"
```

Output:

```text
source demo exists=1
Hello from the saved script.
You are eligible for voting
X is equal to 5
4 -> low
10 -> middle
14 -> middle
20 -> high
Good; could be better
It is a banana
Filetype.jpg -> JPEG image
notes.txt -> text file
data.bin -> unrecognized extension
Warning message
raw item=|apple | length=6
Fruit
Value of a: 10
Value of a: 11
Value of a: 12
Value of a: 13
Value of a: 14
Value of a: 15
Value of a: 16
Value of a: 17
Value of a: 18
Value of a: 19
after loop: a=20
Value of i: 0
Value of i: 1
Value of i: 2
Value of i: 3
Value of i: 4
Value of i: 5
Value of i: 6
Value of i: 7
Value of i: 8
Value of i: 9
after first loop: i=10
Existing counter: 0
Existing counter: 1
Existing counter: 2
after second loop: b=3
```

[← Back to index](README.md#day-6) · [Day contents](#contents) · [Assignment ideas](ideas.md#day-6)

## References

- [Namaste FPGA, Foundation Series 3: Tcl fundamentals](https://namaste-fpga.com/student/learn/37?contentId=1801): Day 6 outline and Assignments 28–33, checked in Chrome on 5 October 2026; select the item in the course outline.
- [Tcl 8.6 `source`](https://www.tcl-lang.org/man/tcl8.6/TclCmd/source.htm) and [`info`](https://www.tcl-lang.org/man/tcl8.6/TclCmd/info.htm): saved files, current-script paths, and incomplete commands.
- [Tcl 8.6 syntax](https://www.tcl-lang.org/man/tcl8.6/TclCmd/Tcl.htm) and [`if`](https://www.tcl-lang.org/man/tcl8.6/TclCmd/if.htm): word boundaries, deferred expression evaluation, and conditional bodies.
- [Tcl 8.6 `switch`](https://www.tcl-lang.org/man/tcl8.6/TclCmd/switch.htm): modes, option separation, shared bodies, and comments.
- [Tcl 8.6 `while`](https://www.tcl-lang.org/man/tcl8.6/TclCmd/while.htm) and [`for`](https://www.tcl-lang.org/man/tcl8.6/TclCmd/for.htm): evaluation order, loop updates, `break`, and `continue`.

[← Back to index](README.md#day-6)
