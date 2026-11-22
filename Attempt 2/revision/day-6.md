# Day 6 — `source`, Conditionals & Loops

[← Attempt 2](../README.md) · [day-6.tcl](../day-6.tcl) · [sample.tcl](../sample.tcl) · [switch.tcl](../switch.tcl) · [← Day 5](day-5.md) · [Day 7 →](day-7.md)

## Definitions

- **`source`**: Reads a file from disk and evaluates its contents as a Tcl script **inside the caller's current scope** (not an isolated module). Variables and `proc`s defined in the sourced file land directly in the caller's frame/namespace, and `source` returns the result of the file's last executed command.
- **Control-Flow Command**: In Tcl, `if`, `switch`, `while`, and `for` are ordinary commands — not special parser syntax. Their conditions and bodies are simply **braced strings** (`{...}`) passed as arguments, which the command evaluates internally as `expr` expressions or Tcl scripts.
- **Implicit `expr` Evaluation**: The `{cond}` argument of `if`, `elseif`, `while`, and `for`'s test clause is automatically evaluated using `expr` rules (no explicit `[expr {...}]` wrapper needed).
- **`switch` Dispatch**: Compares one target string against an ordered list of `pattern body` pairs under one matching mode (`-exact`, `-glob`, or `-regexp`). Only the **first** matching branch runs; there is **no** C-style implicit fall-through unless the body is explicitly `-`.
- **Option Terminator (`--`)**: Marks the end of `-flag` switches so any following argument (even one starting with `-`, like `"-5"`) is parsed as data.

## `source` & Path Resolution

- `source` resolves relative filenames against `[pwd]` (the process working directory), **not** the directory containing the running script.
- To source a sibling script reliably from any working directory:
  ```tcl
  source [file join [file dirname [info script]] sample.tcl]
  ```

## Conditionals (`if` / `elseif` / `else` & `switch`)

```tcl
if {$age >= 18} {
    puts "eligible"
} elseif {$age >= 16} {
    puts "almost"
} else {
    puts "not eligible"
}
```

- **Why `{` and `else` stay on the same line**: Because `if` is a regular command terminated by a newline. Moving `else` onto a new line after `}` ends `if`, causing Tcl to invoke a nonexistent command named `else`.
- `if {1} { ... }` always executes; `if {0} { ... }` skips cleanly (standard multi-line block-disable idiom).

### `switch` Options & Fall-Through

```tcl
switch -nocase -glob -- $grade {
    "apple" -
    "orange" {
        puts "apple or orange"
    }
    bANANA {
        puts "banana"
    }
    default {
        puts "fallback"
    }
}
```

| Part | Mechanism |
| --- | --- |
| `-exact` (default) | Exact literal string match (no wildcard expansion) |
| `-glob` / `-regexp` | Glob (`*`, `?`, `[...]`) or regular-expression matching |
| `-nocase` | Case-insensitive comparison across all patterns |
| `--` | Ends options so `$grade` starting with `-` is not parsed as an unknown switch |
| `-` as body | Explicit fall-through: shares the next branch's body (`"apple"` runs `"orange"`'s block) |
| `default` | Catch-all pattern when placed last (in `-exact`/`-glob`/`-regexp` modes alike) |

- Inside the braced `{ ... }` switch body, Tcl does **not** substitute `$var` inside patterns (to match variable patterns, pass patterns as separate args instead of one braced list).

## Loops (`while` & `for`)

| Loop | Execution Cycle | Example |
| --- | --- | --- |
| `while {test} {body}` | Evaluate `test` via `expr` → if true, run `body` → repeat until `test` is `0` | `while {$a <= 20} { puts $a; incr a }` |
| `for {init} {test} {next} {body}` | Run `init` once → evaluate `test` → if true, run `body` → run `next` → repeat `test` | `for {set i 0} {$i < 10} {incr i} { puts $i }` |
| `for {} {test} {next} {body}` | Empty `{}` skips `init` when the loop variable is already initialized | `set b 0; for {} {$b < 5} {incr b} { puts $b }` |

- **Why `while` MUST brace its condition**: With `while {$a <= 20} {...}`, `while` receives literal text `{$a <= 20}` and re-reads `$a` on every iteration. Without braces (`while $a<=20 {...}`), Tcl substitutes `$a` **once** before `while` starts (`while 10<=20 {...}`), locking the condition to `true` forever!

## Traps & Fixes (from [day-6.tcl](../day-6.tcl), [switch.tcl](../switch.tcl))

| Trap | Why | Fix |
| --- | --- | --- |
| `source hello.tcl` fails from repo root (`day-6.tcl:2`) | `hello.tcl` is absent and relative `source` looks in `[pwd]`, not `Attempt 2/` | Verify the file exists and build script-relative paths with `[file dirname [info script]]` |
| Omitting `--` in `switch -glob $val {...}` | A value like `"-v"` is parsed as an invalid option flag | Always write `--` before `$val`: `switch -glob -- $val {...}` |
| Unbraced `while $a <= 20 {...}` | Substitutes `$a` once before looping (and splits `<=` / `20` into extra args) | Always brace: `while {$a <= 20} {...}` |
| `# comment` between branches of `switch -- $x { ... }` | Inside `{...}`, `switch` parses `#` as a pattern word rather than a comment | Put comments above `switch` or inside branch `{ ... }` bodies |

## Quick Recall

1. Why does putting `else` on a new line after `}` cause an error in Tcl?
2. What goes wrong with `while $a<=20 { incr a }` compared to `while {$a <= 20} { incr a }`?
3. If `day-6.tcl` is run via `.\tclsh.cmd ".\Attempt 2\day-6.tcl"` from the repo root, which directory does `source sample.tcl` search?

<details>
<summary>Answers</summary>

1. Because `if` is a normal Tcl command ended by a newline; starting the next line with `else` makes Tcl try to call a nonexistent command named `else`.
2. Without braces, `$a` substitutes once before `while` runs (producing constant `10<=20`), causing an infinite loop.
3. The repository root (`[pwd]`), not `Attempt 2/` — use `[file join [file dirname [info script]] sample.tcl]` for script-relative sourcing.

</details>

## Tcl 8.6 Reference

- [source(n)](https://www.tcl-lang.org/man/tcl8.6/TclCmd/source.htm) · [if(n)](https://www.tcl-lang.org/man/tcl8.6/TclCmd/if.htm) · [switch(n)](https://www.tcl-lang.org/man/tcl8.6/TclCmd/switch.htm) · [while(n)](https://www.tcl-lang.org/man/tcl8.6/TclCmd/while.htm) · [for(n)](https://www.tcl-lang.org/man/tcl8.6/TclCmd/for.htm)
