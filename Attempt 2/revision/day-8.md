# Day 8 — Namespaces, Ensembles & `info`

[← Attempt 2](../README.md) · [day-8.tcl](../day-8.tcl) · [← Day 7](day-7.md) · [Day 9 →](day-9.md)

## Definitions

- **Namespace**: A hierarchical container of commands and variables separated by `::`, rooted at the global namespace `::`, used to isolate modules and prevent name collisions.
- **Qualified vs Relative Name**: Fully qualified names start with `::` (`::n1::n2::print`, anchored at root); relative names (`n1::print`) resolve in the current namespace first, then global `::`.
- **Namespace Variable (`variable`)**: A persistent variable owned by a namespace (`::n4::var1`) rather than a temporary `proc` call frame. `variable v ?init?` inside `namespace eval` declares/initializes it; `variable v` inside a `proc` **links** local name `v` to the enclosing namespace's `v`.
- **Export / Import / Forget**: `namespace export` publishes a whitelist of command patterns from a namespace; `namespace import` creates forwarding aliases in the caller's namespace; `namespace forget` removes those aliases without deleting the original commands.
- **Namespace Ensemble (`namespace ensemble create`)**: Turns a namespace into a single command whose subcommands dispatch to its **exported** procs (`mathop add 3 2` → `::mathop::add 3 2`), mirroring built-ins like `string` and `array`.
- **Introspection (`info`)**: Runtime queries over interpreter state — all commands (`info commands`), scripted procs (`info procs`), variables (`info vars`), and procedure bodies (`info body`).

## Namespace Lifecycle & Inspection

| Command | Mechanism | Example | Output / Effect |
| --- | --- | --- | --- |
| `namespace eval ns { ... }` | Creates (or reopens) `ns` and runs the script inside `ns` | `namespace eval n1 { proc print {} {...} }` | call as `n1::print` |
| Nested namespaces | `namespace eval` inside another `namespace eval` | `n1::n2::print` | child under `::n1` |
| `namespace children ?ns? ?pat?` | Lists immediate child namespaces (optional glob filter) | `namespace children ::n3 *4` | `::n3::n4 ::n3::p4 ::n3::x4` |
| `namespace parent ?ns?` | Returns parent namespace of `ns` (default: current) | `namespace parent` inside `::n3::n4` | `::n3` |
| `namespace exists ::ns` | `1` if namespace exists, else `0` | `namespace exists ::n4` | `1` |
| `namespace delete ::ns` | Recursively deletes `::ns`, all child namespaces, vars, and procs | `namespace delete ::n3` | `exists` → `0` |

## Variable Resolution Inside a Namespace `proc`

When a `proc` inside `::n4` executes `set v 99`, Tcl resolves `v` strictly by declaration:

1. `variable v` present in the `proc` → binds to `::n4::v` (namespace variable).
2. `global v` present in the `proc` → binds to `::v` (global variable).
3. Neither declared → creates/modifies a **local** variable `v` in the `proc` frame, leaving `::n4::v` untouched!

| Scope | Declare in `namespace eval` | Link inside each `proc` | External access |
| --- | --- | --- | --- |
| Local | *(none)* | `set localVar 10` | Not visible outside `proc` |
| Namespace scalar | `variable var1 300` | `variable var1` | `$n4::var1` / `set n4::var1 71` |
| Namespace array | `variable arr; array set arr {}` | `variable arr` | `array size n2::arr` |
| Global | `set global_var 133` (at root) | `global global_var` | `$::global_var` |

- **Namespace arrays (`day-8.tcl:72-93`)**: `variable arr` declares the name in the namespace, and `array set arr {}` initializes it as an array; every `proc` reading or writing `arr($key)` must still declare `variable arr`.

## Export, Import, Forget & Ensembles

```tcl
namespace eval mathop {
    proc add {a b} { return [expr {$a + $b}] }
    proc mul {a b} { return [expr {$a * $b}] }
    namespace export add       ;# whitelist only 'add' (use * for all)
    namespace ensemble create  ;# creates command: mathop add 3 2
}

namespace import mathop::add   ;# brings alias 'add' into current namespace -> [add 4 3] = 7
puts [mathop add 3 2]          ;# ensemble dispatch -> 5
namespace forget mathop::add   ;# removes alias 'add' (::mathop::add still exists)
```

- Only **exported** procs can be imported or dispatched by `namespace ensemble create` (`mathop mul 3 2` fails until `mul` is also exported).

## Introspection (`info`)

| Command | Returns |
| --- | --- |
| `info commands mathop::*` | **All** callable commands (C built-ins, imported aliases, ensembles, and procs) |
| `info procs mathop::*` | **Only** scripted procedures defined with `proc` |
| `info vars mathop::*` | Variables currently defined in `mathop` |
| `info body mathop::add` | Source body string of `mathop::add` |

## Traps & Fixes (from [day-8.tcl](../day-8.tcl))

| Trap | Why | Fix |
| --- | --- | --- |
| `set global_var = $value` (`day-8.tcl:125`) | Tcl `set` has no `=`; calling `n5::update_global_val` throws `wrong # args` | Remove `=`: `set global_var $value` |
| `puts [n1::print]` (`day-8.tcl:31-32`) | `n1::print` already calls `puts` and returns `""`, so outer `puts` prints a blank line | Call `n1::print` directly without `puts` |
| Omitting `variable var1` inside a namespace `proc` | `set var1 ...` silently writes a local variable while `ns::var1` remains unchanged | Repeat `variable var1` inside every `proc` that uses it |
| `info command mathop::*` (`day-8.tcl:151`) | Prefix abbreviation of `commands` | Write full `info commands mathop::*` |

## Quick Recall

1. Inside `namespace eval ns { variable v 10; proc f {} { set v 99 } }`, what is `$ns::v` after calling `ns::f` and why?
2. What is the difference between `info commands` and `info procs`?
3. Why does `mathop add 3 2` succeed while `mathop mul 3 2` fails in `day-8.tcl`?

<details>
<summary>Answers</summary>

1. Still `10` — `f` omitted `variable v`, so `set v 99` created a local variable inside `f` instead of modifying `::ns::v`.
2. `info commands` lists all callable commands (C built-ins, ensembles, imports, and procs); `info procs` lists only procedures defined with `proc`.
3. Only `add` was listed in `namespace export add`; `namespace ensemble create` exposes only exported commands as subcommands.

</details>

## Tcl 8.6 Reference

- [namespace(n)](https://www.tcl-lang.org/man/tcl8.6/TclCmd/namespace.htm) · [variable(n)](https://www.tcl-lang.org/man/tcl8.6/TclCmd/variable.htm) · [info(n)](https://www.tcl-lang.org/man/tcl8.6/TclCmd/info.htm)
