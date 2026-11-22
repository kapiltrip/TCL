# Day 2 — Grouping & String Operations

[← Attempt 2](../README.md) · [day-2.tcl](../day-2.tcl) · [← Day 1](day-1.md) · [Day 3 →](day-3.md)

## Grouping: `""` vs `{}`

Spaces separate command arguments; group multi-word strings with quotes or braces.

| Syntax | Substitution (`$`, `[...]`, `\`) | Example | Output |
| --- | --- | --- | --- |
| `"..."` | **Allowed** | `puts "val is $var1"` | `val is 12` |
| `{...}` | **Blocked** (literal text) | `puts {val is $var1}` | `val is $var1` |
| Escaped quotes | Inside `"..."` use `\"`; inside `{...}` quotes are literal | `puts "\"How are u\""` / `puts {"how are u"}` | `"How are u"` / `"how are u"` |
| Multiline | Literal newlines preserved inside `"..."` or `{...}` | `set s "line1\nline2"` | keeps line breaks |

## Inspection, Indexing & Search

| Command | Returns | Example | Output |
| --- | --- | --- | --- |
| `string is <class> ?-strict? $s` | `1` or `0` (`digit`, `integer`, `upper`, `lower`, `boolean`) | `string is lower adB` | `0` |
| `string length $s` | Character count (includes spaces & newlines) | `string length "hello world "` | `12` |
| `string index $s idx` | Single char at `0`-based `idx`, `end`, `end-1`, `end-2` | `string index Hello end` | `o` |
| `string first $sub $s ?start?` | First match index, or `-1` | `string first l Hello 3` | `3` |
| `string last $sub $s ?last?` | Last match index, or `-1` | `string last l Hello` | `3` |

## Pattern Matching & Comparison

| Command | Rules | Example | Output |
| --- | --- | --- | --- |
| `string match ?-nocase? $pat $s` | Glob match (`*` = 0+ chars incl. spaces, `?` = 1 char) → `1`/`0` | `string match -nocase test "TeSt"` | `1` |
| `string match` wildcards | Exact boundary unless `*` used | `string match *test* "andtestor "` / `string match t?st "tast"` | `1` / `1` |
| `string compare ?-nocase? ?-length n? $a $b` | ASCII order: `-1` (`a < b`), `0` (equal), `1` (`a > b`); `'A'`(65) `<` `'a'`(97) | `string compare Abc abc` / `string compare Ghi7 Ghi6` | `-1` / `1` |
| `string equal ?-nocase? ?-length n? $a $b` | `1` if equal, `0` otherwise | `string equal -nocase -length 4 Hello Helle` | `1` |

## Non-Mutating Transforms

Every `string` transform returns a **new string**; the original variable does not change unless reassigned.

| Command | Behavior | Example | Output |
| --- | --- | --- | --- |
| `string map {k1 v1 k2 v2} $s` | Replaces key→value pairs in a single pass | `string map {"~" " " "!" "."} "Hello~World~!"` | `Hello World .` |
| `string trim $s ?chars?` | Strips leading & trailing whitespace (or `chars`) | `string trim "  Hello world  1"` | `Hello world  1` |
| `string tolower $s` | Lowercases letters only (digits/spaces unchanged) | `string tolower "  Hello world  1"` | `  hello world  1` |
| `string toupper $s` | Uppercases letters only | `string toupper "  Hello world  1"` | `  HELLO WORLD  1` |

## Traps & Fixes (from [day-2.tcl](../day-2.tcl))

| Trap | Why | Fix |
| --- | --- | --- |
| `end -1` with a space (`day-2.tcl:31` comment) | Tcl reads `end` and `-1` as two separate arguments | Write `end-1` with **no space** |
| `string is digit ""` | Without `-strict`, empty string `""` returns `1` for every class | Use `string is digit -strict $s` |
| Assuming `string map` / `string trim` updates `$var1` | All `string` ops are pure; `$var1` stays unchanged (`day-2.tcl:70-71, 79-80`) | Assign back: `set var1 [string trim $var1]` |
| `string trim "  Hello world  1"` | Trailing `1` blocks trimming the inner spaces before `1` | `trim` stops at the first non-trimmed character from either end |

## Quick Recall

1. Why does `string compare bAc bac` return `-1`?
2. What does `string is integer ""` return vs `string is integer -strict ""`?
3. What is the value of `$s` after `set s hello; string map {h k} $s`?

<details>
<summary>Answers</summary>

1. At index 1, ASCII `'A'` (65) < `'a'` (97), so `bAc` sorts before `bac` (`-1`).
2. `1` without `-strict`, `0` with `-strict`.
3. Still `hello` — `string map` returns `kello` without modifying `s`.

</details>
