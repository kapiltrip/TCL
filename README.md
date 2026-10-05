# Tcl/Tk practice

Each day keeps its lesson notes, code examples, and review together. Questions link to the lesson they use; **← Back to index** links return here. The root-level [ideas.md](ideas.md) collects the remaining assignment approaches, with links back to those explanations.

| Day | Topics | Study page |
| --- | --- | --- |
| 1 | Variables, substitution, comments, saving scripts | [Day 1](day-1.md) |
| 2 | Grouping, string tests, indexing, matching, comparison | [Day 2](day-2.md) |
| 3 | Expressions, logic, bitwise operations, units, rounding | [Day 3](day-3.md) |
| 4 · assignments remain | Lists, foreach, split, regexp, captured fields, regsub | [Day 4](day-4.md) |
| 5 · assignments remain | Arrays, keys and values, copying, list conversion | [Day 5](day-5.md) |
| 6 · assignments remain | source, if/elseif/else, switch, while, for | [Day 6](day-6.md) |

Days 1–3 retain 16 earlier assignment reviews and their saved solutions. Days 4–6 review your pasted practice through arrays, conditionals, and loops, with corrected runnable examples and checked output. [Ideas for Assignments 17–33](ideas.md#index) explain the approach and checks for each question, without final answers or completed assignment programs. You implement, review, and submit those assignments.

[Day 1 index](#day-1) · [Day 2 index](#day-2) · [Day 3 index](#day-3) · [Day 4 index](#day-4) · [Day 5 index](#day-5) · [Day 6 index](#day-6) · [Assignment ideas](ideas.md#index) · [Run the code](#run-the-code)

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

Day 4 assignment approaches: [Q17 · unique capacitances](ideas.md#assignment-17-unique-capacitance-values), [Q18 · reversal and positions](ideas.md#assignment-18-second-position-after-reversing-a-list), [Q19 · selected widths](ideas.md#assignment-19-sum-widths-above-a-strict-limit), [Q20 · running power limit](ideas.md#assignment-20-accumulate-power-under-a-running-limit), [Q21 · non-faulty IDs](ideas.md#assignment-21-count-non-faulty-transistors-with-in), [Q22 · numeric suffixes](ideas.md#assignment-22-count-net-names-with-numeric-suffixes).

## Day 5

Arrays · reviewed from your 5 October console session · [Open the complete day page](day-5.md)

| Lesson or review | Related ideas or practice |
| --- | --- |
| [Progress at a glance](day-5.md#progress-at-a-glance) | Correct attempts and corrections |
| [Create an array and update an element](day-5.md#create-an-array-and-update-an-element) | `array exists`, `array size`, updates, and clearing |
| [Read an element and construct a dynamic key](day-5.md#read-an-element-and-construct-a-dynamic-key) | Command names, values, and the trailing-space key |
| [Enumerate keys and preserve key-value pairs](day-5.md#enumerate-keys-and-preserve-key-value-pairs) | [Q24 · largest leakage cell](ideas.md#assignment-24-cell-with-the-highest-leakage-current), [Q25 · parallel resistance](ideas.md#assignment-25-parallel-pmos-resistance) |
| [Copy and print an array](day-5.md#copy-and-print-an-array) | Independent copies, merge behavior, and `parray` |
| [Convert parallel lists into an array](day-5.md#convert-parallel-lists-into-an-array) | [Q26 · indexed lengths and average](ideas.md#assignment-26-indexed-interconnects-and-an-average-filter) |
| [Convert an array into aligned key and value lists](day-5.md#convert-an-array-into-aligned-key-and-value-lists) | [Q27 · maximum gate power](ideas.md#assignment-27-largest-gate-power-from-a-value-list), inconsistent names in your attempt |
| [Store a structured value under an identity key](day-5.md#store-a-structured-value-under-an-identity-key) | [Q23 · transistor W/L ratios](ideas.md#assignment-23-transistor-width-to-length-ratios) |
| [Assignment map and next lesson](day-5.md#assignment-map-and-next-lesson) | All five Day 5 approaches |
| [Complete practice script](day-5.md#complete-practice-script) | Corrected examples and verified output |

## Day 6

Conditionals and loops · reviewed from your 5 October console session · [Open the complete day page](day-6.md)

| Lesson or review | Related ideas or practice |
| --- | --- |
| [Progress at a glance](day-6.md#progress-at-a-glance) | Working examples and remaining syntax issues |
| [Run a saved script with source](day-6.md#run-a-saved-script-with-source) | Actual filenames, `.tcl.txt`, and paths relative to a saved script |
| [Separate the condition from the script body](day-6.md#separate-the-condition-from-the-script-body) | The corrected voting and equality examples |
| [if elseif and else](day-6.md#if-elseif-and-else) | [Q28 · inclusive voltage range](ideas.md#assignment-28-count-nodes-in-an-inclusive-voltage-range), [Q29 · resistance bands](ideas.md#assignment-29-transform-and-sum-resistance-values) |
| [Match literal values with switch](day-6.md#match-literal-values-with-switch) | [Q32 · sampling-rate multipliers](ideas.md#assignment-32-switch-selected-sampling-rate-multipliers) |
| [Match filename patterns and regular expressions](day-6.md#match-filename-patterns-and-regular-expressions) | Corrected `.jpg`/`.txt` labels and matching modes |
| [Share switch bodies and handle whitespace deliberately](day-6.md#share-switch-bodies-and-handle-whitespace-deliberately) | `-- $z`, trailing spaces, shared bodies, and comments |
| [Repeat with while and a changing condition](day-6.md#repeat-with-while-and-a-changing-condition) | [Q30 · reverse digits](ideas.md#assignment-30-reverse-a-number-one-digit-at-a-time), [Q31 · count digits](ideas.md#assignment-31-count-digits-with-while) |
| [Repeat with for and an optional initializer](day-6.md#repeat-with-for-and-an-optional-initializer) | [Q33 · factorial](ideas.md#assignment-33-factorial-with-a-loop), your valid final correction |
| [Choose an accumulator and verify loop boundaries](day-6.md#choose-an-accumulator-and-verify-loop-boundaries) | Counts, sums, products, and termination |
| [Assignment map and stopping point](day-6.md#assignment-map-and-stopping-point) | All six Day 6 approaches |
| [Complete practice script](day-6.md#complete-practice-script) | Corrected examples and verified output |

## Run the code

For a record of the launchers, VS Code settings, and verification, see [What I did: Tcl and VS Code setup](what-i-did.md).

Save your programs with the `.tcl` extension. Your first program is [proj1.tcl](proj1.tcl). In PowerShell opened in this folder, run it with the root-level launcher:

```powershell
.\tclsh.cmd .\proj1.tcl
```

To enter Tcl commands interactively, start the interpreter:

```powershell
.\tclsh.cmd
```

At the Tcl `%` prompt, try the following. Use `exit` to return to PowerShell.

```tcl
puts "Hello world"
set a 10
puts [expr {$a + 5}]
source proj1.tcl
exit
```

When this folder is open in VS Code, save the active `.tcl` file with **Ctrl+S**, then press **Ctrl+Shift+B** to run it. Open a new terminal after loading the workspace settings; it will also accept `tclsh .\proj1.tcl` and `tclsh`. For a terminal that opens directly at the Tcl `%` prompt, choose **Tcl** from the terminal profile menu. These settings are stored in [.vscode/settings.json](.vscode/settings.json) and [.vscode/tasks.json](.vscode/tasks.json); see the VS Code documentation for [terminal profiles](https://code.visualstudio.com/docs/terminal/profiles) and [tasks](https://code.visualstudio.com/docs/debugtest/tasks).

Open `internal/scripts` and double-click [start-tcl.cmd](internal/scripts/start-tcl.cmd) to start the white Tcl console. The launcher sets the working directory to the repository root. At the Tcl `%` prompt, run:

```tcl
source internal/scripts/day-1.tcl
source internal/scripts/day-2.tcl
source internal/scripts/day-3.tcl
source internal/scripts/day-4.tcl
source internal/scripts/day-5.tcl
source internal/scripts/day-6.tcl
```

In PowerShell opened at the repository root, run a saved script with:

```powershell
.\tclsh.cmd .\internal\scripts\day-1.tcl
```

For the Tk greeting window, double-click [start-gui.cmd](internal/scripts/start-gui.cmd). Edit a `.tcl` file and press **Ctrl+S** to save; run it again to see your changes. The [Day 1 saving and comments section](day-1.md#save-scripts-and-write-comments) explains the steps and comment syntax.

## Supporting files

The study pages live at the root. Supporting material lives inside [internal/](internal/README.md): screenshots, runnable scripts, original console transcripts, and runtime provenance. Local installers, interpreter libraries, checks, and previews also stay there and are excluded from Git.

This local folder uses portable Tcl/Tk 8.6.18 from [Magicsplat Tcl/Tk for Windows](https://www.magicsplat.com/tcl-installer/), listed by the [Tcl project](https://www.tcl-lang.org/software/tcltk/bindist.html). See the [installation details](internal/runtime/installation.json). The `.cmd` launchers use `internal/runtime/bin` and `internal/runtime/lib`; a fresh clone needs that runtime layout or an existing Tcl/Tk installation, for example `tclsh internal/scripts/day-1.tcl`.

Use Tcl/Tk for these scripts and GUI exercises. Use Vivado’s Tcl console for FPGA commands such as `create_project` and `synth_design`; see [AMD’s Tcl shell documentation](https://docs.amd.com/r/2025.1-English/ug895-vivado-system-level-design-entry/Launching-the-Vivado-Design-Suite-Tcl-Shell).

[Day 1 index](#day-1) · [Day 2 index](#day-2) · [Day 3 index](#day-3) · [Day 4 index](#day-4) · [Day 5 index](#day-5) · [Day 6 index](#day-6) · [Assignment ideas](ideas.md#index)
