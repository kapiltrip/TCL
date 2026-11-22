# Day 1 — Variables & Substitution

[← Attempt 2](../README.md) · [day-1.tcl](../day-1.tcl) · [Day 2 →](day-2.md)

## Definitions

- **Command**: Tcl's only executable unit: `cmdName arg1 arg2 ...`. Terminated by an unescaped newline or `;` outside quotes/braces. Every language construct (`set`, `if`, `proc`) is a command.
- **Word**: One argument token separated by unescaped whitespace unless grouped with `"..."` or `{...}`.
- **Everything Is a String (EIAS)**: Semantically, every Tcl value is a string. Internally Tcl caches typed representations (`Tcl_Obj`) for speed, but observable behavior always follows string rules.
- **Variable**: A named slot in the current scope holding a string value, created on first write (`set`, `incr`, `lappend`). Tcl has no static types and no unassigned variable declaration.
- **Substitution**: Textual replacement performed by the parser *before* the command executes: variable (`$`), command (`[...]`), and backslash (`\`).
- **Single-Pass Rule**: Substitutions run left-to-right **exactly once**. The result of a substitution is **never** re-scanned for `$`, `[...]`, or `\`.

## Evaluation Model (Parse → Substitute → Execute)

1. **Parse**: Split the command line into words using whitespace and grouping (`""`, `{}`).
2. **Substitute**: Resolve `$`, `[...]`, and `\` left-to-right in a single pass inside each unbraced word.
3. **Execute**: Dispatch word 0 as the command name and pass words `1..N` as arguments.

### Step-by-Step Traces

```tcl
# 1. Single-pass rule (no re-scanning)
set b 99
set a {$b}        ;# stores literal two chars: $b
puts $a           ;# => $b  (does NOT re-substitute into 99)

# 2. Nested command substitution
set var8 [set var9 84]
# Pass: inner [set var9 84] executes -> sets var9=84, returns "84"
# Outer becomes: set var8 84 -> sets var8=84

# 3. Backslash vs newline
set var3 \\n      ;# \\ -> literal \, n stays literal n => prints "\n" (2 chars)
```

## Core Commands

| Command | Mechanism & Return | Example | Effect / Output |
| --- | --- | --- | --- |
| `set var val` | Writes `val` to `var` (creating it if needed); **returns `val`** | `set var1 1` | `var1` = `1`, returns `1` |
| `set var` | Reads `var`; throws `can't read "var": no such variable` if unset | `set var1` | returns `1` |
| `puts $var` | Writes string + trailing `\n` to `stdout`; returns `""` | `puts "$var1 $var2"` | `1 Hello` |
| `unset var` | Removes `var` from the current scope | `unset var1` | `var1` deleted |
| `incr var ?n?` | Parses `var` as integer, adds `n` (default `1`), stores & returns new value; in Tcl 8.5+ auto-initializes unset `var` to `0` first | `incr var7 5` | `var7` = `5`, returns `5` |
| `# comment` | Recognized **only** where a command starts; mid-command needs `;` first | `set a 1 ;# note` | ignored |

## Three Substitutions & Identifier Scanning

| Type | Rule | Example | Result |
| --- | --- | --- | --- |
| Variable `$var` | Scans greedily over `[A-Za-z0-9_]` and `::` only; stops at `.`, `-`, or space | `set var4_1 32; puts $var4_1` | `32` |
| Braced variable `${var}` | Reads **every** char until `}` as the name; required before adjacent letters/digits | `set res LUT; puts ${res}6` | `LUT6` |
| Command `[cmd ...]` | Runs inner script recursively; substitutes its return value | `set var8 [set var9 84]` | `84` |
| Backslash `\` | Suppresses special meaning (`\$`, `\[`, `\]`, `\\`) or inserts control char (`\n`, `\t`) | `set var1 \$5; set var2 mem\[addr\]` | `$5`, `mem[addr]` |

- **Why `#` fails inline without `;`**: Tcl parses `#` as a comment only at word 0 of a command. Inside an active command (`set a 1 # comment`), `#` and `comment` are passed as extra arguments to `set`, causing `wrong # args`. Adding `;` terminates `set` so `#` starts a new command position.
- **Why `$var4.1` breaks**: Unbraced `$` stops at `.`, reading `$var4` (missing) + literal `.1`. Use underscores (`var4_1`) or `${var4.1}`.

## Traps & Fixes (from [day-1.tcl](../day-1.tcl))

| Trap | Why | Fix |
| --- | --- | --- |
| `if (0) { ... }` (`day-1.tcl:1`) | Works only because `expr` parses `(0)`; unbraced conditions undergo Tcl substitution before `expr`, inviting bugs | Use `if {0} { ... }` to disable a block |
| `set x` to declare | 1-arg `set` reads `x` and errors when unset | Initialize explicitly: `set x ""` or `set x 0` |
| `puts $res6` | Greedy scanner looks for variable `res6` instead of `$res` + `6` | Delimit the name: `puts ${res}6` |
| `\\n` expecting a newline (`day-1.tcl:35`) | `\\` consumes the backslash into one literal `\`, leaving `n` plain | Use `\n` for a newline, `\\n` for literal `\n` |

## Quick Recall

1. Given `set b 99; set a {$b}`, what does `puts $a` print and why?
2. Why does `set x 1 # comment` fail while `set x 1 ;# comment` succeeds?
3. What does `incr count 5` do when `count` has never been `set`?

<details>
<summary>Answers</summary>

1. Literal `$b` — Tcl's single-pass rule never re-scans the result of `$a` for further `$` substitutions.
2. `#` starts a comment only at command-start position; `;` ends `set x 1` so `#` begins the next command.
3. Auto-initializes `count` to `0`, adds `5`, stores `5`, and returns `5` (Tcl 8.5+).

</details>

## Tcl 8.6 Reference

- [Tcl(n) — 12 syntax rules](https://www.tcl-lang.org/man/tcl8.6/TclCmd/Tcl.htm) · [set(n)](https://www.tcl-lang.org/man/tcl8.6/TclCmd/set.htm) · [incr(n)](https://www.tcl-lang.org/man/tcl8.6/TclCmd/incr.htm) · [unset(n)](https://www.tcl-lang.org/man/tcl8.6/TclCmd/unset.htm)
