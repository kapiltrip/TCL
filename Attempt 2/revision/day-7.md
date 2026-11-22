# Day 7 — Procedures, Scope & `upvar`

[← Attempt 2](../README.md) · [day-7.tcl](../day-7.tcl) · [← Day 6](day-6.md) · [Day 8 →](day-8.md)

## Defining & Calling Procedures

```tcl
proc name {arg1 {arg2 defaultVal}} {
    ...
    return $result
}
```

| Feature | Rule | Example (`day-7.tcl`) | Result |
| --- | --- | --- | --- |
| Built-in vs user-defined | Predefined (`set`, `puts`, `expr`, `open`) vs `proc` | `proc greet {name} { puts "Hello $name" }` | `greet called` → `Hello called` |
| Default arguments | Wrap `{arg default}` in the arg list | `proc proc12 {{num1 0} {num2 0}} { ... }` | `proc12` → `0` |
| Explicit `return` | Exits immediately and returns value | `return $res` in `getMax` | `[getMax 12 11]` → `12` |
| Implicit return | Without `return`, returns result of the **last command** | `proc user_name {name} { puts $name; set y 6 }` | returns `6` |

## Variable Scope inside `proc`

| Mechanism | Effect | Example |
| --- | --- | --- |
| Default (local) | Variables live only inside that `proc` call; cannot see or mutate globals | `proc proc14 {name} { set x $name }` — caller's `x` untouched |
| `global x` | Links local name `x` to global `::x` (creates `::x` on write if unset) | `proc proc15 {name} { global x; set x $name }` → `$x` becomes `hello` globally |

## Pass-by-Value vs Pass-by-Reference (`upvar`)

| Style | Caller passes | Inside `proc` | Effect on caller variable |
| --- | --- | --- | --- |
| Pass-by-value | `$x` (value) | `proc proc1 {var} { incr var; return $var }` | Caller's `x` stays `10`; proc returns `11` |
| Pass-by-reference | `h` (**name**, no `$`) | `proc proc2 {out_var} { upvar $out_var lo_var; incr lo_var; return $lo_var }` | Caller's `h` mutates `12` → `13`; proc returns `13` |

- `upvar ?level? callerVar localVar`: default `level` is `1` (direct caller's stack frame); `lo_var` becomes an alias to the variable named in `$out_var`.

## Traps & Fixes (from [day-7.tcl](../day-7.tcl))

| Trap | Why | Fix |
| --- | --- | --- |
| `return [expr $x + 3]` (`day-7.tcl:30`) | Unbraced `expr` performs double substitution | Always brace: `return [expr {$x + 3}]` |
| Calling `proc2 $h` instead of `proc2 h` | Passes `12` as the variable name, creating/mutating a variable literally named `12` in caller scope | Pass variable name without `$`: `proc2 h` |
| Forgetting `global x` before reading/writing a global | Silently creates a separate local `x` (or errors on read) | Declare `global x` at the top of the `proc` |

## Quick Recall

1. What does `proc f {} { set y 6 }` return when called, even with no `return` statement?
2. Why does `proc2` take `h` (no `$`) while `proc1` takes `$x`?
3. What is the default stack level of `upvar $out_var lo_var`?

<details>
<summary>Answers</summary>

1. `6` — the return value of its last executed command (`set y 6`).
2. `proc2` uses `upvar`, which binds to the caller's variable by **name** (`h`), whereas `proc1` only needs the **value** (`$x`).
3. Level `1` (the immediate caller's frame).

</details>
