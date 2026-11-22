# Day 5 — Arrays (Associative Maps)

[← Attempt 2](../README.md) · [day-5.tcl](../day-5.tcl) · [← Day 4](day-4.md) · [Day 6 →](day-6.md)

## Core Model

- A Tcl array is an **unordered hash map** of `key → value` pairs (keys are strings).
- An array is **not** a single value: you cannot pass `$arr` around. Pass its **name** (`arr`) or serialize it with `[array get arr]`.

## Array Operations

| Command | Behavior | Example | Output / Effect |
| --- | --- | --- | --- |
| `array set arr {}` | Creates empty array (or merges `k v` pairs into existing array) | `array set arr1 {0 abc 1 def}` | sets `arr1(0)` and `arr1(1)` |
| `set arr(key) val` | Sets/updates one key | `set arr1(4) mno` | adds key `4` |
| `$arr($k)` | Reads element using dynamic key | `set a 3; puts $arr1($a)` | `jkl` |
| `array exists arr` | `1` if `arr` is an array, else `0` | `array exists arr1` | `1` |
| `array size arr` | Number of stored keys | `array size arr1` | `5` |
| `array names arr ?pat?` | List of keys (arbitrary hash order) | `lsort [array names arr2]` | `a b c d` |
| `array get arr ?pat?` | Flat list `k1 v1 k2 v2 ...` | `array get arr1` | `4 mno 0 abc 1 def ...` |
| `array set dst [array get src]` | Independent copy (merges if `dst` already has keys) | `array set arr3 [array get arr1]` | copies all pairs to `arr3` |
| `parray arr ?pat?` | Prints sorted `arr(k) = v` directly to stdout; returns `""` | `parray arr4` | `arr4(0) = a` ... |

## Common Conversions

```tcl
# Parallel lists -> array
array set arr4 {}
foreach k $listkey v $listvalue {
    set arr4($k) $v
}

# Array -> aligned key and value lists
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
| `puts [parray arr4]` (`day-5.tcl:42`) | `parray` already prints to stdout and returns `""`, so `puts` adds a stray blank line | Call `parray arr4` directly without `puts` |
| `array exist` / `array name` (`day-5.tcl:3, 19, 26`) | Works only via Tcl prefix abbreviation; fails if a new subcommand collides | Use canonical names: `array exists`, `array names` |
| Expecting insertion order from `array names` / `array get` | Hash order is arbitrary (e.g., `4 0 1 2 3`, `d a b c`) | Sort explicitly: `lsort [array names arr]` |
| `array set arr3 [array get arr1]` when `arr3` is non-empty | Merges into `arr3` instead of wiping old keys | `array unset arr3` first if you want a clean overwrite |

## Quick Recall

1. Why does `puts [parray arr4]` print an extra empty line?
2. How do you get keys and values from an array while guaranteeing matching positions?
3. How do you make an independent copy of `arr1` into `arr3`?

<details>
<summary>Answers</summary>

1. `parray` writes directly to stdout and returns `""`; `puts ""` then prints a blank line.
2. Iterate pairs from a single snapshot: `foreach {k v} [array get arr] { lappend keys $k; lappend values $v }`.
3. `array set arr3 [array get arr1]` (after `array unset arr3` if `arr3` already existed).

</details>
