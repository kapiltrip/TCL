# Day 4 — Lists, `foreach`, `split`, `regexp` & `regsub`

[← Attempt 2](../README.md) · [day-4.tcl](../day-4.tcl) · [← Day 3](day-3.md) · [Day 5 →](day-5.md)

## Lists: Create, Nest vs Flatten

| Command | Behavior | Example | Output |
| --- | --- | --- | --- |
| `{a b c}` | Literal list (no `$` substitution) | `set lista {1 2 3}` | `1 2 3` |
| `list a b ...` | Builds list with substitution; preserves element boundaries | `list $lista $listb` | `{1 2 3} {{element a } {element b }}` (length 2) |
| `concat $a $b` | Flattens 1 level into a single list | `concat $lista $listb` | `1 2 3 {element a } {element b }` (length 5) |
| `lrepeat n e ...` | Repeats element sequence `n` times | `lrepeat 3 a b c` | `a b c a b c a b c` |

## Lists: Inspect, Slice, Mutate vs Pure

| Command | Passes | Mutates original? | Returns | Example → Result |
| --- | --- | --- | --- | --- |
| `llength $lst` | `$value` | No | Top-level count | `llength {{1 2 2} 4 6 8}` → `4` |
| `lindex $lst i ?j?` | `$value` | No | Element (supports `{0 1}` nested path) | `lindex {{1 2 2} 4} 0 1` → `2` |
| `lrange $lst i j` | `$value` | No | Inclusive sublist | `lrange {a b c d e} 0 3` → `a b c d` |
| `lassign $lst v1 v2` | `$value` | **No** | Leftover elements | `lassign {a b c d e} x` → `x`=`a`, returns `b c d e` |
| `lappend var v ...` | **name** (no `$`) | **Yes** | Updated list | `lappend listm f g h` → mutates `listm` |
| `lset var i ?j? val` | **name** (no `$`) | **Yes** | Updated list | `lset lst 0 1` → replaces index `0` in place |
| `linsert $lst i v ...` | `$value` | **No** | New list | `linsert $lst 1 12` |
| `lreplace $lst i j ?v?` | `$value` | **No** | New list (omit `v` to delete `i..j`) | `lreplace $lst 0 1 r e` |

## Lists: Search, Sort & Membership

| Command | Notes | Example → Output |
| --- | --- | --- |
| `lsearch ?opts? $lst $pat` | Default `-glob`; `-exact`, `-all`, `-inline`, `-nocase`; `-1` if absent | `lsearch -all -glob {abc ade afg aty} a*` → `0 1 2 3` |
| `lsort ?opts? $lst` | `-ascii` (default), `-integer`, `-real`, `-increasing` (default), `-decreasing`, `-unique` | `lsort -integer -decreasing {33 2324 12 1 0}` → `2324 33 12 1 0` |
| `expr {$x in $lst}` / `ni` | Membership (`1`/`0`): `in` = present, `ni` = not in | `expr {"a" in {a b c d}}` → `1` |

## `foreach` & `split`

```tcl
# Stride 2 over one list (trailing unmatched var becomes "")
foreach {j k} $listb { puts "$j $k" }

# Parallel iteration over two lists (shorter list pads with "")
foreach i $lista j $listb { puts "$i $j" }
```

- `split $str ?splitChars?` splits on **every individual character** in `splitChars` (not as a multi-char delimiter!), keeping empty `{}` elements between adjacent delimiters:
  - `split "Hello" e` → `H llo` (length `2`)
  - `split "abcdabcdabab " "ab"` → `{} {} cd {} cd {} {} {} { }`

## `regexp` & `regsub`

```tcl
regexp ?switches? pattern string ?fullMatch? ?sub1 sub2 ...?
regsub ?-all? ?-nocase? pattern string subSpec ?outVar?
```

| Switch / Form | Behavior |
| --- | --- |
| `-all` | Matches every occurrence; returns total count (with `matchVar`, stores only the **last** match) |
| `-inline` | Returns list of matches instead of count (**cannot** be combined with `matchVar`) |
| `-indices` | Returns `{start end}` index pairs instead of matched substrings |
| `-nocase` | Case-insensitive matching |
| `regsub ... outVar` | Writes replaced text to `outVar` and returns **replacement count** |
| `regsub ...` (no `outVar`) | Returns the **replaced string** directly (original var unchanged) |

### Regex Tokens Practiced

| Token | Meaning | Example (`-all -inline`) → Output |
| --- | --- | --- |
| `[hel]` | Any **one** char from set `h`, `e`, `l` | `[hel]` on `"hello"` → `h e l l` |
| `hel\|lo` | Alternation (`hel` or `lo`) | `hel\|lo` on `"hello"` → `hel lo` |
| `.` / `\.` | Any single char / literal dot (escape `[` as `\[`) | `h.` on `"hello"` → `he` |
| `*` / `+` / `?` | `0+` / `1+` / **`0` or `1`** of preceding element | `h?l` on `"hlolo"` → `hl l`; `hl+` on `"hlolohl"` → `hl hl` |
| `{n}` `{n,}` `{n,m}` | Exact / at-least / bounded count | `l{2,}` on `"ohelllllo"` → `lllll` |
| `^` / `$` | Start / end of string | `^hel` on `"helloo"` → `hel`; `o$` on `"hello"` → `o` |
| `\d` `\w` `\s` | Digit / word char (`A-Za-z0-9_`) / whitespace | `\d+` on `"123"` → `123` |
| `(...)` | Capturing group (use `(?:...)` to group without capturing) | `\[(\d+):(\d+)\]\s(\w+)` on `"[7:0] data_in"` → full + `7` + `0` + `data_in` |

## Traps & Fixes (from [day-4.tcl](../day-4.tcl))

| Trap | Why | Fix |
| --- | --- | --- |
| `regexp -all {\[(\d+):(\d+)\]\s(\w+)} $input match size port` (`day-4.tcl:161`) | Pattern has **3** capture groups, so `size`=`7`, `port`=`0`, and `data_in` is dropped! | Pass 3 group vars (`match msb lsb port`) or use non-capturing `(?:\d+)` |
| `foreach i $listc` on `-inline` with a capture group (`day-4.tcl:193-197`) | `-inline` flattens `{full1 group1 full2 group2 ...}` into one list | Iterate in pairs: `foreach {full port} $listc { puts $port }` |
| Comment `#? 0 or more` (`day-4.tcl:143`) | `?` means **0 or 1** (optional), NOT 0 or more (`*` is 0 or more) | `*` = 0+, `+` = 1+, `?` = 0 or 1 |
| `lassign` thought to mutate `$listm` (`day-4.tcl:47-51`) | `lassign` leaves `$listm` intact and only returns leftovers | Reassign if consuming: `set listm [lassign $listm x y]` |
| `lappend $listm ...` | Passing `$listm` modifies a variable named after the *contents* of `listm` | Always pass variable name without `$`: `lappend listm f g h` |

## Quick Recall

1. What is the difference between `[list $a $b]` and `[concat $a $b]`?
2. Why does `regexp -all {\[(\d+):(\d+)\]\s(\w+)} {[7:0] data_in} match size port` set `port` to `0`?
3. What does `regsub -all hello $s tcl` return vs `regsub -all hello $s tcl out`?

<details>
<summary>Answers</summary>

1. `list` nests `$a` and `$b` as 2 elements; `concat` flattens them one level into a single combined list.
2. There are 3 capture groups: group 1 = `7` (`size`), group 2 = `0` (`port`), group 3 = `data_in` (unassigned).
3. Without `out`, returns the modified string; with `out`, writes the modified string to `out` and returns the substitution count.

</details>
