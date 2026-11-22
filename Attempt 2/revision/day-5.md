# Day 5 — Arrays (Associative Maps)

[← Attempt 2](../README.md) · [day-5.tcl](../day-5.tcl) · [← Day 4](day-4.md) · [Day 6 →](day-6.md)

## Definitions

- **Array (Associative Array)**: A **collection of variables** indexed by arbitrary string keys (`arr(key)`), stored internally in a hash table. Keys need not be integers and have **no defined iteration order**.
- **Container vs First-Class Value**: Unlike a `list`, a Tcl array is **not** a single value — `$arr` is illegal (`can't read "arr": variable is array`). Pass an array either by **name** (`arr`, linked via `upvar`) or by serializing its pairs into a flat list with `[array get arr]`.
- **Array Element (`arr(key)`)**: Each element is an individual variable supporting `set`, `incr`, `lappend`, `unset`, and `upvar`. Key text is **literal** including spaces (`arr(0)` and `arr(0 )` are distinct keys).
- **Serialization (`array get` / `array set`)**: `array get` snapshots the hash table as an even-length list `{k1 v1 k2 v2 ...}`; `array set` **merges** a flat `k v` list into an array (updating matching keys and keeping untouched keys).

## List vs Array at a Glance

| Property | `list` | `array` |
| --- | --- | --- |
| Lookup by | Integer position (`0..N-1`) | Arbitrary string key (`$arr($k)`) |
| Order | Preserves insertion order | Arbitrary hash-table order |
| Pass to `proc` | By value (`$lst`) | By **name** (`arr` + `upvar`) or `[array get arr]` |
| Copy | `set b $a` | `array set b [array get a]` |

## Array Operations

| Command | Mechanism | Example | Output / Effect |
| --- | --- | --- | --- |
| `array set arr {}` | Creates empty array (or merges pairs into existing `arr`) | `array set arr1 {0 abc 1 def}` | sets `arr1(0)`, `arr1(1)` |
| `set arr(key) val` | Creates/updates one key | `set arr1(4) mno` | adds key `4` |
| `$arr($k)` | Evaluates `$k` inside `(...)` first, then reads `arr(<result>)` | `set a 3; puts $arr1($a)` | `jkl` |
| `array exists arr` | `1` if `arr` exists as an array (even if empty), else `0` | `array exists arr1` | `1` |
| `array size arr` | Count of stored keys | `array size arr1` | `5` |
| `array names arr ?pat?` | List of keys (optional glob filter; unordered) | `lsort [array names arr2]` | `a b c d` |
| `array get arr ?pat?` | Flat list `k1 v1 k2 v2 ...` (unordered) | `array get arr1` | `4 mno 0 abc 1 def ...` |
| `array set dst [array get src]` | Independent copy (merges if `dst` already has keys) | `array set arr3 [array get arr1]` | copies all pairs into `arr3` |
| `parray arr ?pat?` | Prints sorted `arr(k) = v` directly to `stdout`; **returns `""`** | `parray arr4` | `arr4(0) = a` ... |

## Deterministic Iteration & Conversions

```tcl
# Sorted traversal (never rely on raw hash order)
foreach k [lsort [array names arr2]] {
    puts "$k -> $arr2($k)"
}

# Parallel lists -> array
array set arr4 {}
foreach k $listkey v $listvalue {
    set arr4($k) $v
}

# Array -> aligned key and value lists (from one snapshot)
set keys {}
set values {}
foreach {k v} [array get arr4] {
    lappend keys $k
    lappend values $v
}
```

## Traps & Fixes (from [day-5.tcl](../day-5.tcl))

| Trap | Why | Fix |
| --- | --- | --- |
| `puts [parray arr4]` (`day-5.tcl:42`) | `parray` writes directly to `stdout` and returns `""`; outer `puts` prints a stray blank line | Call `parray arr4` without `puts` |
| `array exist` / `array name` (`day-5.tcl:3, 19, 26`) | Works only via prefix abbreviation; brittle across versions | Use canonical `array exists` and `array names` |
| Relying on `array names` / `array get` order | Hash-table order is arbitrary (e.g. `4 0 1 2 3`, `d a b c`) | Sort keys explicitly: `lsort [array names arr]` |
| `array set arr3 [array get arr1]` onto a non-empty `arr3` | Merges into `arr3`, leaving stale keys behind | Clear first with `array unset arr3` if replacing completely |
| Trailing spaces inside key (`arr(0 )`) | Key lookup is exact; `"0 "` ≠ `"0"` | Keep keys trimmed with no accidental spaces inside `(...)` |

## Quick Recall

1. Why does `set b $arr1` fail in Tcl, and how do you copy `arr1` into `arr3` instead?
2. Why does `puts [parray arr4]` print an extra empty line?
3. If `arr3(99)` already exists, what happens to key `99` after `array set arr3 [array get arr1]`?

<details>
<summary>Answers</summary>

1. A Tcl array is a variable collection, not a single value, so `$arr1` raises `variable is array`. Copy with `array set arr3 [array get arr1]`.
2. `parray` prints directly to `stdout` and returns `""`, which `puts` then prints as a blank line.
3. Key `99` remains in `arr3` because `array set` merges pairs unless you run `array unset arr3` first.

</details>

## Tcl 8.6 Reference

- [array(n)](https://www.tcl-lang.org/man/tcl8.6/TclCmd/array.htm) · [parray(n)](https://www.tcl-lang.org/man/tcl8.6/TclCmd/library.htm)
