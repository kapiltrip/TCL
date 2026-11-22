# Day 3 — Expressions, Bitwise & `format`

[← Attempt 2](../README.md) · [day-3.tcl](../day-3.tcl) · [← Day 2](day-2.md) · [Day 4 →](day-4.md)

## Definitions

- **Expression (`expr`)**: A dedicated expression evaluator invoked explicitly via `expr {...}` and implicitly for the test clause of `if`, `elseif`, `while`, and `for`.
- **Double Substitution (Why Bracing Matters)**: Without `{...}`, Tcl's main parser substitutes `$`/`[...]` *first*, and `expr` parses the resulting text a *second* time — blocking bytecode compilation, breaking on string values with spaces/operators, and allowing expression injection. Bracing `expr {$a + $b}` lets `expr` perform variable lookup once and compile to bytecode.
- **Dynamic Numeric Promotion**: Integers use arbitrary precision (bigints, Tcl 8.5+); decimals use IEEE-754 64-bit `double`. If both operands are integers, `/` performs **flooring integer division** (`5 / 2` → `2`, `-5 / 2` → `-3`, toward $-\infty$). If either operand is float, the operation promotes to float (`5.0 / 2` → `2.5`).
- **Truthiness & Short-Circuiting**: `expr` treats `0`/`false`/`no`/`off` as false and any non-zero number/`true`/`yes`/`on` as true. Relational and logical ops return canonical `1` or `0`; `&&` and `||` short-circuit left-to-right.
- **Bitwise Operators**: Act directly on two's-complement binary bits of integers (`&`, `|`, `^`, `~`, `<<`, `>>`).
- **`format` Conversion**: ANSI-C `printf`-style formatter (`%[flags][width][.prec]type`) that **returns** the formatted string (pass it to `puts` to print).

## Operators inside `expr { ... }`

| Category | Operators | Mechanism / Subtlety | Example → Result |
| --- | --- | --- | --- |
| Arithmetic | `+` `-` `*` `/` `%` `**` | `**` is right-associative exact integer power when operands are ints | `expr {3 ** 5}` → `243`; `expr {2 ** 70}` → exact 22-digit int |
| Division | `/` `%` | Flooring int division when both ints; float if either has `.` or `double()` | `expr {5 / 2}` → `2`; `expr {-5 / 2}` → `-3`; `expr {5.0 / 2}` → `2.5` |
| Relational | `==` `!=` `<` `<=` `>` `>=` | Attempts numeric compare first (e.g. `"1.0" == "1"` → `1`; octal `"010" == "8"` → `1`) | `expr {"1.0" == "1"}` → `1` |
| String equality | `eq` `ne` | Always exact string compare — no numeric/octal coercion | `expr {"1.0" eq "1"}` → `0`; `expr {"010" eq "8"}` → `0` |
| Logical | `&&` `\|\|` `!` | Short-circuit boolean evaluation → `1` or `0` | `expr {!0 && 1}` → `1` |
| Bitwise | `&` `\|` `^` `~` `<<` `>>` | Integer bit operations | `expr {12 & 123}` → `8` |

### Bit-Level Trace (`day-3.tcl:14-16`)

```text
  a =  12  ->  000001100₂
& b = 123  ->  001111011₂
-------------------------
      8    ->  000001000₂   (formatted with %09b: flag 0 = zero-pad, width 9, type b = binary)
```

## `format` Specifiers

| Specifier | Meaning | Example | Output |
| --- | --- | --- | --- |
| `%b` / `%0Nb` | Binary / zero-padded `N`-bit binary | `format %b 23` / `format %08b 23` | `10111` / `00010111` |
| `%d` / `%x` / `%X` | Signed decimal / lower hex / upper hex | `format %02X 23` | `17` |
| `%f` / `%e` / `%E` / `%g` | Fixed float / scientific (`e`/`E`) / compact float | `format %.2f 4.1` | `4.10` |
| `%c` / `%s` / `%%` | Character from integer code / string / literal `%` | `format "%s %%" 95` | `95 %` |

## Math Functions (`tcl::mathfunc`)

| Function | Return Type & Rule | Example | Output |
| --- | --- | --- | --- |
| `abs($x)` | Magnitude (preserves int/float type) | `expr {abs(-11)}` | `11` |
| `ceil($x)` / `floor($x)` | Next higher / lower whole value (returns **float**) | `expr {ceil(4.1)}` / `expr {floor(-4.7)}` | `5.0` / `-5.0` |
| `int($x)` / `round($x)` | Truncate toward `0` / nearest integer (returns **int**) | `expr {int(-4.7)}` / `expr {round(4.5)}` | `-4` / `5` |
| `log($x)` / `log10($x)` | Natural log ($\ln x$) / base-10 log ($\log_{10} x$) | `expr {log(122222)}` / `expr {log10(100)}` | `11.713594342248909` / `2.0` |
| `pow($x, $y)` | Always converts to IEEE-754 **float** | `expr {pow(8,10)}` | `1073741824.0` |

## Traps & Fixes (from [day-3.tcl](../day-3.tcl))

| Trap | Why | Fix |
| --- | --- | --- |
| `log(x)` assuming base-10 (`day-3.tcl:22`) | `log()` computes natural log ($\ln x$, base $e$) | Use `log10($x)` for base-10 |
| `pow(8,10)` vs `8 ** 10` (`day-3.tcl:24`) | `pow()` returns float (`1073741824.0`, loses integer precision past 53 bits); `**` stays exact integer (`1073741824`) | Use `**` for exact integer powers |
| `set floor_val [expr {abs ($num)}]` (`day-3.tcl:19`) | Variable named `floor_val` actually calls `abs()`, and space before `(` hurts readability | Match name to function (`abs_val` or `floor($num)`) and write `abs($num)` |
| Using `==` to compare strings | `==` coerces numeric strings (`"1.0" == "1"` and octal `"010" == "8"` both yield `1`) | Use `eq` / `ne` for string equality |

## Quick Recall

1. Why does `expr {"010" == "8"}` return `1` in Tcl 8.6 while `expr {"010" eq "8"}` returns `0`?
2. What is the difference between `expr {int(-4.7)}` and `expr {floor(-4.7)}`?
3. Why should `expr {$a + $b}` always be braced instead of `expr $a + $b`?

<details>
<summary>Answers</summary>

1. `==` coerces operands numerically and Tcl 8.6 parses leading-zero `010` as octal `8`; `eq` compares raw strings strictly.
2. `int(-4.7)` truncates toward zero → integer `-4`; `floor(-4.7)` rounds toward $-\infty$ → float `-5.0`.
3. Bracing prevents double substitution, keeps strings with spaces/operators safe, and enables Tcl bytecode compilation.

</details>

## Tcl 8.6 Reference

- [expr(n)](https://www.tcl-lang.org/man/tcl8.6/TclCmd/expr.htm) · [mathfunc(n)](https://www.tcl-lang.org/man/tcl8.6/TclCmd/mathfunc.htm) · [format(n)](https://www.tcl-lang.org/man/tcl8.6/TclCmd/format.htm)
