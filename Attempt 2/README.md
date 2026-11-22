# Attempt 2 — Tcl Revision Index

[← Repository README](../README.md) · Tcl 8.6.18

```powershell
.\tclsh.cmd ".\Attempt 2\day-1.tcl"
```

## Day-by-Day Revision Sheets

| Day | Focus | Revision sheet | Practice code |
| --- | --- | --- | --- |
| 1 | Commands, variables, substitution, evaluation order | [Day 1](revision/day-1.md) | [day-1.tcl](day-1.tcl) |
| 2 | Grouping (`""` vs `{}`), `string` tests, search, match, transforms | [Day 2](revision/day-2.md) | [day-2.tcl](day-2.tcl) |
| 3 | `expr` operators, bitwise, `format` specifiers, math functions | [Day 3](revision/day-3.md) | [day-3.tcl](day-3.tcl) |
| 4 | Lists, `foreach`, `split`, `regexp`, `regsub` | [Day 4](revision/day-4.md) | [day-4.tcl](day-4.tcl) |
| 5 | Associative arrays, copying, list ↔ array conversion | [Day 5](revision/day-5.md) | [day-5.tcl](day-5.tcl) |
| 6 | `source`, `if`/`else`, `switch`, `while`, `for` | [Day 6](revision/day-6.md) | [day-6.tcl](day-6.tcl) · [sample.tcl](sample.tcl) · [switch.tcl](switch.tcl) |
| 7 | `proc`, default args, `return`, `global`, `upvar` | [Day 7](revision/day-7.md) | [day-7.tcl](day-7.tcl) |
| 8 | Namespaces, `variable`, `export`/`import`, ensembles, `info` | [Day 8](revision/day-8.md) | [day-8.tcl](day-8.tcl) |
| 9 | `file` path ops, `glob`, directory ops, `open`/`gets`/`puts`/`close` | [Day 9](revision/day-9.md) | [day-9.tcl](day-9.tcl) · [timing.txt](timing.txt) |

## Five Rules That Prevent Most Tcl Bugs

| Rule | Remember | Example |
| --- | --- | --- |
| Braces vs quotes | `{...}` freezes substitution; `"..."` evaluates `$`, `[...]`, `\` | `expr {$a + $b}`, `while {$a <= 20} {...}` |
| Name vs `$value` | Mutating commands take the variable **name** (no `$`); pure commands take `$value` | `incr x`, `lappend lst a`, `lset lst 0 9`, `upvar $ref local` |
| Return vs mutate | `string *`, `linsert`, `lreplace`, `lassign`, `lsort` leave the original variable untouched | `set lst [linsert $lst 1 12]` |
| Scope keywords | Inside `proc`, vars are local unless linked with `global`, `variable`, or `upvar` | `variable arr` inside every namespace `proc` |
| Expansion `{*}` | Unpacks a list into separate command arguments | `file join {*}$parts`, `file delete {*}[glob -nocomplain *.txt]` |

## Core Tcl Terms

| Term | Definition | Deep dive |
| --- | --- | --- |
| Single-pass substitution | `$`, `[...]`, `\` run left-to-right once; substituted text is never re-scanned | [Day 1](revision/day-1.md#definitions) |
| Double substitution | Unbraced `expr`/`while` parses once in Tcl and again inside `expr` | [Day 3](revision/day-3.md#definitions) |
| Canonical list | Whitespace-delimited sequence with `{}`/`\` quoting preserving spaces and nesting | [Day 4](revision/day-4.md#definitions) |
| Associative array | Hash-table collection of variables (`arr(key)`), passed by name or `array get` | [Day 5](revision/day-5.md#definitions) |
| Call frame & `upvar` | Per-`proc` local variable table; `upvar` aliases a local name to another frame's slot | [Day 7](revision/day-7.md#definitions) |
| Channel & EOF | Buffered OS I/O stream from `open`; `gets` returns `0` on blank lines, `-1` at EOF | [Day 9](revision/day-9.md#definitions) |
