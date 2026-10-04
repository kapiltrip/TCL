# Tcl/Tk practice

Each day keeps its lesson notes, code examples, and assignment reviews together. Questions appear beside the lesson they use; **Related lesson** links return to that explanation, and **← Back to index** links return here.

| Day | Topics | Study page |
| --- | --- | --- |
| 1 | Variables, substitution, comments, saving scripts | [Day 1](day-1.md) |
| 2 | Grouping, string tests, indexing, matching, comparison | [Day 2](day-2.md) |
| 3 | Expressions, logic, bitwise operations, units, rounding | [Day 3](day-3.md) |

The three day pages contain all 16 assignment reviews, original question screenshots, complete solutions, and expected outputs. The recorded answers remain drafts for Kapil to review and submit.

[Day 1 index](#day-1) · [Day 2 index](#day-2) · [Day 3 index](#day-3) · [Run the code](#run-the-code)

## Day 1

Variables and substitution · [Open the complete day page](day-1.md)

| Lesson or review | Related questions |
| --- | --- |
| [Results at a glance](day-1.md#results-at-a-glance) | — |
| [Your original practice](day-1.md#your-original-practice) | — |
| [Commands, values, and output](day-1.md#commands-values-and-output) | — |
| [Variable names and substitution](day-1.md#variable-names-and-substitution) | — |
| [Incrementing variables](day-1.md#incrementing-variables) | — |
| [Command substitution](day-1.md#command-substitution) | — |
| [Backslashes and literal text](day-1.md#backslashes-and-literal-text) | — |
| [The five assignment commands](day-1.md#the-five-assignment-commands) | [Q1](day-1.md#assignment-1-supply-voltage), [Q2](day-1.md#assignment-2-clock-frequency), [Q3](day-1.md#assignment-3-bus-width), [Q4](day-1.md#assignment-4-print-the-supply-voltage), [Q5](day-1.md#assignment-5-print-the-clock-frequency) |
| [Earlier errors: assignment syntax and abbreviations](day-1.md#earlier-errors-assignment-syntax-and-abbreviations) | — |
| [Missing from the screenshots: unset and execution order](day-1.md#missing-from-the-screenshots-unset-and-execution-order) | — |
| [Save scripts and write comments](day-1.md#save-scripts-and-write-comments) | — |
| [A short bridge to Day 2](day-1.md#a-short-bridge-to-day-2) | — |
| [Complete practice script](day-1.md#complete-practice-script) | — |
| [Your console evidence](day-1.md#your-console-evidence) | — |
| [What to revisit before Day 2](day-1.md#what-to-revisit-before-day-2) | — |

## Day 2

Strings and matching · [Open the complete day page](day-2.md)

| Lesson or review | Related questions |
| --- | --- |
| [Drafts at a glance](day-2.md#drafts-at-a-glance) | — |
| [Group words with quotes or braces](day-2.md#group-words-with-quotes-or-braces) | — |
| [Literal quotes, single quotes, and multiline strings](day-2.md#literal-quotes-single-quotes-and-multiline-strings) | — |
| [Test the contents with string is](day-2.md#test-the-contents-with-string-is) | — |
| [Count characters and read an index](day-2.md#count-characters-and-read-an-index) | [Q6](day-2.md#assignment-6-exact-special-string-and-its-length), [Q7](day-2.md#assignment-7-digits-equal-to-3-sum-their-indices), [Q10](day-2.md#assignment-10-ascii-value-at-index-3) |
| [Find the first or last occurrence](day-2.md#find-the-first-or-last-occurrence) | — |
| [Match a pattern](day-2.md#match-a-pattern) | [Q9](day-2.md#assignment-9-find-lut6-with-string-match) |
| [Compare strings or test equality](day-2.md#compare-strings-or-test-equality) | [Q8](day-2.md#assignment-8-compare-parameter-values-with-string-equal) |
| [Map, trim, and change case](day-2.md#map-trim-and-change-case) | — |
| [What the assignments required](day-2.md#what-the-assignments-required) | — |
| [Complete practice script](day-2.md#complete-practice-script) | — |

## Day 3

Expressions and units · [Open the complete day page](day-3.md)

| Lesson or review | Related questions |
| --- | --- |
| [Drafts at a glance](day-3.md#drafts-at-a-glance) | — |
| [Use expr for arithmetic](day-3.md#use-expr-for-arithmetic) | [Q11](day-3.md#assignment-11-current-through-series-resistors), [Q12](day-3.md#assignment-12-rise-and-fall-delays-requested-total), [Q15](day-3.md#assignment-15-transistor-count-for-four-full-adders) |
| [Integer division and floating-point division](day-3.md#integer-division-and-floating-point-division) | — |
| [Logical and relational operations](day-3.md#logical-and-relational-operations) | — |
| [Print decimal, hexadecimal, and binary](day-3.md#print-decimal-hexadecimal-and-binary) | — |
| [Trace your bitwise operations](day-3.md#trace-your-bitwise-operations) | — |
| [Store a computed result before printing it](day-3.md#store-a-computed-result-before-printing-it) | — |
| [Mathematical functions and units](day-3.md#mathematical-functions-and-units) | [Q13](day-3.md#assignment-13-power-in-milliwatts), [Q14](day-3.md#assignment-14-period-of-a-200-mhz-clock), [Q16](day-3.md#assignment-16-rc-transition-time-convert-then-round) |
| [Assignment corrections and completion](day-3.md#assignment-corrections-and-completion) | — |
| [Complete practice script](day-3.md#complete-practice-script) | — |

## Run the code

Open `internal/scripts` and double-click [start-tcl.cmd](internal/scripts/start-tcl.cmd) to start the white Tcl console. The launcher sets the working directory to the repository root. At the Tcl `%` prompt, run:

```tcl
source internal/scripts/day-1.tcl
source internal/scripts/day-2.tcl
source internal/scripts/day-3.tcl
```

In PowerShell opened at the repository root, run a saved script with:

```powershell
.\internal\scripts\tclsh.cmd .\internal\scripts\day-1.tcl
```

For the Tk greeting window, double-click [start-gui.cmd](internal/scripts/start-gui.cmd). Edit a `.tcl` file and press **Ctrl+S** to save; run it again to see your changes. The [Day 1 saving and comments section](day-1.md#save-scripts-and-write-comments) explains the steps and comment syntax.

## Supporting files

The study pages live at the root. Supporting material lives inside [internal/](internal/README.md): screenshots, runnable scripts, the original console transcript, and runtime provenance. Local installers, interpreter libraries, checks, and previews also stay there and are excluded from Git.

This local folder uses portable Tcl/Tk 8.6.18 from [Magicsplat Tcl/Tk for Windows](https://www.magicsplat.com/tcl-installer/), listed by the [Tcl project](https://www.tcl-lang.org/software/tcltk/bindist.html). See the [installation details](internal/runtime/installation.json). The `.cmd` launchers use `internal/runtime/bin` and `internal/runtime/lib`; a fresh clone needs that runtime layout or an existing Tcl/Tk installation, for example `tclsh internal/scripts/day-1.tcl`.

Use Tcl/Tk for these scripts and GUI exercises. Use Vivado’s Tcl console for FPGA commands such as `create_project` and `synth_design`; see [AMD’s Tcl shell documentation](https://docs.amd.com/r/2025.1-English/ug895-vivado-system-level-design-entry/Launching-the-Vivado-Design-Suite-Tcl-Shell).

[Day 1 index](#day-1) · [Day 2 index](#day-2) · [Day 3 index](#day-3)
