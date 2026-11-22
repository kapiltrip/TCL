# Day 4 — Lists, `foreach`, `split`, `regexp` & `regsub`

[← Attempt 2](../README.md) · [day-4.tcl](../day-4.tcl) · [← Day 3](day-3.md) · [Day 5 →](day-5.md)

## Definitions

- **List**: An ordered sequence of elements stored in canonical string representation, using whitespace to separate elements and `{...}` or `\` quoting to protect spaces, empty elements (`{}`), and nested sublists.
- **`list` vs `concat`**: `list` preserves every argument as **one element** (nesting sublists); `concat` strips outer whitespace and joins arguments at the **top level** (flattening one level).
- **Pure vs In-Place List Commands**: Pure commands (`llength`, `lindex`, `lrange`, `lassign`, `linsert`, `lreplace`, `lsearch`, `lsort`) accept a list **value** (`$lst`) and return a result without modifying the variable. Mutating commands (`lappend`, `lset`) accept a variable **name** (`lst`, no `$`) and update the variable in place.
- **`foreach`**: Iterates over one or more lists in lockstep; each variable-list consumes `k` elements per step and assigns `""` when a shorter list runs out.
- **`split`**: Divides a string at **each individual character** listed in `splitChars` (not as a multi-character substring). Adjacent delimiters produce empty `{}` elements rather than collapsing.
- **Regular Expression (ARE)**: Tcl implements Advanced Regular Expressions (`regexp`, `regsub`). Unlike `string match`, `regexp` searches **anywhere** inside the target string unless anchored (`^`, `$`).
- **Capturing Group (`(...)`)**: Subpattern whose matched slice is extracted in left-to-right opening-parenthesis order (index `0` = full match, `1..N` = parenthesized groups). Use `(?:...)` to group without capturing.

## Lists: Construction, Nesting vs Flattening

```text
lista = {1 2 3}                        (length 3)
listb = {{element a } {element b }}    (length 2)

list   $lista $listb  ->  {1 2 3} {{element a } {element b }}   (length 2: nested)
concat $lista $listb  ->  1 2 3 {element a } {element b }       (length 5: flattened 1 level)
```

| Command | Behavior | Example → Output |
| --- | --- | --- |
| `{1 2 3}` | Literal list (blocks `$` inside) | `set lista {1 2 3}` → `1 2 3` |
| `list a b ...` | Evaluates `$`/`[...]` and quotes elements safely | `list $lista $listb` → length `2` |
| `concat $a $b` | Flattens 1 level into a single list | `concat $hr_list $sw_list $hw_list` → `101 201 301` |
| `lrepeat n e ...` | Repeats sequence `e ...` `n` times (flat) | `lrepeat 3 a b c` → `a b c a b c a b c` |

## Lists: Inspect, Slice, Mutate vs Pure

| Command | Passes | Mutates? | Returns | Example → Result |
| --- | --- | --- | --- | --- |
| `llength $lst` | `$value` | No | Top-level count only | `llength {{1 2 2} 4 6 8}` → `4` |
| `lindex $lst i ?j?` | `$value` | No | Element (`{0 1}` drills into nested lists) | `lindex {{1 2 2} 4} 0 1` → `2` |
| `lrange $lst i j` | `$value` | No | Inclusive sublist (`end` allowed) | `lrange {a b c d e} 0 3` → `a b c d` |
| `lassign $lst v1 v2` | `$value` | **No** | Unassigned leftover elements | `lassign {a b c d e} x` → `x`=`a`, returns `b c d e` |
| `lappend var v ...` | **name** (no `$`) | **Yes** | Updated list (auto-creates `var` if unset) | `lappend listm f g h` |
| `lset var i ?j? val` | **name** (no `$`) | **Yes** | Updated list (supports nested index path) | `lset lst 0 1` |
| `linsert $lst i v ...` | `$value` | **No** | New list with `v...` inserted before `i` | `linsert $lst 1 12` |
| `lreplace $lst i j ?v?` | `$value` | **No** | New list (omit `v` to delete `i..j`) | `lreplace $lst 0 1 r e` |

## Lists: Search, Sort & Membership

| Command | Mechanism & Flags | Example → Output |
| --- | --- | --- |
| `lsearch ?opts? $lst $pat` | Default `-glob`! Flags: `-exact`, `-all`, `-inline`, `-nocase`; `-1` on miss | `lsearch -all -glob {abc ade afg aty} a*` → `0 1 2 3` |
| `lsort ?opts? $lst` | Pure sort: `-ascii` (default), `-integer`, `-real`, `-increasing` (default), `-decreasing`, `-unique` | `lsort -integer -decreasing {33 2324 12 1 0}` → `2324 33 12 1 0` |
| `expr {$x in $lst}` / `ni` | Exact element membership (`1`/`0`) | `expr {"a" in {a b c d}}` → `1`; `ni` → `0` |

## `foreach` & `split` Mechanics

```tcl
# Stride 2 over one list (trailing unmatched var k receives "")
foreach {j k} $listb { puts "$j $k" }

