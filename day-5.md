# Day 5 — Tcl arrays: notes, code, and practice review

[← Back to index](README.md#day-5) · [Assignment ideas](ideas.md#day-5) · [Runnable Day 5 script](internal/scripts/day-5.tcl)

**Kapil’s practice · reviewed 5 October 2026 · Tcl 8.6.18**

Your new session covers array creation, lookup, enumeration, copying, and conversion between lists and arrays. The [original console transcript](internal/sources/console-session-2026-10-05-arrays-loops.txt) is preserved. Sections labelled **Your session** retain your attempts; the runnable examples below correct or extend them and were checked in a fresh interpreter. A checked correction does not mean that you already ran it.

The transcript also contains an early Assignment 23 attempt. Its data representation and unfinished extraction are discussed in [Assignment 23 ideas](ideas.md#assignment-23-transistor-width-to-length-ratios). Assignments 23–27 remain for you to implement and review.

## Contents

- [Progress at a glance](#progress-at-a-glance)
- [Create an array and update an element](#create-an-array-and-update-an-element)
- [Read an element and construct a dynamic key](#read-an-element-and-construct-a-dynamic-key)
- [Enumerate keys and preserve key-value pairs](#enumerate-keys-and-preserve-key-value-pairs)
- [Copy and print an array](#copy-and-print-an-array)
- [Convert parallel lists into an array](#convert-parallel-lists-into-an-array)
- [Convert an array into aligned key and value lists](#convert-an-array-into-aligned-key-and-value-lists)
- [Store a structured value under an identity key](#store-a-structured-value-under-an-identity-key)
- [Assignment map and next lesson](#assignment-map-and-next-lesson)
- [Complete practice script](#complete-practice-script)
- [References](#references)

## Progress at a glance

| Your practice | Review |
| --- | --- |
| Empty array, `array size`, and numeric keys | Correct; a Tcl array is a map with string keys |
| Updating `arr1(4)` | Your final `set arr1(4) abcd` is correct; earlier `array ...` forms used the wrong command structure |
| Reading an element | `puts $arr1(0)` works; a bare `$arr1(0)` tries to execute its value as a command |
| Dynamic key | `$arr1($a)` works; `$arr1($a )` requests a different key that includes a space |
| `array get`, `array names`, and `parray` | Correct; use full subcommand names and do not rely on enumeration order |
| Copying to `arr2` | Correct; changing the original later does not change the copy |
| Two lists to `arr4` | Correct for your equal-length lists |
| Array to key and value lists | Initialize and append to the same names; `values`/`value` and `keys`/`key` are different variables |
| Assignment 23 | Preliminary attempt only; detailed approach is in `ideas.md` |

[← Back to index](README.md#day-5) · [Day contents](#contents) · [Assignment ideas](ideas.md#day-5)

## Create an array and update an element

Your `array set arr1 {}` creates an empty array. `array exists arr1` then returns `1`, while `array size arr1` returns `0`: existence and number of entries are different questions. The shortened `array exist` in the console is an accepted unambiguous subcommand abbreviation; saved code should use `exists`. This abbreviation belongs to the `array` command and is different from the shell expanding abbreviated command names.

**Your session:** you added keys `0` through `3`, then assigned `arr1(4)` twice. The second assignment replaces that key’s value, rather than adding another entry. The following example follows that sequence.

```tcl
unset -nocomplain arr1
array set arr1 {}
puts "exists=[array exists arr1] size=[array size arr1]"
array set arr1 {0 abc 1 def 2 ghi 3 jkl}
puts "after population: size=[array size arr1]"
set arr1(4) mno
set arr1(4) jkl
puts "after overwrite: size=[array size arr1] key4=$arr1(4)"
set arr1(4) abcd
puts "final key4=$arr1(4)"
```

Output:

```text
exists=1 size=0
after population: size=4
after overwrite: size=5 key4=jkl
final key4=abcd
```

`array set` takes an array name followed by an even-length list: key, value, key, value. `set arr1(4) abcd` takes the name of one element followed by its new value. Your `array arr1(4) abcd` and `array $arr1(4) abcd` put an element name or its contents in the subcommand position; neither means “update this element.” `set array $arr1(4) abcd` supplies too many arguments to `set`.

An array and a scalar cannot occupy the same variable name at the same time. `unset -nocomplain arr1` removes old demonstration state before creating the array. It is deliberately limited to the example’s variable name. An empty `array set arr1 {}` by itself **does not clear an existing array**. See the [official array reference](https://www.tcl-lang.org/man/tcl8.6/TclCmd/array.htm).

[← Back to index](README.md#day-5) · [Day contents](#contents) · [Assignment ideas](ideas.md#day-5)

## Read an element and construct a dynamic key

**Your session:** `$arr1(0)` produced `invalid command name "abc"`, while `puts $arr1(0)` printed `abc`. Tcl substitutes the value before it chooses the command to run. With no preceding command name, `abc` becomes the command name. With `puts` first, `abc` is its argument.

After `set a 3`, `$arr1($a )` asks for key `3 `, including the trailing space inside the parentheses. Quotes preserve that space; they do not remove it. `$arr1($a)` asks for key `3`.

```tcl
unset -nocomplain arr1
array set arr1 {0 abc 1 def 2 ghi 3 jkl}
set a 3
puts "literal key 0: $arr1(0)"
puts "dynamic key: |$arr1($a)|"
puts "key 3 exists: [info exists arr1(3)]"
puts "key with trailing space exists: [info exists {arr1(3 )}]"
set arr1(label) {clock input}
puts "named key: $arr1(label)"
```

Output:

```text
literal key 0: abc
dynamic key: |jkl|
key 3 exists: 1
key with trailing space exists: 0
named key: clock input
```

Keys need not be integers or consecutive. `0`, `3`, and `label` are all string keys; an array does not create an indexed sequence merely because some keys look numeric. Missing element lookup raises an error, while `info exists` lets you test for the element first. The [Tcl substitution rules](https://www.tcl-lang.org/man/tcl8.6/TclCmd/Tcl.htm) explain the substitutions inside an array index.

[← Back to index](README.md#day-5) · [Day contents](#contents) · [Assignment ideas](ideas.md#day-5)

## Enumerate keys and preserve key-value pairs

Your `array name arr1` and its sorted result worked. Use the complete spelling `array names arr1`. It returns keys only. `array get arr1` returns a **flat list of alternating keys and values**, whose pair order is undefined. Your recorded `4 jkl 0 abc 1 def 2 ghi 3 jkl` is one valid ordering, not a promise for later runs.

Each entry contributes two list elements. Keep pairs together with `foreach {key value} ...`; taking every element as a value mixes names and data. For stable output, sort the keys and look up each value using that same key.

```tcl
unset -nocomplain arr1
array set arr1 {0 abc 1 def 2 ghi 3 jkl 4 abcd}
set pairs [array get arr1]
puts "entries=[array size arr1] pair-list elements=[llength $pairs]"
puts "sorted numeric keys=[lsort -integer [array names arr1]]"
set ordered_pairs {}
foreach key [lsort -integer [array names arr1]] {
    lappend ordered_pairs $key $arr1($key)
}
puts "ordered key-value pairs=$ordered_pairs"
```

Output:

```text
entries=5 pair-list elements=10
sorted numeric keys=0 1 2 3 4
ordered key-value pairs=0 abc 1 def 2 ghi 3 jkl 4 abcd
```

`lsort -integer` is appropriate here because every key is an integer string. For textual keys, choose ordinary or dictionary sorting. Do not independently sort an array’s keys and its values and then zip them: that would destroy the original mapping. Sorting changes presentation order; it does not rearrange an array internally. See [`array get` and `array names`](https://www.tcl-lang.org/man/tcl8.6/TclCmd/array.htm).

**Related ideas:** [Q24: keep the winning cell key](ideas.md#assignment-24-cell-with-the-highest-leakage-current), [Q27: extract values before finding a maximum](ideas.md#assignment-27-largest-gate-power-from-a-value-list).

[← Back to index](README.md#day-5) · [Day contents](#contents) · [Assignment ideas](ideas.md#day-5)

## Copy and print an array

Your `array set arr2 [array get arr1]` is correct. It reads key-value pairs from the original and writes those entries into the destination. The destination has its own elements; a later assignment to `arr1(4)` does not update `arr2(4)`.

```tcl
unset -nocomplain arr1 arr2 merged
array set arr1 {0 abc 1 def 2 ghi 3 jkl 4 jkl}
array set arr2 [array get arr1]
set arr1(4) abcd
puts "original key4=$arr1(4) copied key4=$arr2(4)"
parray arr1
array set merged {spare old}
array set merged [array get arr1]
puts "merge retained spare=$merged(spare) size=[array size merged]"
```

Output:

```text
original key4=abcd copied key4=jkl
arr1(0) = abc
arr1(1) = def
arr1(2) = ghi
arr1(3) = jkl
arr1(4) = abcd
merge retained spare=old size=6
```

`parray arr1` prints names and values for inspection; it is not the returned key-value list used by `array set`. `array set` merges into an existing destination: it updates supplied keys and leaves other keys, such as `spare`, untouched. For an exact replacement, first clear only the intended destination, then populate it. See [`parray`](https://www.tcl-lang.org/man/tcl8.6/TclCmd/library.htm) and [`array set`](https://www.tcl-lang.org/man/tcl8.6/TclCmd/array.htm).

[← Back to index](README.md#day-5) · [Day contents](#contents) · [Assignment ideas](ideas.md#day-5)

## Convert parallel lists into an array

Your two lists `{0 1 2 3}` and `{a b c d}` have the same length. `foreach i $list1 j $list2` therefore visits one key and its associated value together on each iteration, and `set arr4($i) $j` writes the entry correctly.

```tcl
unset -nocomplain arr4
set indices {0 1 2 3}
set items {a b c d}
if {[llength $indices] != [llength $items]} {
    error "Every key needs one corresponding value."
}
array set arr4 {}
foreach key $indices item $items {
    set arr4($key) $item
}
puts "entries=[array size arr4]"
parray arr4
```

Output:

```text
entries=4
arr4(0) = a
arr4(1) = b
arr4(2) = c
arr4(3) = d
```

The added length check protects the pairing. As your [Day 4 unequal-list example](day-4.md#iterate-over-lists-with-foreach) showed, `foreach` supplies an empty string when one list runs out before the other. That can create unintended empty keys or values. The `if` guard is explained on [Day 6](day-6.md#if-elseif-and-else).

An ordinary list of values is not already an `array set` pair list. For example, `array set x {red green blue yellow}` treats `red` and `blue` as keys, with `green` and `yellow` as their values. To index every list item, explicitly generate keys in the required order. Duplicate keys overwrite earlier entries. [Q26](ideas.md#assignment-26-indexed-interconnects-and-an-average-filter) deliberately requires keys starting at `1`, rather than the `0` in your example.

[← Back to index](README.md#day-5) · [Day contents](#contents) · [Assignment ideas](ideas.md#day-5)

## Convert an array into aligned key and value lists

**Your session:** you initialized `values` and `key`, then appended to `value` and `key`. `lappend value ...` creates or extends **value**, so `puts $values` still prints an empty string. `puts $keys` fails because you created **key**, not **keys**. A long-lived console can hide this mistake if `value` already contains old data.

Use one consistent name for each list, clear both, and traverse the keys in one chosen order. Appending the key and its looked-up value in the same iteration preserves alignment.

```tcl
unset -nocomplain arr4
array set arr4 {0 a 1 b 2 c 3 d}
set keys {}
set values {}
foreach key [lsort -integer [array names arr4]] {
    lappend keys $key
    lappend values $arr4($key)
}
puts "keys=$keys"
puts "values=$values"
puts "matching list lengths=[expr {[llength $keys] == [llength $values]}]"
```

Output:

```text
keys=0 1 2 3
values=a b c d
matching list lengths=1
```

The pair form `foreach {key value} [array get arr4] {...}` also preserves pairing, but its output order is unspecified. If only values are needed, build just the value list; if identities will matter later, retain keys alongside them. This distinction is central to [Q24](ideas.md#assignment-24-cell-with-the-highest-leakage-current) and [Q27](ideas.md#assignment-27-largest-gate-power-from-a-value-list).

Your later `set {w l } [array get ratios]` names **one scalar variable whose literal name is `w l `**. Braces group that entire name into one argument. It does not assign separate variables `w` and `l`, and `lassign` on the whole flat pair list would merely take successive list elements, not collect all widths and all lengths. The unfinished assignment representation is addressed in [Q23 ideas](ideas.md#assignment-23-transistor-width-to-length-ratios).

[← Back to index](README.md#day-5) · [Day contents](#contents) · [Assignment ideas](ideas.md#day-5)

## Store a structured value under an identity key

An array’s key identifies an entry; its value can itself be a valid list. This lets one identity retain related fields. This extra lesson example uses module state and bus width, independent of the assignment inputs.

```tcl
unset -nocomplain module_info
array set module_info {
    alu   {ready 8}
    timer {busy 16}
}
foreach module [lsort [array names module_info]] {
    lassign $module_info($module) state width
    puts "$module: state=$state bus_width=$width"
}
```

Output:

```text
alu: state=ready bus_width=8
timer: state=busy bus_width=16
```

There are two outer array entries. Each value has two inner list elements, which `lassign` assigns to the named local demonstration variables. The array identity remains available as `module` during the same iteration. Braces preserve each multi-field value as **one** element in the outer key-value list. See the earlier [Day 4 explanation of `lassign`](day-4.md#take-a-range-and-assign-elements-to-variables).

[← Back to index](README.md#day-5) · [Day contents](#contents) · [Assignment ideas](ideas.md#day-5)

## Assignment map and next lesson

The repository contains approaches for these exercises, not completed responses. Your Assignment 23 attempt remains preliminary; the transcript has no completed answers for 24–27.

| Assignment | Topic to revisit | Detailed approach |
| --- | --- | --- |
| 23 | Identity keys, two-field values, floating-point ratios | [Transistor width-to-length ratios](ideas.md#assignment-23-transistor-width-to-length-ratios) |
| 24 | `array get`, `array names`, and retaining a winning key | [Cell with the highest leakage current](ideas.md#assignment-24-cell-with-the-highest-leakage-current) |
| 25 | Filtering array values and accumulating reciprocals | [Parallel PMOS resistance](ideas.md#assignment-25-parallel-pmos-resistance) |
| 26 | Generating keys and separating average from filtering | [Indexed interconnects and an average filter](ideas.md#assignment-26-indexed-interconnects-and-an-average-filter) |
| 27 | Extracting a value list and comparing real numbers | [Largest gate power from a value list](ideas.md#assignment-27-largest-gate-power-from-a-value-list) |

[Day 6](day-6.md) continues with `source`, conditionals, and loops from the same console transcript. You choose when to implement, review, and submit the assignments.

[← Back to index](README.md#day-5) · [Day contents](#contents) · [Assignment ideas](ideas.md#day-5)

## Complete practice script

At the Tcl `%` prompt, with the repository root as the working directory, run `source internal/scripts/day-5.tcl`. The script initializes its own demonstration variables, prints its results, and can be sourced again. It contains lesson examples only.

```tcl
# Day 5: corrected lesson practice from Kapil's 5 October 2026 session.
# See day-5.md for original attempts and explanations.
# Assignment solutions are not included.

# Create an array and update an element.
unset -nocomplain arr1
array set arr1 {}
puts "exists=[array exists arr1] size=[array size arr1]"
array set arr1 {0 abc 1 def 2 ghi 3 jkl}
puts "after population: size=[array size arr1]"
set arr1(4) mno
set arr1(4) jkl
puts "after overwrite: size=[array size arr1] key4=$arr1(4)"
set arr1(4) abcd
puts "final key4=$arr1(4)"

# Read an element and construct a dynamic key.
unset -nocomplain arr1
array set arr1 {0 abc 1 def 2 ghi 3 jkl}
set a 3
puts "literal key 0: $arr1(0)"
puts "dynamic key: |$arr1($a)|"
puts "key 3 exists: [info exists arr1(3)]"
puts "key with trailing space exists: [info exists {arr1(3 )}]"
set arr1(label) {clock input}
puts "named key: $arr1(label)"

# Enumerate keys and preserve key-value pairs.
unset -nocomplain arr1
array set arr1 {0 abc 1 def 2 ghi 3 jkl 4 abcd}
set pairs [array get arr1]
puts "entries=[array size arr1] pair-list elements=[llength $pairs]"
puts "sorted numeric keys=[lsort -integer [array names arr1]]"
set ordered_pairs {}
foreach key [lsort -integer [array names arr1]] {
    lappend ordered_pairs $key $arr1($key)
}
puts "ordered key-value pairs=$ordered_pairs"

# Copy and print an array.
unset -nocomplain arr1 arr2 merged
array set arr1 {0 abc 1 def 2 ghi 3 jkl 4 jkl}
array set arr2 [array get arr1]
set arr1(4) abcd
puts "original key4=$arr1(4) copied key4=$arr2(4)"
parray arr1
array set merged {spare old}
array set merged [array get arr1]
puts "merge retained spare=$merged(spare) size=[array size merged]"

# Convert parallel lists into an array.
unset -nocomplain arr4
set indices {0 1 2 3}
set items {a b c d}
if {[llength $indices] != [llength $items]} {
    error "Every key needs one corresponding value."
}
array set arr4 {}
foreach key $indices item $items {
    set arr4($key) $item
}
puts "entries=[array size arr4]"
parray arr4

# Convert an array into aligned key and value lists.
unset -nocomplain arr4
array set arr4 {0 a 1 b 2 c 3 d}
set keys {}
set values {}
foreach key [lsort -integer [array names arr4]] {
    lappend keys $key
    lappend values $arr4($key)
}
puts "keys=$keys"
puts "values=$values"
puts "matching list lengths=[expr {[llength $keys] == [llength $values]}]"

# Store a structured value under an identity key.
unset -nocomplain module_info
array set module_info {
    alu   {ready 8}
    timer {busy 16}
}
foreach module [lsort [array names module_info]] {
    lassign $module_info($module) state width
    puts "$module: state=$state bus_width=$width"
}
```

Output:

```text
exists=1 size=0
after population: size=4
after overwrite: size=5 key4=jkl
final key4=abcd
literal key 0: abc
dynamic key: |jkl|
key 3 exists: 1
key with trailing space exists: 0
named key: clock input
entries=5 pair-list elements=10
sorted numeric keys=0 1 2 3 4
ordered key-value pairs=0 abc 1 def 2 ghi 3 jkl 4 abcd
original key4=abcd copied key4=jkl
arr1(0) = abc
arr1(1) = def
arr1(2) = ghi
arr1(3) = jkl
arr1(4) = abcd
merge retained spare=old size=6
entries=4
arr4(0) = a
arr4(1) = b
arr4(2) = c
arr4(3) = d
keys=0 1 2 3
values=a b c d
matching list lengths=1
alu: state=ready bus_width=8
timer: state=busy bus_width=16
```

[← Back to index](README.md#day-5) · [Day contents](#contents) · [Assignment ideas](ideas.md#day-5)

## References

- [Namaste FPGA, Foundation Series 3: Tcl fundamentals](https://namaste-fpga.com/student/learn/37?contentId=1801): Day 5 outline and Assignments 23–27, checked in Chrome on 5 October 2026. The page’s lesson selector identifies the individual item; the shared URL may open a different item.
- [Tcl 8.6 `array`](https://www.tcl-lang.org/man/tcl8.6/TclCmd/array.htm): key-value lists, undefined pair order, creation, updates, and enumeration.
- [Tcl 8.6 language syntax](https://www.tcl-lang.org/man/tcl8.6/TclCmd/Tcl.htm): words, substitution, and array indices.
- [Tcl 8.6 library procedures](https://www.tcl-lang.org/man/tcl8.6/TclCmd/library.htm): `parray`.
- [Tcl 8.6 `info`](https://www.tcl-lang.org/man/tcl8.6/TclCmd/info.htm): existence and completeness checks.

[← Back to index](README.md#day-5)
