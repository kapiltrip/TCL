# Day 8 — Namespaces, Ensembles & `info`

[← Attempt 2](../README.md) · [day-8.tcl](../day-8.tcl) · [← Day 7](day-7.md) · [Day 9 →](day-9.md)

## Namespace Basics & Management

Namespaces isolate procedures and variables under `::` paths (`::` is the global namespace).

| Command | Purpose | Example | Output / Effect |
| --- | --- | --- | --- |
| `namespace eval ns { ... }` | Creates/reopens `ns` and runs script inside it | `namespace eval n1 { proc print {} {...} }` | call as `n1::print` |
| Nested namespaces | `namespace eval` inside another `namespace eval` | `n1::n2::print` | child under `::n1` |
| `namespace children ?ns? ?pat?` | Lists child namespaces (supports glob) | `namespace children ::n3 *4` | `::n3::n4 ::n3::p4 ::n3::x4` |
| `namespace parent ?ns?` | Returns parent namespace | `namespace parent` inside `::n3::n4` | `::n3` |
| `namespace exists ::ns` | `1` if namespace exists, else `0` | `namespace exists ::n4` | `1` |
| `namespace delete ::ns` | Removes namespace, its children, vars, and procs | `namespace delete ::n3` | `exists` → `0` |

## Three Variable Scopes Inside a Namespace

| Scope | Declare inside `namespace eval` | Access inside a `proc` | External access |
| --- | --- | --- | --- |
| Local | *(none)* | `set localVar 10` | Not accessible outside `proc` |
| Namespace scalar | `variable var1 300` | `variable var1` then read/write `var1` | `$n4::var1` / `set n4::var1 71` |
| Namespace array | `variable arr; array set arr {}` | `variable arr` then `set arr($k) $v` | `array size n2::arr` |
| Global | `set global_var 133` (at root) | `global global_var` | `$::global_var` |

## Export, Import, Forget & Ensembles

```tcl
namespace eval mathop {
    proc add {a b} { return [expr {$a + $b}] }
    proc mul {a b} { return [expr {$a * $b}] }
    namespace export add       ;# mark add exportable (use * for all)
    namespace ensemble create  ;# enables: mathop add 3 2
}

namespace import mathop::add   ;# call directly: add 4 3 -> 7
puts [mathop add 3 2]          ;# ensemble call -> 5
namespace forget mathop::add   ;# removes imported alias 'add'
```

- Only **exported** procs are visible to `namespace import` and become subcommands of `namespace ensemble create` (`mathop mul` is not exposed unless `mul` is exported).

## Introspection (`info`)

| Command | Returns |
| --- | --- |
| `info commands mathop::*` | All commands (built-ins + procs + ensembles) matching pattern |
| `info procs mathop::*` | Only Tcl `proc` definitions matching pattern |
| `info vars mathop::*` | Variables defined in `mathop` |
| `info body mathop::add` | Source body of `mathop::add` |

## Traps & Fixes (from [day-8.tcl](../day-8.tcl))

| Trap | Why | Fix |
| --- | --- | --- |
| `set global_var = $value` (`day-8.tcl:125`) | Tcl `set` does not use `=`; calling `n5::update_global_val` throws `wrong # args` | Remove `=`: `set global_var $value` |
| `puts [n1::print]` (`day-8.tcl:31-32`) | `n1::print` already calls `puts` and returns `""`, printing an extra blank line | Call `n1::print` directly without outer `puts` |
| Forgetting `variable var1` inside a namespace `proc` | `set var1 ...` writes to a **local** var instead of `ns::var1` | Put `variable var1` at the top of every `proc` that uses it |
| `info command mathop::*` (`day-8.tcl:151`) | Prefix abbreviation of `commands` | Write full `info commands mathop::*` |

## Quick Recall

1. Inside `namespace eval n4 { variable var1 300; proc f {} { set var1 5 } }`, why doesn't `f` update `$n4::var1`?
2. Why does `mathop add 3 2` work in `day-8.tcl` while `mathop mul 3 2` fails?
3. What is wrong with `set global_var = $value` on line 125 of `day-8.tcl`?

<details>
<summary>Answers</summary>

1. `f` didn't declare `variable var1`, so `set var1 5` creates a local variable inside `f`.
2. Only `add` was listed in `namespace export add`; `namespace ensemble create` exposes only exported procs.
3. `set` takes `set varName value` with no `=`; `=` makes it 3 arguments and raises `wrong # args`.

</details>
