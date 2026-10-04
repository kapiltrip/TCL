# Tcl/Tk practice

Study notes, runnable code, and assignment reviews from Days 1–3 of the [Namaste FPGA Tcl course](https://namaste-fpga.com/student/learn/37?contentId=1801).

Choose a day and a question or topic below. Each link opens that exact section; **← Back to index** returns to the same day in this index. The assignment pages keep the original question screenshots, your work, corrections, complete code, and expected results together.

[Assignments](#assignments) · [Codes and notes](#codes) · [Run the scripts](#run-the-scripts)

## Assignments

All 16 assignments have documented numeric drafts. Submission and the course’s final grading remain your step.

### Day 1 assignments

Variables and substitution · [Open the full review](assignments/day-1.md)

| Question | Topic |
| --- | --- |
| 1 | [supply voltage](assignments/day-1.md#assignment-1-supply-voltage) |
| 2 | [clock frequency](assignments/day-1.md#assignment-2-clock-frequency) |
| 3 | [bus width](assignments/day-1.md#assignment-3-bus-width) |
| 4 | [print the supply voltage](assignments/day-1.md#assignment-4-print-the-supply-voltage) |
| 5 | [print the clock frequency](assignments/day-1.md#assignment-5-print-the-clock-frequency) |

### Day 2 assignments

Strings and matching · [Open the full review](assignments/day-2.md)

| Question | Topic |
| --- | --- |
| 6 | [Exact special string and its length](assignments/day-2.md#assignment-6-exact-special-string-and-its-length) |
| 7 | [Digits equal to 3: sum their indices](assignments/day-2.md#assignment-7-digits-equal-to-3-sum-their-indices) |
| 8 | [Compare parameter values with string equal](assignments/day-2.md#assignment-8-compare-parameter-values-with-string-equal) |
| 9 | [Find LUT6 with string match](assignments/day-2.md#assignment-9-find-lut6-with-string-match) |
| 10 | [ASCII value at index 3](assignments/day-2.md#assignment-10-ascii-value-at-index-3) |

### Day 3 assignments

Expressions and units · [Open the full review](assignments/day-3.md)

| Question | Topic |
| --- | --- |
| 11 | [Current through series resistors](assignments/day-3.md#assignment-11-current-through-series-resistors) |
| 12 | [Rise and fall delays: requested total](assignments/day-3.md#assignment-12-rise-and-fall-delays-requested-total) |
| 13 | [Power in milliwatts](assignments/day-3.md#assignment-13-power-in-milliwatts) |
| 14 | [Period of a 200 MHz clock](assignments/day-3.md#assignment-14-period-of-a-200-mhz-clock) |
| 15 | [Transistor count for four full adders](assignments/day-3.md#assignment-15-transistor-count-for-four-full-adders) |
| 16 | [RC transition time: convert, then round](assignments/day-3.md#assignment-16-rc-transition-time-convert-then-round) |

## Codes

Each day has one notes file and one runnable practice script. The notes explain the commands, trace your results, and discuss the errors from your console session.

### Day 1 codes

Variables and substitution · [Open all notes](codes/day-1.md) · [Runnable script](codes/day-1.tcl)

- [Your original practice](codes/day-1.md#your-original-practice)
- [Commands, values, and output](codes/day-1.md#commands-values-and-output)
- [Variable names and substitution](codes/day-1.md#variable-names-and-substitution)
- [Incrementing variables](codes/day-1.md#incrementing-variables)
- [Command substitution](codes/day-1.md#command-substitution)
- [Backslashes and literal text](codes/day-1.md#backslashes-and-literal-text)
- [The five assignment commands](codes/day-1.md#the-five-assignment-commands)
- [Earlier errors: assignment syntax and abbreviations](codes/day-1.md#earlier-errors-assignment-syntax-and-abbreviations)
- [Missing from the screenshots: unset and execution order](codes/day-1.md#missing-from-the-screenshots-unset-and-execution-order)
- [Save scripts and write comments](codes/day-1.md#save-scripts-and-write-comments)
- [A short bridge to Day 2](codes/day-1.md#a-short-bridge-to-day-2)
- [Complete practice script](codes/day-1.md#complete-practice-script)

### Day 2 codes

Strings and matching · [Open all notes](codes/day-2.md) · [Runnable script](codes/day-2.tcl)

- [Group words with quotes or braces](codes/day-2.md#group-words-with-quotes-or-braces)
- [Literal quotes, single quotes, and multiline strings](codes/day-2.md#literal-quotes-single-quotes-and-multiline-strings)
- [Test the contents with string is](codes/day-2.md#test-the-contents-with-string-is)
- [Count characters and read an index](codes/day-2.md#count-characters-and-read-an-index)
- [Find the first or last occurrence](codes/day-2.md#find-the-first-or-last-occurrence)
- [Match a pattern](codes/day-2.md#match-a-pattern)
- [Compare strings or test equality](codes/day-2.md#compare-strings-or-test-equality)
- [Map, trim, and change case](codes/day-2.md#map-trim-and-change-case)
- [What the assignments required](codes/day-2.md#what-the-assignments-required)
- [Complete practice script](codes/day-2.md#complete-practice-script)

### Day 3 codes

Expressions and units · [Open all notes](codes/day-3.md) · [Runnable script](codes/day-3.tcl)

- [Use expr for arithmetic](codes/day-3.md#use-expr-for-arithmetic)
- [Integer division and floating-point division](codes/day-3.md#integer-division-and-floating-point-division)
- [Logical and relational operations](codes/day-3.md#logical-and-relational-operations)
- [Print decimal, hexadecimal, and binary](codes/day-3.md#print-decimal-hexadecimal-and-binary)
- [Trace your bitwise operations](codes/day-3.md#trace-your-bitwise-operations)
- [Store a computed result before printing it](codes/day-3.md#store-a-computed-result-before-printing-it)
- [Mathematical functions and units](codes/day-3.md#mathematical-functions-and-units)
- [Assignment corrections and completion](codes/day-3.md#assignment-corrections-and-completion)
- [Complete practice script](codes/day-3.md#complete-practice-script)

## Run the scripts

In this local folder, double-click [start-tcl.cmd](start-tcl.cmd) for the Tcl console or [start-gui.cmd](start-gui.cmd) for the Tk greeting window. The console uses a white background with dark text.

At the Tcl `%` prompt, run a saved script with `source`:

```tcl
source codes/day-1.tcl
source codes/day-2.tcl
source codes/day-3.tcl
```

In PowerShell opened at the repository root, run:

```powershell
.\tclsh.cmd .\codes\day-1.tcl
.\tclsh.cmd .\codes\day-2.tcl
.\tclsh.cmd .\codes\day-3.tcl
.\wish.cmd .\codes\hello-gui.tcl
```

Edit a `.tcl` file in your editor and press **Ctrl+S** to save it. Run it again to see the changes. For comments, write `#` at the start of a command:

```tcl
# Supply voltage in volts.
set vdd 1.0 ;# A comment after a command needs the semicolon.
puts $vdd
```

The [Day 1 saving and comments section](codes/day-1.md#save-scripts-and-write-comments) explains the steps. The additional [console example](codes/hello.tcl) and [GUI example](codes/hello-gui.tcl) are ready to edit.

## Folder guide

| Location | What it contains |
| --- | --- |
| `assignments/` | One review file per day, with numbered questions and full solutions |
| `codes/` | One notes file and runnable practice script per day, greeting examples, and the original [console transcript](codes/console-session.txt) |
| `images/` | Shared question and console screenshots, embedded in the notes and reviews |
| `runtime/` | Local Tcl/Tk interpreter and libraries; only [installation details](runtime/installation.json) are tracked |

## Runtime and Vivado

This local folder uses portable **Tcl/Tk 8.6.18 for Windows x64** from [Magicsplat Tcl/Tk for Windows](https://www.magicsplat.com/tcl-installer/), a distribution listed by the [Tcl project](https://www.tcl-lang.org/software/tcltk/bindist.html). Downloaded executables and libraries stay local.

The launchers use `runtime/bin` and `runtime/lib`. For a fresh clone, prepare that runtime layout or run the scripts with an existing Tcl/Tk installation, for example `tclsh codes/day-1.tcl`.

Use Tcl/Tk here for general scripts and GUI exercises. Use Vivado’s Tcl console for FPGA commands such as `create_project` and `synth_design`; see [AMD’s Tcl shell documentation](https://docs.amd.com/r/2025.1-English/ug895-vivado-system-level-design-entry/Launching-the-Vivado-Design-Suite-Tcl-Shell).

[Back to assignments](#assignments) · [Back to codes](#codes)
