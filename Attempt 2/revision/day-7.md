# Day 7 — Procedures, Scope & `upvar`

[← Attempt 2](../README.md) · [day-7.tcl](../day-7.tcl) · [← Day 6](day-6.md) · [Day 8 →](day-8.md)

## Definitions

- **Procedure (`proc`)**: A user-defined Tcl command (`proc name argList body`) created in the current namespace. Each call pushes a fresh **local call frame** onto the stack, binds arguments to local parameters, executes `body`, pops the frame, and returns either the `return` value or the result of the last executed command.
- **Built-in Command vs `proc`**: Built-ins (`set`, `puts`, `expr`, `open`) are implemented in C inside `tclsh`; `proc` creates scripted commands invoked with the exact same syntax.
- **Default Argument (`{param default}`)**: Makes a parameter optional; if the caller omits it, Tcl binds `param` to `default`.
- **Call Frame & Scope Isolation**: Every `proc` invocation has its own isolated local variable table. Code inside a `proc` cannot see global variables or the caller's locals unless explicitly linked (`global`, `variable`, or `upvar`).
- **Pass-by-Value**: Passing `$x` evaluates `x` in the caller and hands its string value to the callee's local parameter; modifying that parameter changes only the local copy.
- **Pass-by-Reference (`upvar`)**: Passing a variable **name** (no `$`) and linking a local alias via `upvar ?level? otherVar localVar`. Both names point to the **same variable slot** in the target stack frame (`level` defaults to `1` = direct caller; `#0` = global frame).

## Defining & Returning From Procedures

```tcl
proc name {arg1 {arg2 defaultVal}} {
    ...
    return $result
}
```

| Feature | Mechanism | Example (`day-7.tcl`) | Result |
| --- | --- | --- | --- |
| Basic `proc` | Parameters become local vars for that call | `proc greet {name} { puts "Hello procedure $name " }` | `greet called` → prints greeting |
| Default arguments | Trailing `{arg val}` pairs fill in omitted args | `proc proc12 {{num1 0} {num2 0}} { ... }` | `proc12` uses `0`, `0` → `0` |
| Explicit `return` | Unwinds current call frame immediately with `$val` | `return $res` in `getMax` | `[getMax 12 11]` → `12` |
| Implicit return | If no `return` runs, returns the value of the **last command** | `proc user_name {name} { puts $name; set y 6 }` | returns `6` |

## Scope Mechanics: Local vs `global` vs `upvar`

| Mechanism | Target Frame | Mechanism |
| --- | --- | --- |
| Plain `set x ...` | Current `proc` frame | Creates/updates a local `x`; discarded when `proc` returns (`proc14`) |
| `global x` | Global frame `#0` (`::x`) | Equivalent to `upvar #0 x x`; links local `x` to `::x` (first write creates `::x` if unset, as in `proc15`) |
| `upvar ?lvl? $name alias` | Caller (`lvl = 1` default) or absolute (`#0`, `#1`) | Makes `alias` point to the exact variable named `$name` in target frame (`proc2`) |

### Stack-Frame Trace: Pass-by-Value vs Pass-by-Reference (`day-7.tcl:49-68`)

```text
Global frame (#0):   x = 10,  h = 12

1) proc1 $x          -> caller evaluates $x -> passes "10"
   proc1 frame (#1): var = 10 -> incr var -> var = 11 -> returns 11 (frame #1 destroyed)
   Global frame (#0): x is STILL 10

2) proc2 h           -> caller passes literal variable name "h"
   proc2 frame (#1): out_var = "h"
                     upvar 1 h lo_var   (lo_var aliases frame #0's h)
                     incr lo_var        (mutates frame #0's h: 12 -> 13)
                     returns 13         (frame #1 destroyed)
   Global frame (#0): h is NOW 13
```

## Traps & Fixes (from [day-7.tcl](../day-7.tcl))

| Trap | Why | Fix |
| --- | --- | --- |
| `return [expr $x + 3]` (`day-7.tcl:30`) | Unbraced `expr` triggers double substitution and disables bytecode compilation | Always brace: `return [expr {$x + 3}]` |
| Calling `proc2 $h` instead of `proc2 h` | Passes `"12"` as the variable name; `upvar` creates/mutates a caller variable literally named `12`, leaving `h` untouched | Pass the variable **name** without `$`: `proc2 h` |
| Reading/writing a global without `global x` | Reading errors (`no such variable`); writing silently creates a separate local `x` | Declare `global x` at the top of the `proc` |

## Quick Recall

1. What does `global x` do internally in terms of `upvar`?
2. What happens if you call `proc2 $h` (with `$`) when `$h` is `12`?
3. Why does `proc user_name {name} { puts $name; set y 6 }` return `6` even without `return`?

<details>
<summary>Answers</summary>

1. `global x` is equivalent to `upvar #0 x x`, aliasing local `x` directly to `::x` in the global frame `#0`.
2. `$h` substitutes to `12`, so `upvar` binds `lo_var` to a variable literally named `12` in the caller instead of `h`.
3. When a `proc` finishes without an explicit `return`, Tcl returns the result of its last executed command (`set y 6` returns `6`).

</details>

## Tcl 8.6 Reference

- [proc(n)](https://www.tcl-lang.org/man/tcl8.6/TclCmd/proc.htm) · [return(n)](https://www.tcl-lang.org/man/tcl8.6/TclCmd/return.htm) · [global(n)](https://www.tcl-lang.org/man/tcl8.6/TclCmd/global.htm) · [upvar(n)](https://www.tcl-lang.org/man/tcl8.6/TclCmd/upvar.htm)
