# Day 1 — Variables & Substitution

[← Attempt 2](../README.md) · [day-1.tcl](../day-1.tcl) · [Day 2 →](day-2.md)

## Evaluation Model

1. **Parse** command words (separated by whitespace; commands end at newline or `;`).
2. **Substitute** left-to-right in a single pass (`$`, `[...]`, `\`).
3. **Execute** the command with the resulting words.

## Core Commands

| Command | Behavior | Example | Output / Effect |
| --- | --- | --- | --- |
| `set var val` | Creates or overwrites `var`; returns `val` | `set var1 1` | `var1` = `1` (returns `1`) |
| `set var` | Reads `var`; errors if unset (no unassigned declaration) | `set var1` | `1` |
| `puts $var` | Writes value + newline to stdout | `puts "$var1 $var2"` | `1 Hello` |
| `unset var` | Deletes `var` from current scope | `unset var1` | `var1` removed |
| `incr var ?n?` | Adds integer `n` (default `1`); auto-inits unset `var` to `0` first | `incr var7 5` | `var7` becomes `5` |
| `# comment` | Valid only where a command starts; inline needs `;#` | `set a 1 ;# ok` | ignored |

## Three Substitutions

| Type | Syntax | Example | Result |
| --- | --- | --- | --- |
| Variable | `$var` / `${var}suffix` | `set res LUT; puts ${res}6` | `LUT6` |
| Command | `[cmd args]` | `set var8 [set var9 84]` | `var9` = `84`, `var8` = `84` |
| Backslash | `\$`, `\[`, `\]`, `\\`, `\n` | `set var1 \$5` | `$5` |
| Backslash | Escape brackets | `set var2 mem\[addr\]` | `mem[addr]` |
| Backslash | Literal `\n` (not newline) | `set var3 \\n` | `\n` |

## Naming Rules

- Stick to letters, digits, and `_` (`var4_1`).
- Unbraced `$var4.1` or `$var4-1` stops scanning at `.` or `-`, reading `$var4` followed by literal `.1` / `-1`.

## Traps & Fixes (from [day-1.tcl](../day-1.tcl))

| Trap | Why | Fix |
| --- | --- | --- |
| `if (0) { ... }` (`day-1.tcl:1`) | Works only because `expr` parses `(0)`; unbraced condition invites double substitution | Use `if {0} { ... }` for block-disabling code |
| `set x` to declare | Single-arg `set` reads a variable and errors if it does not exist | Always give an initial value: `set x ""` or `set x 0` |
| `puts $res6` | Looks for variable named `res6`, not `$res` + `6` | Brace the variable name: `${res}6` |
| `\\n` vs `\n` | `\\` produces one literal `\`, leaving `n` literal | Use `\n` for an actual newline, `\\n` for the two characters `\n` |

## Quick Recall

1. What does `incr count 5` do if `count` was never `set`?
2. Why does `set a [set b 84]` assign `84` to both `a` and `b`?
3. What prints from `puts "\\n"`?

<details>
<summary>Answers</summary>

1. Auto-initializes `count` to `0`, then adds `5` → `count` becomes `5` (Tcl 8.5+).
2. `set b 84` stores `84` in `b` and returns `84`, which command substitution `[...]` passes to `set a`.
3. Literally `\n` (two characters) followed by `puts`'s newline.

</details>
