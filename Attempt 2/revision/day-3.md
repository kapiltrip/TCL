# Day 3 — Expressions, Bitwise & `format`

[← Attempt 2](../README.md) · [day-3.tcl](../day-3.tcl) · [← Day 2](day-2.md) · [Day 4 →](day-4.md)

## Core Rule

Always brace expressions: `expr {$a + $b}`. Braces let `expr` evaluate safely in one pass (faster and avoids double-substitution bugs).

## Operators inside `expr { ... }`

| Category | Operators | Example | Result |
| --- | --- | --- | --- |
| Arithmetic | `+` `-` `*` `/` `%` `**` (power) | `expr {3 + 5}` / `expr {3 ** 5}` | `8` / `243` |
| Division | Both ints → integer division; one float → float | `expr {5 / 2}` vs `expr {5.0 / 2}` | `2` vs `2.5` |
| Relational | `==` `!=` `<` `<=` `>` `>=` (numeric; use `eq`/`ne` for strings) | `expr {3 < 5}` | `1` |
| Logical | `&&` `\|\|` `!` | `expr {!0 && 1}` | `1` |
| Bitwise | `&` `\|` `^` `~` `<<` `>>` | `expr {12 & 123}` (`000001100 & 001111011`) | `8` (`000001000`) |

## `format` Specifiers

| Specifier | Meaning | Example | Output |
| --- | --- | --- | --- |
| `%b` | Binary | `format %b 23` | `10111` |
| `%0Nb` | Zero-padded `N`-bit binary | `format %08b 23` / `format %09b [expr {12 & 123}]` | `00010111` / `000001000` |
| `%d` / `%x` / `%X` | Decimal / lower hex / upper hex | `format %02X 23` | `17` |
| `%f` / `%e` / `%E` / `%g` | Fixed float / scientific (`e`/`E`) / compact float | `format %.2f 4.1` | `4.10` |
| `%c` / `%s` / `%%` | ASCII char / string / literal `%` | `format "%s %%" 95` | `95 %` |

## Math Functions inside `expr { ... }`

| Function | Meaning | Example | Output |
| --- | --- | --- | --- |
| `abs($x)` | Absolute value | `expr {abs(-11)}` | `11` |
| `ceil($x)` / `floor($x)` | Round up / round down (returns float) | `expr {ceil(4.1)}` | `5.0` |
| `log($x)` | **Natural** log ($\ln x$) | `expr {log(122222)}` | `11.713594342248909` |
| `log10($x)` | Base-10 log ($\log_{10} x$) | `expr {log10(100)}` | `2.0` |
| `pow($x, $y)` | Power (always returns float) | `expr {pow(8,10)}` | `1073741824.0` |

## Traps & Fixes (from [day-3.tcl](../day-3.tcl))

| Trap | Why | Fix |
| --- | --- | --- |
| `log(x)` thinking base-10 (`day-3.tcl:22`) | `log()` is natural log ($\ln$) | Use `log10($x)` for base-10 |
| `pow(8,10)` vs `8 ** 10` (`day-3.tcl:24`) | `pow()` always returns a float (`1073741824.0`); `**` preserves exact integers (`1073741824`) | Use `**` for exact integer powers |
| `set floor_val [expr {abs ($num)}]` (`day-3.tcl:19`) | Variable named `floor_val` actually calls `abs()`, and space before `(` hurts readability | Match name to op (`abs_val` / `floor($num)`) and write `abs($num)` |
| `expr $a + $b` without `{}` | Double substitution; slower and breaks on strings/special chars | Always brace: `expr {$a + $b}` |

## Quick Recall

1. What is the difference between `expr {8 ** 10}` and `expr {pow(8,10)}`?
2. What does `format %08b [expr {12 & 123}]` print?
3. What does `expr {log(100)}` vs `expr {log10(100)}` return?

<details>
<summary>Answers</summary>

1. `8 ** 10` returns exact integer `1073741824`; `pow(8,10)` returns float `1073741824.0`.
2. `00001000` (decimal `8` zero-padded to 8 bits).
3. `log(100)` ≈ `4.60517` ($\ln 100$); `log10(100)` = `2.0`.

</details>
