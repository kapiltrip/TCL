# Tcl/Tk practice

Each day keeps its lesson notes, code examples, and assignment reviews together. Questions appear beside the lesson they use; **Related lesson** links return to that explanation, and **← Back to index** links return here.

| Day | Topics | Study page |
| --- | --- | --- |
| 1 | Variables, substitution, comments, saving scripts | [Day 1](day-1.md) |
| 2 | Grouping, string tests, indexing, matching, comparison | [Day 2](day-2.md) |
| 3 | Expressions, logic, bitwise operations, units, rounding | [Day 3](day-3.md) |
| 4 · assignments remain | Lists, foreach, split, regexp, captured fields, regsub | [Day 4](day-4.md) |

Days 1–3 contain 16 assignment reviews, original question screenshots, complete solutions, and expected outputs. Day 4 now covers your practice through `regsub`, with its mistakes and corrections. Assignments 17–22 remain; the preliminary Q17 experiments are reviewed beside sorting. Review and submission remain Kapil’s step.

[Day 1 index](#day-1) · [Day 2 index](#day-2) · [Day 3 index](#day-3) · [Day 4 index](#day-4) · [Run the code](#run-the-code)

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

## Day 4

Lists and regular expressions · practice through `regsub` · assignments remain · [Open the complete day page](day-4.md)

| Lesson or review | Related practice or assignments |
| --- | --- |
| [Progress at a glance](day-4.md#progress-at-a-glance) | Correct results, corrections, and the stopping point |
| [Create lists and preserve element boundaries](day-4.md#create-lists-and-preserve-element-boundaries) | Braces, quotes, trailing spaces, malformed `listb` |
| [Nest lists or concatenate their elements](day-4.md#nest-lists-or-concatenate-their-elements) | `list` versus `concat`; outer lengths 2 and 5 |
| [Employee IDs and nested records](day-4.md#employee-ids-and-nested-records) | Three departments; ID, name, age |
| [Repeat elements and count a list](day-4.md#repeat-elements-and-count-a-list) | `lrepeat`; why `llength listg` differs from `llength $listg` |
| [Read nested indices with lindex](day-4.md#read-nested-indices-with-lindex) | Index paths `{0 1}`, `{0 2}`, and the empty `{0 3}` result |
| [Take a range and assign elements to variables](day-4.md#take-a-range-and-assign-elements-to-variables) | `lrange`, `lassign`, leftovers, and overwritten variables |
| [Append using the variable name](day-4.md#append-using-the-variable-name) | Why `lappend $lista q` edited a different variable |
| [Save the results of linsert and lreplace](day-4.md#save-the-results-of-linsert-and-lreplace) | Returned lists and the `replace` spelling error |
| [Change an element with lset](day-4.md#change-an-element-with-lset) | Update index 0 and print the stored value |
| [Search for indices or matching values](day-4.md#search-for-indices-or-matching-values) | `-glob`, `-all`, and `-inline` |
| [Sort text, integers, and real numbers](day-4.md#sort-text-integers-and-real-numbers) | Comparison modes; [Q17 preliminary practice](day-4.md#assignment-17-preliminary-capacitance-list-practice), still pending |
| [Test membership and save the result](day-4.md#test-membership-and-save-the-result) | Correct `expr` syntax and the unfinished console input |
| [Iterate over lists with foreach](day-4.md#iterate-over-lists-with-foreach) | Unequal lengths, empty values, and body braces |
| [Split a string at delimiter characters](day-4.md#split-a-string-at-delimiter-characters) | `Hello`, adjacent delimiters, and `split $str "ab"` |
| [Choose the result form of regexp](day-4.md#choose-the-result-form-of-regexp) | Match count, named variables, `-all`, `-inline`, `-indices`, `-nocase` |
| [Trace regular-expression patterns](day-4.md#trace-regular-expression-patterns) | Character classes, alternatives, quantifiers, anchors, and empty matches |
| [Capture a vector range and port name](day-4.md#capture-a-vector-range-and-port-name) | Literal brackets, groups, and the `[7:0] datain` example |
| [Extract names and traverse captured fields](day-4.md#extract-names-and-traverse-captured-fields) | Clock-name extraction and grouped vector-port captures |
| [Replace matches with regsub](day-4.md#replace-matches-with-regsub) | Return value versus destination variable; original text and `-all` |
| [Names, values, and changed lists](day-4.md#names-values-and-changed-lists) | Command comparison table |
| [Assignment progress and next lesson](day-4.md#assignment-progress-and-next-lesson) | Lessons through `regsub` done; Assignments 17–22 remain |
| [Complete practice script](day-4.md#complete-practice-script) | Corrected examples and verified output |

## Run the code

Open `internal/scripts` and double-click [start-tcl.cmd](internal/scripts/start-tcl.cmd) to start the white Tcl console. The launcher sets the working directory to the repository root. At the Tcl `%` prompt, run:

```tcl
source internal/scripts/day-1.tcl
source internal/scripts/day-2.tcl
source internal/scripts/day-3.tcl
source internal/scripts/day-4.tcl
```

In PowerShell opened at the repository root, run a saved script with:

```powershell
.\internal\scripts\tclsh.cmd .\internal\scripts\day-1.tcl
```

For the Tk greeting window, double-click [start-gui.cmd](internal/scripts/start-gui.cmd). Edit a `.tcl` file and press **Ctrl+S** to save; run it again to see your changes. The [Day 1 saving and comments section](day-1.md#save-scripts-and-write-comments) explains the steps and comment syntax.

## Supporting files

The study pages live at the root. Supporting material lives inside [internal/](internal/README.md): screenshots, runnable scripts, original console transcripts, and runtime provenance. Local installers, interpreter libraries, checks, and previews also stay there and are excluded from Git.

This local folder uses portable Tcl/Tk 8.6.18 from [Magicsplat Tcl/Tk for Windows](https://www.magicsplat.com/tcl-installer/), listed by the [Tcl project](https://www.tcl-lang.org/software/tcltk/bindist.html). See the [installation details](internal/runtime/installation.json). The `.cmd` launchers use `internal/runtime/bin` and `internal/runtime/lib`; a fresh clone needs that runtime layout or an existing Tcl/Tk installation, for example `tclsh internal/scripts/day-1.tcl`.

Use Tcl/Tk for these scripts and GUI exercises. Use Vivado’s Tcl console for FPGA commands such as `create_project` and `synth_design`; see [AMD’s Tcl shell documentation](https://docs.amd.com/r/2025.1-English/ug895-vivado-system-level-design-entry/Launching-the-Vivado-Design-Suite-Tcl-Shell).

[Day 1 index](#day-1) · [Day 2 index](#day-2) · [Day 3 index](#day-3) · [Day 4 index](#day-4)
