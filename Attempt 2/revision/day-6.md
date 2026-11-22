# Day 6 — `source`, Conditionals & Loops

[← Attempt 2](../README.md) · [day-6.tcl](../day-6.tcl) · [sample.tcl](../sample.tcl) · [switch.tcl](../switch.tcl) · [← Day 5](day-5.md) · [Day 7 →](day-7.md)

## Running External Scripts (`source`)

- `source file.tcl` reads and executes `file.tcl` in the current interpreter context (variables/procs become visible).
- Relative paths resolve against the **current working directory**, not the script's own folder.
- Script-relative pattern (works regardless of where `tclsh` is launched):
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

- Brace `{` **must** stay on the same line as `if`, `elseif`, `else`, `while`, `for` (a newline terminates a Tcl command).
- `if {1} { ... }` always executes; `if {0} { ... }` disables a block cleanly.

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

| Part | Role |
| --- | --- |
| `-exact` (default) | Literal string match (no wildcards) |
| `-glob` / `-regexp` | Glob (`*`, `?`) or regex pattern match |
| `-nocase` | Case-insensitive match |
| `--` | End of options (prevents a `$value` starting with `-` from being read as an option) |
| `-` as body | Shares the next branch's body (`"apple" - "orange" { ... }`) |
| `default` | Catch-all branch (place last) |

## Loops (`while` & `for`)

| Loop | Syntax | Notes |
| --- | --- | --- |
| `while` | `while {$a <= 20} { puts $a; incr a }` | Condition **must** be braced `{...}` so `$a` re-evaluates each iteration |
| `for` | `for {set i 0} {$i < 10} {incr i} { puts $i }` | `{init} {test} {next} {body}` |
| `for` (empty init) | `set b 0; for {} {$b < 5} {incr b} { puts $b }` | `{}` init is valid when loop var already exists |

## Traps & Fixes (from [day-6.tcl](../day-6.tcl), [switch.tcl](../switch.tcl))

| Trap | Why | Fix |
| --- | --- | --- |
| `source hello.tcl` fails from repo root (`day-6.tcl:2`) | `hello.tcl` is not present and relative `source` checks cwd, not `Attempt 2/` | Ensure target exists and resolve via `[file dirname [info script]]` |
| Missing `--` in `switch $val {...}` | If `$val` starts with `-` (e.g. `-5`), `switch` treats it as an invalid flag | Always put `--` before `$val`: `switch -glob -- $val {...}` |
| Unbraced `while $a<=20 {...}` | `$a` substitutes once before the loop starts → infinite loop | Always brace condition: `while {$a <= 20} {...}` |
| Putting `# comment` between branches of `switch -- $x { ... }` | Inside `{...}`, `switch` parses `#` as a pattern name, not a comment | Place comments above `switch` or inside branch `{ ... }` bodies |

## Quick Recall

1. Why is `--` important in `switch -nocase -glob -- $grade { ... }`?
2. What does `-` mean between `"apple"` and `"orange"` in a `switch` block?
3. What happens if you write `while $a <= 20 { incr a }` without braces around the condition?

<details>
<summary>Answers</summary>

1. It stops option parsing so values beginning with `-` are matched as data instead of throwing an unknown-option error.
2. Fall-through / shared body: `"apple"` runs the same body block as `"orange"`.
3. `$a` is substituted once before `while` starts (and `<=` / `20` become extra args), breaking the loop; bracing `{$a <= 20}` makes `while` re-evaluate `$a` every iteration.

</details>
