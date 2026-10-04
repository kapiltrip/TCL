# Day 4 — Tcl lists: notes, code, and practice review

[← Back to index](README.md#day-4) · [Runnable Day 4 script](internal/scripts/day-4.tcl)

**Kapil’s practice · reviewed 4 October 2026 · Tcl 8.6.18**

Your new console work covers creating and nesting lists, concatenation, repetition, length, indexing, assignment, editing, searching, sorting, and membership. The course places these topics in **Day 4: Lists**, through **in and ni(not in)**. The next lecture is **foreach**. This day is still in progress.

The [original pasted session](internal/sources/console-session-2026-10-04-lists.txt) is preserved. Its beginning repeats your Day 2 indexing and Day 3 expression practice; those reviews remain on their existing pages. The new list practice starts at `set x 12`. Original attempts below are labelled **Your session**; corrected examples and their outputs were checked locally. A correction is not a claim that you already executed it.

## Contents

- [Progress at a glance](#progress-at-a-glance)
- [Create lists and preserve element boundaries](#create-lists-and-preserve-element-boundaries)
- [Nest lists or concatenate their elements](#nest-lists-or-concatenate-their-elements)
- [Employee IDs and nested records](#employee-ids-and-nested-records)
- [Repeat elements and count a list](#repeat-elements-and-count-a-list)
- [Read nested indices with lindex](#read-nested-indices-with-lindex)
- [Take a range and assign elements to variables](#take-a-range-and-assign-elements-to-variables)
- [Append using the variable name](#append-using-the-variable-name)
- [Save the results of linsert and lreplace](#save-the-results-of-linsert-and-lreplace)
- [Change an element with lset](#change-an-element-with-lset)
- [Search for indices or matching values](#search-for-indices-or-matching-values)
- [Sort text, integers, and real numbers](#sort-text-integers-and-real-numbers)
- [Test membership and save the result](#test-membership-and-save-the-result)
- [Names, values, and changed lists](#names-values-and-changed-lists)
- [Assignment progress and next lesson](#assignment-progress-and-next-lesson)
- [Complete practice script](#complete-practice-script)
- [References](#references)

## Progress at a glance

| Your practice | Review |
| --- | --- |
| List construction and nesting | `list` worked; the hand-written `listb` needs a space between its two braced elements |
| `concat` | The displayed result matches your session, but the malformed `listb` makes that result an invalid list |
| Employee ID example | You repeated HR and omitted software; the three-department example is corrected below |
| `lrepeat`, `llength`, and `lindex` | Repetition worked; literal names explain the length differences; nested indices are traced below |
| `lrange` and `lassign` | The corrected commands worked; `lassign` returns leftovers and changes the named variables |
| `lappend`, `linsert`, and `lreplace` | Use the name with `lappend`; save the returned lists from the other two commands |
| `lset` and `lsearch` | Your final commands and search results are correct |
| `lsort` | Your corrected text, integer, and real sorts are correct; always supply the input list |
| `in` and `ni` | Your direct results `1` and `0` are correct; saving the result remains unfinished at the end of the session |
| Day 4 assignments | No attempt at Assignments 17–22 appears in this session |

[← Back to index](README.md#day-4) · [Day contents](#contents)

## Create lists and preserve element boundaries

**Your session:**

```text
% set lista {1 2 3}
1 2 3
% set listb {{element a }{element b }}
{element a }{element b }
% set listc {"elementa " "element b "}
"elementa " "element b "
% set listd [list {element a } {element b }]
{element a } {element b }
```

`set` stores a value; it does not require that value to be a valid list. In your `listb`, the first closing brace is immediately followed by the next opening brace. A list parser needs whitespace between those two elements. This is why the assignment can succeed while a later `llength $listb` fails. The quotes in `listc` are stored inside the outer braced value; a list command can then use those quotes to identify two elements.

Use `list` when constructing a list from values. It adds the grouping needed to recover each argument as one element, including spaces inside that element. See the [official `list` reference](https://www.tcl-lang.org/man/tcl8.6/TclCmd/list.htm).

**Corrected example:**

```tcl
set lista {1 2 3}
set listb {{element a } {element b }}
set listc {"elementa " "element b "}
set listd [list {element a } {element b }]
puts "lista elements=[llength $lista]"
puts "listb elements=[llength $listb]"
puts "listc elements=[llength $listc]"
puts "listd elements=[llength $listd]"
puts "first element=|[lindex $listd 0]|"
```

Output:

```text
lista elements=3
listb elements=2
listc elements=2
listd elements=2
first element=|element a |
```

The final space in `{element a }` is part of the element. The vertical bars above make it visible. Braces that group an argument are syntax; the space inside them is data. The following safe demonstration shows the original error without stopping the script:

```tcl
set listb {{element a }{element b }}
catch {llength $listb} message
puts $message
```

Output:

```text
list element in braces followed by "{element" instead of space
```

[← Back to index](README.md#day-4) · [Day contents](#contents)

## Nest lists or concatenate their elements

**Your session:**

```text
% set liste [list $lista $listb]
{1 2 3} {{element a }{element b }}
% set listf [concat $lista $listb]
1 2 3 {element a }{element b }
```

`list $lista $listb` receives two arguments, so it creates two outer elements. Each contains the original value. Even your malformed `listb` can be stored as one outer element; trying to interpret that element as a sublist still fails.

`concat` trims whitespace at the ends of its arguments and joins them with spaces. For valid input lists, this combines their outer elements into one list. It does **not** repair missing whitespace inside an argument or guarantee that arbitrary text is a valid list. Your printed `listf` is therefore possible exactly as recorded, but `llength $listf` fails on the same missing separator. See the [official `concat` reference](https://www.tcl-lang.org/man/tcl8.6/TclCmd/concat.htm).

**Corrected example, using valid input lists:**

```tcl
set lista {1 2 3}
set listb [list {element a } {element b }]
set liste [list $lista $listb]
set listf [concat $lista $listb]
puts "nested=$liste"
puts "nested outer length=[llength $liste]"
puts "concatenated=$listf"
puts "concatenated length=[llength $listf]"
puts "nested first child=[lindex $liste 0]"
```

Output:

```text
nested={1 2 3} {{element a } {element b }}
nested outer length=2
concatenated=1 2 3 {element a } {element b }
concatenated length=5
nested first child=1 2 3
```

The concatenated list has the three numeric elements followed by two text elements. Grouping inside those text elements is preserved; `concat` does not recursively flatten every nested level.

[← Back to index](README.md#day-4) · [Day contents](#contents)

## Employee IDs and nested records

You created HR `101`, software `201`, and hardware `301`, then used:

```text
% set emp_id [concat $hr_list $hard_list $hr_list]
101 301 101
```

That result is correct for the three arguments you supplied. To combine the three departments once each in HR, software, hardware order, include `soft_list`:

```tcl
set hr_list [list 101]
set soft_list [list 201]
set hard_list [list 301]
set emp_id [concat $hr_list $soft_list $hard_list]
puts $emp_id

set employee_data {
    {101 "a" 25}
    {201 "b" 33}
    {301 "c" 554}
}
puts "records=[llength $employee_data]"
puts "second record=[lindex $employee_data 1]"
puts "second employee name=[lindex $employee_data 1 1]"
puts "third recorded age=[lindex $employee_data 2 2]"
```

Output:

```text
101 201 301
records=3
second record=201 "b" 33
second employee name=b
third recorded age=554
```

Each outer element is one record; its three inner fields are ID, name, and age in your stated order. The braces let that record remain one outer element. Your third age is preserved as `554`: Tcl accepts it as data, but check whether it was a typing error. The session does not establish a replacement value.

[← Back to index](README.md#day-4) · [Day contents](#contents)

## Repeat elements and count a list

Your two repetition forms are both correct. `lrepeat 2 a b` repeats a sequence of two elements; `lrepeat 2 $lista` repeats one argument whose value is itself a list. See [`lrepeat`](https://www.tcl-lang.org/man/tcl8.6/TclCmd/lrepeat.htm) and [`llength`](https://www.tcl-lang.org/man/tcl8.6/TclCmd/llength.htm).

```tcl
set lista {1 2 3}
set listt [lrepeat 2 a b]
set listg [lrepeat 2 $lista]
puts "sequence=$listt"
puts "sequence length=[llength $listt]"
puts "repeated list=$listg"
puts "literal name length=[llength listg]"
puts "actual outer length=[llength $listg]"
puts "first child length=[llength [lindex $listg 0]]"

set var1 "Hello world "
puts "characters=[string length $var1]"
puts "list elements=[llength $var1]"
```

Output:

```text
sequence=a b a b
sequence length=4
repeated list={1 2 3} {1 2 3}
literal name length=1
actual outer length=2
first child length=3
characters=12
list elements=2
```

This answers your length question: `llength listg` parses the literal word `listg`, which is one element. `llength $listg` substitutes the stored value and counts its two outer elements. A nested child’s elements are counted only when you extract and count that child.

`set var1 hello world` supplies an extra argument to `set`; quote or brace the value. Your quoted `"Hello world "` contains 12 characters, including the trailing space. Parsing that same value as a list gives two elements, `Hello` and `world`; list-separating whitespace does not become another element.

[← Back to index](README.md#day-4) · [Day contents](#contents)

## Read nested indices with lindex

For your `list_nest`, the outer structure is:

| Outer index | Element | Inner indices when treated as a sublist |
| --- | --- | --- |
| `0` | `1 2 4 ` | `0` → `1`, `1` → `2`, `2` → `4` |
| `1` | `3` | — |
| `2` | `6` | — |
| `3` | `7` | — |

```tcl
set list_nest [list {1 2 4 } 3 6 7]
puts "literal name length=[llength list_nest]"
puts "outer length=[llength $list_nest]"
puts "first element=|[lindex $list_nest 0]|"
puts "second element=[lindex $list_nest 1]"
puts "path 0 1=[lindex $list_nest 0 1]"
puts "path 0 2=[lindex $list_nest {0 2}]"
puts "path 0 3=|[lindex $list_nest {0 3}]|"
```

Output:

```text
literal name length=1
outer length=4
first element=|1 2 4 |
second element=3
path 0 1=2
path 0 2=4
path 0 3=||
```

`lindex $list_nest {0 3}` follows a path: select outer element `0`, then select element `3` of that child. The child has only indices `0`, `1`, and `2`, so the result is an empty string. It does not select two independent outer elements. This is why your console printed nothing for that command. Multiple index arguments, such as `0 1`, and one list of indices, such as `{0 1}`, express the same path. See [`lindex`](https://www.tcl-lang.org/man/tcl8.6/TclCmd/lindex.htm).

[← Back to index](README.md#day-4) · [Day contents](#contents)

## Take a range and assign elements to variables

`lrange` returns a list from the first index through the last index, including both ends. Your corrected `lrange $lista 0 2` therefore selects `a b c`. In `lrange #lista 0 2`, the `#` is inside an argument position rather than where Tcl expects a command name; it is data. The argument `#lista` is a one-element list, giving the printed representation `{#lista}`. See [`lrange`](https://www.tcl-lang.org/man/tcl8.6/TclCmd/lrange.htm) and [Tcl’s comment rule](https://www.tcl-lang.org/man/tcl8.6/TclCmd/Tcl.htm).

```tcl
set lista [list a b c d]
puts "literal range=[lrange #lista 0 2]"
puts "actual range=[lrange $lista 0 2]"
set leftovers [lassign $lista x]
puts "x=$x; leftovers=$leftovers"
lassign $lista x y w z p
puts "x=$x; y=$y; w=$w; z=$z; p=|$p|"
puts "source list=$lista"
```

Output:

```text
literal range={#lista}
actual range=a b c
x=a; leftovers=b c d
x=a; y=b; w=c; z=d; p=||
source list=a b c d
```

`lassign` writes successive elements to the variable names after the input list. With one destination, it assigns `x=a` and returns the unassigned `b c d`. With five destinations and four elements, it sets the extra variable `p` to the empty string and returns an empty leftover list. Your blank `puts $p` output is correct. It leaves the source list unchanged. See [`lassign`](https://www.tcl-lang.org/man/tcl8.6/TclCmd/lassign.htm).

Use `puts $p` to print the variable; `$puts p` asks Tcl to read a variable named `puts` as the command name. Also, `lassign lista q` assigns the literal word `lista` to `q`; use `$lista` when you intend its stored elements.

Your later `lassign $lista q a b c` also overwrites `a` with `b`, `b` with `c`, and `c` with `d`. This explains why `puts "The value of a is : $a"` eventually prints `b`, even though `a` was `4` during Day 3. Variables retain their latest assigned values throughout the same console session.

[← Back to index](README.md#day-4) · [Day contents](#contents)

## Append using the variable name

**Your session:**

```text
% lappend $lista q
q
% lappend $lista q
q q
% puts $lista
a b c d
```

`lappend` expects a **variable name** as its first argument. With `lista` holding `a b c d`, `$lista` becomes that entire string before `lappend` runs. Tcl then appends to a different variable literally named `a b c d`. A name containing spaces is legal when passed as one argument. The first call creates that variable with value `q`; the second extends it to `q q`. Neither call edits `lista`.

The `q` argument is literal text. Use `$q` only when you want the value stored in the variable `q` to be the new element. See [`lappend`](https://www.tcl-lang.org/man/tcl8.6/TclCmd/lappend.htm).

**Corrected example, matching your successful final append:**

```tcl
set lista [list a b c d]
lappend lista 1 2 3
puts $lista
```

Output:

```text
a b c d 1 2 3
```

[← Back to index](README.md#day-4) · [Day contents](#contents)

## Save the results of linsert and lreplace

Your `linsert $lista 0 12` returns a new list with `12` before the first element. Your `lreplace $listf 0 1` returns a new list with the first two elements removed because you supplied no replacement elements. Both indices in that removal range are included. Neither command assigns the returned list to the original variable. See [`linsert`](https://www.tcl-lang.org/man/tcl8.6/TclCmd/linsert.htm) and [`lreplace`](https://www.tcl-lang.org/man/tcl8.6/TclCmd/lreplace.htm).

```tcl
set lista [list a b c d 1 2 3]
set inserted [linsert $lista 0 12]
puts "inserted=$inserted"
puts "original=$lista"
set lista [linsert $lista 0 12]
puts "saved insertion=$lista"

set listf [list 1 2 3 4]
puts "removed first two=[lreplace $listf 0 1]"
puts "original listf=$listf"
set listg [lreplace $listf 0 1]
puts "saved result=$listg"
```

Output:

```text
inserted=12 a b c d 1 2 3
original=a b c d 1 2 3
saved insertion=12 a b c d 1 2 3
removed first two=3 4
original listf=1 2 3 4
saved result=3 4
```

In your session, the later successful command used `$lista`, giving `c d 1 2 3`. That was a different input from `$listf`, which still held `1 2 3 4`; both results are consistent with their inputs.

Spell the command `lreplace`. Your `replace` attempt produced `Invalid switch - 1`, `No files replaced`, and `child process exited abnormally`. That output is consistent with interactive Tcl finding Windows’ external `replace` program after failing to find a Tcl command of that name. It does not perform Tcl list replacement. The [official `unknown` reference](https://www.tcl-lang.org/man/tcl8.6/TclCmd/unknown.htm) describes this executable fallback. The external command was not replayed during this review.

[← Back to index](README.md#day-4) · [Day contents](#contents)

## Change an element with lset

Your `lset lista 0 6` is correct. Like `lappend`, `lset` takes a variable name, reads that variable, updates the selected element, and stores the changed list back. It also returns the new list. See [`lset`](https://www.tcl-lang.org/man/tcl8.6/TclCmd/lset.htm).

```tcl
set lista [list 1 2 3 4]
lset lista 0 6
puts "literal name=lista"
puts "updated list=$lista"
```

Output:

```text
literal name=lista
updated list=6 2 3 4
```

Your `puts lista` printed the literal name because it contained no substitution. `puts $lista` printed the changed list.

[← Back to index](README.md#day-4) · [Day contents](#contents)

## Search for indices or matching values

For your list `abc deg deg ddd aty`, the indices are `0 1 2 3 4`. Your corrected search results are all correct. A plain `lsearch` returns the first matching index, so searching for `deg` gives `1`, even though another `deg` occurs at `2`. An ordinary search with no match returns `-1`.

```tcl
set lista [list 6 2 3 4]
set listv [list abc deg deg ddd aty]
puts "abc in numeric list=[lsearch $lista abc]"
puts "abc index=[lsearch $listv abc]"
puts "first deg index=[lsearch $listv deg]"
puts "aty index=[lsearch $listv aty]"
puts "first a* index=[lsearch -glob $listv a*]"
puts "ends in d index=[lsearch -glob $listv *d]"
puts "all a* indices=[lsearch -all -glob $listv a*]"
puts "first a* value=[lsearch -inline -glob $listv a*]"
puts "all a* values=[lsearch -inline -all -glob $listv a*]"
```

Output:

```text
abc in numeric list=-1
abc index=0
first deg index=1
aty index=4
first a* index=0
ends in d index=3
all a* indices=0 4
first a* value=abc
all a* values=abc aty
```

| Option or pattern | Meaning in this example |
| --- | --- |
| `-glob` | Match a wildcard pattern; this is also Tcl 8.6’s default search style |
| `a*` | Starts with `a`, followed by any characters: `abc`, `aty` |
| `*d` | Ends with `d`: `ddd` |
| `-all` | Return every matching index |
| `-inline` | Return the matching element instead of its index |
| `-inline -all` | Return a list of all matching elements in input order |

When `-all` or `-inline` is used, a search with no match returns an empty string rather than `-1`. Spell the command `lsearch`, and provide both the list and the pattern; `lsearch abc` is missing an argument. See [`lsearch`](https://www.tcl-lang.org/man/tcl8.6/TclCmd/lsearch.htm).

[← Back to index](README.md#day-4) · [Day contents](#contents)

## Sort text, integers, and real numbers

Your corrected sorting commands are right. The comparison option determines how values are ordered; `-increasing` and `-decreasing` determine direction. Tcl’s default is increasing string order. For these lowercase letters, that gives alphabetical order. The option named `-ascii` uses Unicode code-point string comparison in Tcl 8.6. See [`lsort`](https://www.tcl-lang.org/man/tcl8.6/TclCmd/lsort.htm).

```tcl
set lista [list a b c d]
set listb [list 23 44 1 3 5]
set listc [list 3.55 8.33 2.334 8.2134]
puts "text increasing=[lsort -ascii -increasing $lista]"
puts "text decreasing=[lsort -ascii -decreasing $lista]"
puts "numbers as text=[lsort $listb]"
puts "integers increasing=[lsort -integer -increasing $listb]"
puts "integers decreasing=[lsort -integer -decreasing $listb]"
puts "reals increasing=[lsort -real -increasing $listc]"
puts "reals decreasing=[lsort -real -decreasing $listc]"
puts "original integers=$listb"
```

Output:

```text
text increasing=a b c d
text decreasing=d c b a
numbers as text=1 23 3 44 5
integers increasing=1 3 5 23 44
integers decreasing=44 23 5 3 1
reals increasing=2.334 3.55 8.2134 8.33
reals decreasing=8.33 8.2134 3.55 2.334
original integers=23 44 1 3 5
```

String comparison puts `23` before `3` because it compares their leading characters; `-integer` compares their numeric values. `-real` gives floating-point ordering for your decimal values. `lsort` returns the sorted list, so save it with `set listb [lsort -integer $listb]` if you want to replace the original value.

Your incomplete `lsort -real -increasing` has no input list. Tcl treats its final argument `-increasing` as the list to sort under `-real`, then fails to parse that element as a floating-point number. This explains the otherwise surprising error:

```text
expected floating-point number but got "-increasing"
```

[← Back to index](README.md#day-4) · [Day contents](#contents)

## Test membership and save the result

Your direct tests are correct:

```text
% expr {"a" in $lista }
1
% expr {"a" ni $lista }
0
```

`in` checks whether the left string equals a complete element of the right list; `ni` gives the opposite result. These are expression operators. They do not use the wildcard matching of `lsearch -glob`. See [`expr`](https://www.tcl-lang.org/man/tcl8.6/TclCmd/expr.htm).

**Corrected example:**

```tcl
set lista [list a b c d]
set answer [expr {"a" in $lista}]
puts "a is present=$answer"
puts "a is absent=[expr {"a" ni $lista}]"
set unevaluated {"a" in $lista}
puts "stored text=$unevaluated"
```

Output:

```text
a is present=1
a is absent=0
stored text="a" in $lista
```

| Your attempted form | Why it failed or stored text |
| --- | --- |
| `set answer {"a" in $lista}` | Stores the expression characters literally; no `expr` runs |
| `set answer expr{"a" in $lista}` | No command substitution; the words do not form a valid two-argument `set` assignment |
| `set answer [expr{"a" in $lista}]` | Missing space after `expr`; Tcl looks for a command beginning `expr{"a"` |
| `set answer [expr "a" in $lista]` | Tcl removes the quotes and substitutes the list before `expr` parses it; the resulting `a in a b c d` is not a valid expression |
| `set answer [expr {"a" in $lista}]` | Evaluates the braced expression and stores the returned `1` |

In the correct form, the space separates the command name `expr` from its argument. The braces pass the expression as one word and let `expr` interpret its quoted string and variable. The square brackets run that command and pass its result to `set`.

### The unfinished command at the end

Your session ends with this input, beginning with an unclosed brace:

```text
% set answer [expr {"a" in $lista]
set answer [expr {"a" in $lista} ]

puts $answer
...
set
]
}
```

The first line has `]` where it needs `}]`. Because `{` is still open, the later apparently correct command and `puts` lines are accumulated as part of the unfinished input. They are not executed as separate commands. Checking the complete recorded tail with `info complete` returns `0`, even after the final `}`: it still is not a complete Tcl command. The [`info complete` reference](https://www.tcl-lang.org/man/tcl8.6/TclCmd/info.htm) defines this check.

Start a fresh practice console if it is still waiting for that input, then run these three lines separately:

```tcl
set lista [list a b c d]
set answer [expr {"a" in $lista}]
puts $answer
```

Output:

```text
1
```

This successful saved result was verified locally; it is not visible as a completed command in your pasted session.

[← Back to index](README.md#day-4) · [Day contents](#contents)

## Names, values, and changed lists

Choose the argument form from what the command expects. A list value is usually passed as `$lista`; a destination variable is passed as `lista`. This distinction explains your different `llength` results, the stray variable created by `lappend`, and the successful `lset`.

| Command form | List value or variable name? | Effect on stored variables |
| --- | --- | --- |
| `llength $lista` | List value | Returns the outer element count |
| `lindex $lista 0` | List value | Returns an element |
| `lrange $lista 0 2` | List value | Returns a selected list |
| `lassign $lista x y` | List value, then destination names | Writes `x` and `y`; returns leftover elements |
| `lappend lista q` | Variable name | Appends literal `q` and stores the changed list |
| `linsert $lista 0 12` | List value | Returns a new list; use `set` to retain it |
| `lreplace $lista 0 1` | List value | Returns a new list; use `set` to retain it |
| `lset lista 0 6` | Variable name | Changes element `0` and stores the changed list |
| `lsearch $lista a*` | List value | Returns a match index by default |
| `lsort $lista` | List value | Returns a sorted list; use `set` to retain it |

The console displays command return values automatically. A saved script needs `puts` for visible output. An empty return value produces a blank line or no extra visible text; it does not by itself mean a command failed.

[← Back to index](README.md#day-4) · [Day contents](#contents)

## Assignment progress and next lesson

Assignments 17–22 belong to Day 4, but your pasted session contains no numbered attempt at them. The employee IDs and records are recorded here as practice examples. The existing [Day 1](day-1.md), [Day 2](day-2.md), and [Day 3](day-3.md) pages retain the 16 earlier assignment reviews.

The first Day 4 question asks for the number of unique values in a capacitance list. It is still blank in the course when checked for this update. This page does not record an invented attempt, filled response, or submission for it.

Your next lecture is **foreach**, followed by string-to-list conversion and regular expressions. Before moving on, rerun the corrected membership assignment and check these points from your own examples:

- Count the value with `llength $list_nest`; its four outer elements differ from the three elements in its first child.
- Use `lappend lista ...` and `lset lista ...` with destination names.
- Store a returned list when you want `linsert`, `lreplace`, or `lsort` to change a saved value.
- Keep the space after `expr` and close its expression with `}]` when saving the result.

[← Back to index](README.md#day-4) · [Day contents](#contents)

## Complete practice script

Open the white console using `internal/scripts/start-tcl.cmd`. From its Tcl prompt at the repository root, run:

```tcl
source internal/scripts/day-4.tcl
```

The [saved script](internal/scripts/day-4.tcl) combines the corrected examples above. Its complete contents and output are rendered below.

```tcl
# Day 4: corrected practice through lists, searching, sorting, in, and ni.
# See day-4.md for the original attempts and explanations.

# Construct valid lists and preserve spaces inside elements.
set lista {1 2 3}
set listb {{element a } {element b }}
set listc {"elementa " "element b "}
set listd [list {element a } {element b }]
puts "lista elements=[llength $lista]"
puts "listb elements=[llength $listb]"
puts "listc elements=[llength $listc]"
puts "listd elements=[llength $listd]"
puts "first element=|[lindex $listd 0]|"

# One outer element per argument, or concatenate valid input lists.
set lista {1 2 3}
set listb [list {element a } {element b }]
set liste [list $lista $listb]
set listf [concat $lista $listb]
puts "nested=$liste"
puts "nested outer length=[llength $liste]"
puts "concatenated=$listf"
puts "concatenated length=[llength $listf]"
puts "nested first child=[lindex $liste 0]"

# Each department occurs once. Preserve the recorded third age for review.
set hr_list [list 101]
set soft_list [list 201]
set hard_list [list 301]
set emp_id [concat $hr_list $soft_list $hard_list]
puts $emp_id
set employee_data {
    {101 "a" 25}
    {201 "b" 33}
    {301 "c" 554}
}
puts "records=[llength $employee_data]"
puts "second record=[lindex $employee_data 1]"
puts "second employee name=[lindex $employee_data 1 1]"
puts "third recorded age=[lindex $employee_data 2 2]"

# Repeat a sequence or repeat one list-valued element.
set lista {1 2 3}
set listt [lrepeat 2 a b]
set listg [lrepeat 2 $lista]
puts "sequence=$listt"
puts "sequence length=[llength $listt]"
puts "repeated list=$listg"
puts "literal name length=[llength listg]"
puts "actual outer length=[llength $listg]"
puts "first child length=[llength [lindex $listg 0]]"
set var1 "Hello world "
puts "characters=[string length $var1]"
puts "list elements=[llength $var1]"

# A sequence of indices is a path through nested lists.
set list_nest [list {1 2 4 } 3 6 7]
puts "literal name length=[llength list_nest]"
puts "outer length=[llength $list_nest]"
puts "first element=|[lindex $list_nest 0]|"
puts "second element=[lindex $list_nest 1]"
puts "path 0 1=[lindex $list_nest 0 1]"
puts "path 0 2=[lindex $list_nest {0 2}]"
puts "path 0 3=|[lindex $list_nest {0 3}]|"

# Ranges include both ends. lassign writes named variables, not the source.
set lista [list a b c d]
puts "literal range=[lrange #lista 0 2]"
puts "actual range=[lrange $lista 0 2]"
set leftovers [lassign $lista x]
puts "x=$x; leftovers=$leftovers"
lassign $lista x y w z p
puts "x=$x; y=$y; w=$w; z=$z; p=|$p|"
puts "source list=$lista"

# lappend takes a variable name.
set lista [list a b c d]
lappend lista 1 2 3
puts $lista

# linsert and lreplace return lists; set retains their results.
set lista [list a b c d 1 2 3]
set inserted [linsert $lista 0 12]
puts "inserted=$inserted"
puts "original=$lista"
set lista [linsert $lista 0 12]
puts "saved insertion=$lista"
set listf [list 1 2 3 4]
puts "removed first two=[lreplace $listf 0 1]"
puts "original listf=$listf"
set listg [lreplace $listf 0 1]
puts "saved result=$listg"

# lset takes a variable name and stores the updated list.
set lista [list 1 2 3 4]
lset lista 0 6
puts "literal name=lista"
puts "updated list=$lista"

# Search the intended list; -all returns all matches, -inline their values.
set lista [list 6 2 3 4]
set listv [list abc deg deg ddd aty]
puts "abc in numeric list=[lsearch $lista abc]"
puts "abc index=[lsearch $listv abc]"
puts "first deg index=[lsearch $listv deg]"
puts "aty index=[lsearch $listv aty]"
puts "first a* index=[lsearch -glob $listv a*]"
puts "ends in d index=[lsearch -glob $listv *d]"
puts "all a* indices=[lsearch -all -glob $listv a*]"
puts "first a* value=[lsearch -inline -glob $listv a*]"
puts "all a* values=[lsearch -inline -all -glob $listv a*]"

# Choose string, integer, or real comparison. Sorting returns a new list.
set lista [list a b c d]
set listb [list 23 44 1 3 5]
set listc [list 3.55 8.33 2.334 8.2134]
puts "text increasing=[lsort -ascii -increasing $lista]"
puts "text decreasing=[lsort -ascii -decreasing $lista]"
puts "numbers as text=[lsort $listb]"
puts "integers increasing=[lsort -integer -increasing $listb]"
puts "integers decreasing=[lsort -integer -decreasing $listb]"
puts "reals increasing=[lsort -real -increasing $listc]"
puts "reals decreasing=[lsort -real -decreasing $listc]"
puts "original integers=$listb"

# Evaluate membership, then store the command result.
set lista [list a b c d]
set answer [expr {"a" in $lista}]
puts "a is present=$answer"
puts "a is absent=[expr {"a" ni $lista}]"
set unevaluated {"a" in $lista}
puts "stored text=$unevaluated"
```

Output:

```text
lista elements=3
listb elements=2
listc elements=2
listd elements=2
first element=|element a |
nested={1 2 3} {{element a } {element b }}
nested outer length=2
concatenated=1 2 3 {element a } {element b }
concatenated length=5
nested first child=1 2 3
101 201 301
records=3
second record=201 "b" 33
second employee name=b
third recorded age=554
sequence=a b a b
sequence length=4
repeated list={1 2 3} {1 2 3}
literal name length=1
actual outer length=2
first child length=3
characters=12
list elements=2
literal name length=1
outer length=4
first element=|1 2 4 |
second element=3
path 0 1=2
path 0 2=4
path 0 3=||
literal range={#lista}
actual range=a b c
x=a; leftovers=b c d
x=a; y=b; w=c; z=d; p=||
source list=a b c d
a b c d 1 2 3
inserted=12 a b c d 1 2 3
original=a b c d 1 2 3
saved insertion=12 a b c d 1 2 3
removed first two=3 4
original listf=1 2 3 4
saved result=3 4
literal name=lista
updated list=6 2 3 4
abc in numeric list=-1
abc index=0
first deg index=1
aty index=4
first a* index=0
ends in d index=3
all a* indices=0 4
first a* value=abc
all a* values=abc aty
text increasing=a b c d
text decreasing=d c b a
numbers as text=1 23 3 44 5
integers increasing=1 3 5 23 44
integers decreasing=44 23 5 3 1
reals increasing=2.334 3.55 8.2134 8.33
reals decreasing=8.33 8.2134 3.55 2.334
original integers=23 44 1 3 5
a is present=1
a is absent=0
stored text="a" in $lista
```

[← Back to index](README.md#day-4) · [Day contents](#contents)

## References

The [Namaste FPGA Tcl course](https://namaste-fpga.com/student/learn/37?contentId=1801) supplies the day and lecture order. Your [pasted console session](internal/sources/console-session-2026-10-04-lists.txt) supplies the attempted commands and reported outputs. The official Tcl 8.6.18 command references are linked beside the explanations they support. Corrected code and the stated error cases were checked with the repository’s Tcl 8.6.18 interpreter.

[← Back to index](README.md#day-4) · [Day contents](#contents)
