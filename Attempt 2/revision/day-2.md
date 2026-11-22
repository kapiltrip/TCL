# Day 2 — Grouping & String Operations

[← Attempt 2](../README.md) · [day-2.tcl](../day-2.tcl) · [← Day 1](day-1.md) · [Day 3 →](day-3.md)

## Definitions

- **Grouping**: Wrapping whitespace-separated characters into a single command word. Double quotes `"..."` group while **allowing** `$`, `[...]`, and `\` substitution; braces `{...}` group while **blocking all** substitution (except `\<newline>` line continuation).
- **String**: An immutable, `0`-indexed sequence of Unicode characters (`0` through `length - 1`). Every `string` operation returns a new value and never mutates the source variable in place.
- **Character Class (`string is`)**: A predicate verifying that every character in a string belongs to a class (`digit`, `integer`, `upper`, `lower`, `boolean`, etc.). Vacuously `1` on `""` unless `-strict` is given.
- **Glob Pattern (`string match`)**: Wildcard matching (`*` = 0+ chars incl. spaces, `?` = any 1 char, `[abc]` = char set, `\` = escape) that must match the **entire** string from start to end (unlike `regexp`, which searches substrings).
- **Lexicographic Comparison (`string compare`)**: Code-point-by-code-point comparison (ASCII: `'0'`=48 < `'A'`=65 < `'a'`=97), stopping at the first differing character. If one string is a prefix of the other, the shorter string is smaller.
- **Single-Pass Mapping (`string map`)**: Simultaneous left-to-right key→value replacement where newly inserted replacement text is **never** re-scanned by remaining pairs (so `string map {a ab} a` yields `ab`, not an infinite loop).

## Grouping Rules (`""` vs `{}`)

| Form | Substitution | Nested quotes | Example | Output |
| --- | --- | --- | --- | --- |
| `"..."` | `$`, `[...]`, `\` active | Must escape as `\"` | `puts "\"How are u \""` | `"How are u "` |
| `{...}` | Blocked (literal) | Literal `"` allowed; nested `{}` must balance | `puts {val is $var1}` | `val is $var1` |
| Multiline `"..."` / `{...}` | Same as above | Literal newlines kept as part of the string | `day-2.tcl:13-17` | 4-line string + trailing `\n` |

## Inspection, Indexing & Search

| Command | Mechanism & Return | Example | Output |
| --- | --- | --- | --- |
| `string is <class> ?-strict? $s` | `1` if all chars match class (`digit`, `integer`, `upper`, `lower`, `boolean`), else `0` | `string is lower adB` / `string is digit -strict ""` | `0` / `0` |
| `string length $s` | Total character count (spaces & `\n` included) | `string length "hello world "` | `12` |
| `string index $s idx` | Char at `idx` (`0`, `end`, `end-1`, `end-N`, `M+N`, no spaces); `""` if out of range | `string index Hello end-1` | `l` |
| `string first $sub $s ?start?` | First index of literal `$sub` at or after `start`, or `-1` | `string first l Hello 3` | `3` |
| `string last $sub $s ?last?` | Last index of literal `$sub` at or before `last`, or `-1` | `string last l Hello` | `3` |

## Pattern Matching & Comparison

| Command | Mechanism | Example | Output |
| --- | --- | --- | --- |
| `string match ?-nocase? $pat $s` | Whole-string glob match → `1`/`0` | `string match test Notest` vs `string match *test Notest` | `0` vs `1` |
| `string match` wildcards | `*` spans spaces too; `?` matches exactly 1 char | `string match *test* "andtestor "` / `string match t?st "tast"` | `1` / `1` |
| `string compare ?-nocase? ?-length n? $a $b` | Returns `-1` (`a < b`), `0` (`a == b`), `1` (`a > b`) | `string compare Abc abc` / `string compare Ghi7 Ghi6` | `-1` / `1` |
| `string equal ?-nocase? ?-length n? $a $b` | Boolean equality (`1`/`0`), cleaner than `compare == 0` | `string equal -nocase -length 4 Hello Helle` | `1` |

### Why `string compare` Produced Those Outputs (`day-2.tcl:56-62`)

- `Abc` vs `abc`: index `0` compares `'A'` (65) < `'a'` (97) → `-1`.
- `bAc` vs `bac`: index `0` matches (`'b'`), index `1` compares `'A'` (65) < `'a'` (97) → `-1`.
- `Ghi7` vs `Ghi6`: indices `0..2` match, index `3` compares `'7'` (55) > `'6'` (54) → `1`.

## Non-Mutating Transforms

| Command | Mechanism | Example | Output |
| --- | --- | --- | --- |
| `string map ?-nocase? {k1 v1 ...} $s` | Single-pass longest/first-listed key replacement | `string map {"~" " " "!" "."} "Hello~World~!"` | `Hello World .` |
| `string trim $s ?chars?` | Peels matching chars from **both ends inward** until hitting a non-matching char (`trimleft`/`trimright` for one side) | `string trim "  Hello world  1"` | `Hello world  1` |
| `string tolower $s` / `toupper $s` | Converts alphabetic chars only; digits, spaces, punctuation stay unchanged | `string toupper "  Hello world  1"` | `  HELLO WORLD  1` |

## Traps & Fixes (from [day-2.tcl](../day-2.tcl))

| Trap | Why | Fix |
| --- | --- | --- |
| `end -1` with a space (`day-2.tcl:31` comment) | Space splits `end` and `-1` into two separate arguments to `string index` | Write `end-1` with **no space** |
| `string is digit ""` without `-strict` | Empty string has zero failing characters, so `string is` returns `1` | Add `-strict`: `string is digit -strict $s` |
| Expecting `string map` / `string trim` to mutate `$var1` (`day-2.tcl:70-71, 79-80`) | Strings are immutable; commands return a new string | Reassign: `set var1 [string trim $var1]` |
| Expecting `string trim "  Hello world  1"` to remove spaces before `1` | `trim` stops at the first non-whitespace char from the right (`1`) | Only outer ends are trimmed; use `string map` or `regsub` for inner spaces |

## Quick Recall

1. Why does `string match test "Notest"` return `0` while `string match *test "Notest"` returns `1`?
2. Why does `string compare bAc bac` return `-1`?
3. What does `string map {a ab} a` return, and why doesn't it loop forever?

<details>
<summary>Answers</summary>

1. `string match` anchors its glob pattern to the entire string; `*` is required to absorb the leading `"No"`.
2. At index 1, ASCII `'A'` (65) < `'a'` (97), so `bAc` sorts before `bac`.
3. `ab` — `string map` makes a single left-to-right pass and never re-processes already-substituted output.

</details>

## Tcl 8.6 Reference

- [string(n)](https://www.tcl-lang.org/man/tcl8.6/TclCmd/string.htm) · [Tcl(n) — quotes & braces](https://www.tcl-lang.org/man/tcl8.6/TclCmd/Tcl.htm)