# Parallel iteration over two lists (shorter list pads with "")
foreach i $lista j $listb { puts "$i $j" }
```

### Cut-Point Trace for `split "abcdabcdabab " "ab"` (`day-4.tcl:114-115`)

`split` treats `"ab"` as the **set** `{'a', 'b'}`, cutting at every `'a'` and every `'b'`:

```text
String:    a   b   cd   a   b   cd   a   b   a   b   " "
Cuts:   {} | {} | cd | {} | cd | {} | {} | {} | { }
Result: {} {} cd {} cd {} {} {} { }   (9 elements)
```

## `regexp` & `regsub`

```tcl
regexp ?switches? pattern string ?fullMatch? ?sub1 sub2 ...?
regsub ?-all? ?-nocase? pattern string subSpec ?outVar?
```

- **Always brace `{pattern}`**: without braces, Tcl's parser eats `\d`, `\[`, and `$` before `regexp` ever sees them.

| Switch / Form | Mechanism |
| --- | --- |
| `-all` | Finds every non-overlapping match; returns total match count. With `matchVar`, `matchVar` keeps only the **last** match (`day-4.tcl:127-128` → `o`). |
| `-inline` | Returns a list of matches instead of a count; **cannot** be used together with `matchVar`. |
| `-indices` | Returns `{start end}` index pairs (`0`-based, inclusive) instead of substrings. |
| `-nocase` | Case-insensitive match. |
| `regsub ... outVar` | Writes modified text to `outVar` and returns the **replacement count**. |
| `regsub ...` (no `outVar`) | Returns the **modified string** directly (source variable untouched). |

### Regex Tokens & Zero-Length Match Behavior

| Token | Meaning | Example (`-all -inline`) → Output |
| --- | --- | --- |
| `[hel]` | Any **one** char from `{h, e, l}` | `[hel]` on `"hello"` → `h e l l` |
| `hel\|lo` | Alternation (`hel` or `lo`) | `hel\|lo` on `"hello"` → `hel lo` |
| `.` / `\.` / `\[` | Any 1 char / literal `.` / literal `[` | `h.` on `"hello"` → `he` |
| `*` / `+` / `?` | `0+` / `1+` / **`0` or `1`** of preceding element | `h?l` on `"hlolo"` → `hl l`; `hl+` on `"hlolohl"` → `hl hl` |
| `{n}` `{n,}` `{n,m}` | Exact / at-least / bounded repetition | `l{2,}` on `"ohelllllo"` → `lllll` |
| `^` / `$` | Start / end of string | `^hel` on `"helloo"` → `hel`; `o$` on `"hello"` → `o` |
| `\d` `\w` `\s` | Digit / word char (`A-Za-z0-9_`) / whitespace | `\d+` on `"123"` → `123` |
| `(...)` | Capturing group (`(?:...)` = non-capturing) | `\[(\d+):(\d+)\]\s(\w+)` on `"[7:0] data_in"` → `{[7:0] data_in} 7 0 data_in` |

- **Why `regexp -all -inline {h*} "hello"` outputs `h {} {} {} {}` (`day-4.tcl:140`)**: Because `h*` allows **zero** `h`'s, it greedily matches `"h"` at index 0, then matches the empty string `""` at every subsequent non-`h` position (`e`, `l`, `l`, `o`). Use `h+` when at least one `h` is required.

## Traps & Fixes (from [day-4.tcl](../day-4.tcl))

| Trap | Why | Fix |
| --- | --- | --- |
| `regexp -all {\[(\d+):(\d+)\]\s(\w+)} $input match size port` (`day-4.tcl:161`) | Pattern has **3** capture groups: `group 1`=`7` (`size`), `group 2`=`0` (`port`), `group 3`=`data_in` (dropped!) | Supply 3 vars (`match msb lsb port`) or use non-capturing `(?:\d+)` |
| `foreach i $listc` on `-inline` with a capture group (`day-4.tcl:193-197`) | `-inline` flattens `{full1 grp1 full2 grp2 ...}` into a single list | Unpack in pairs: `foreach {full port} $listc { puts $port }` |
| Comment `#? 0 or more` (`day-4.tcl:143`) | `?` matches **0 or 1** (optional), NOT 0 or more | `*` = 0+, `+` = 1+, `?` = 0 or 1 |
| Thinking `lassign` removes elements from `$listm` (`day-4.tcl:47-51`) | `lassign` is pure — `$listm` stays intact, leftovers are returned | Assign back to consume: `set listm [lassign $listm x y]` |
| Passing `$listm` to `lappend` | Mutates a variable named after `$listm`'s contents instead of `listm` | Pass variable name without `$`: `lappend listm f g h` |

## Quick Recall

1. Why does `regexp -all -inline {h*} "hello"` return `h {} {} {} {}` instead of just `h`?
2. Why does `split "abcdabcdabab " "ab"` return 9 elements starting with `{}` `{}`?
3. In `regexp {\[(\d+):(\d+)\]\s(\w+)} {[7:0] data_in} match size port`, what value lands in `$port` and why?

<details>
<summary>Answers</summary>

1. `*` permits 0 occurrences, so after matching `"h"` at index 0 it matches zero-length `""` at each of the remaining 4 characters.
2. `split` cuts on every `'a'` and every `'b'` individually; the leading `'a'` and adjacent `'b'` produce empty `{}` elements before each cut.
3. `0` — the pattern has 3 `(...)` groups (`7`, `0`, `data_in`), so `size` gets `7`, `port` gets `0`, and `data_in` is unassigned.

</details>

## Tcl 8.6 Reference

- [list(n)](https://www.tcl-lang.org/man/tcl8.6/TclCmd/list.htm) · [lindex(n)](https://www.tcl-lang.org/man/tcl8.6/TclCmd/lindex.htm) · [lappend(n)](https://www.tcl-lang.org/man/tcl8.6/TclCmd/lappend.htm) · [lset(n)](https://www.tcl-lang.org/man/tcl8.6/TclCmd/lset.htm) · [lassign(n)](https://www.tcl-lang.org/man/tcl8.6/TclCmd/lassign.htm) · [lsearch(n)](https://www.tcl-lang.org/man/tcl8.6/TclCmd/lsearch.htm) · [lsort(n)](https://www.tcl-lang.org/man/tcl8.6/TclCmd/lsort.htm) · [foreach(n)](https://www.tcl-lang.org/man/tcl8.6/TclCmd/foreach.htm) · [split(n)](https://www.tcl-lang.org/man/tcl8.6/TclCmd/split.htm) · [re_syntax(n)](https://www.tcl-lang.org/man/tcl8.6/TclCmd/re_syntax.htm) · [regexp(n)](https://www.tcl-lang.org/man/tcl8.6/TclCmd/regexp.htm) · [regsub(n)](https://www.tcl-lang.org/man/tcl8.6/TclCmd/regsub.htm)
