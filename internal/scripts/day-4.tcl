# Day 4: corrected practice through regsub. Assignments remain pending.
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

# Iterate over lists with foreach.
set lista [list 1 2 3 4]
set listb [list ab cd ef gh]
foreach i $lista j $listb {
    puts "$i $j"
}

set listb [list ab ef gh]
foreach i $lista j $listb {
    puts "$i |$j|"
}

# Split a string at delimiter characters.
set str "Hello"
puts "split at e=[split $str e]"
puts "parts at e=[llength [split $str e]]"
puts "split at l=[split $str l]"
set str "abcdabcdabcdabab"
set parts [split $str "ab"]
puts "split at a or b=$parts"
puts "part count=[llength $parts]"

# Choose the result form of regexp.
puts "exists=[regexp {[ho]} hello match]"
puts "first match=$match"
puts "count=[regexp -all {[ho]} hello match]"
puts "last match=$match"
puts "matching text=[regexp -all -inline {[ho]} hello]"
puts "index pairs=[regexp -all -inline -indices {[ho]} hello]"
puts "indices mode count=[regexp -all -indices {[ho]} hello]"
puts "case sensitive=[regexp {h} Hello]"
puts "case insensitive=[regexp -nocase {h} Hello]"
puts "class count=[regexp -all -nocase {[hel]} Hello]"
puts "class matches=[regexp -all -inline -nocase {[hel]} Hello]"

# Literal text, classes, alternatives, and spaces.
puts "word=[regexp -all -inline -nocase {hel} Hello]"
puts "with spaces=[regexp -all -nocase {hel | lo } Hello]"
puts "alternatives=[regexp -all -inline -nocase {hel|lo} Hello]"
puts "dot=[regexp -all -inline {h.} hello]"
puts "literal dot=[regexp {3\.14} 3.14]"
puts "digit exists=[regexp {\d} 123]"
puts "first digit=[regexp -inline {\d} 123]"

# Quantifiers and empty matches.
puts "h star=[regexp -all -inline {h*} hello]"
puts "a star=[regexp -all -inline {a*} abababaaa]"
puts "optional h in hello=[regexp -all -inline {h?l} hello]"
puts "optional h in hlolo=[regexp -all -inline {h?l} hlolo]"
puts "one or more l=[regexp -all -inline {hl+} hlolohlhl]"
puts "exactly three l=[regexp -all -inline {l{3}} ollelllla]"
puts "at least two l=[regexp -all -inline {l{2,}} ollelllla]"
puts "two to three l=[regexp -all -inline {l{2,3}} ollelllla]"

# Start and end anchors.
puts "at start=[regexp -all -inline {^hel} helimkapil]"
puts "at end=[regexp -all -inline {hel$} helimkapilhel]"

# Capture a vector range and port name.
set input {[7:0] datain}
set fields [regexp -inline -all {\[(\d+):(\d+)\]\s(\w+)} $input]
puts "inline fields=$fields"
set found [regexp {\[(\d+):(\d+)\]\s(\w+)} $input match size1 size2 port]
puts "found=$found"
puts "whole match=$match"
puts "upper=$size1; lower=$size2; port=$port"

# Clock names from your pasted module.
set var1 {
module my_design(
    input wire clk_main,
    input wire clk_secondary,
    input wire data_in,
    output wire data_out,
    output wire clk_out
);
}
puts "prefix matches=[regexp -all -inline {clk+} $var1]"
set clock_names [regexp -all -inline {clk\w+} $var1]
puts "clock names=$clock_names"
puts "second clock=[lindex $clock_names 1]"
foreach name $clock_names {
    puts $name
}

# Vector ports and flat captured results.
set var2 {
module alu (
    input [7:0] data_in,
    input [3:0] control,
    output [15:0] result,
    output done
);
}
set list3 [regexp -all -inline {\[(\d+):\d\]\s(\w+)} $var2]
puts "original captures=$list3"
puts "element count=[llength $list3]"
puts "first complete match=[lindex $list3 0]"
puts "first upper index=[lindex $list3 1]"

set fields [regexp -all -inline {\[(\d+):(\d+)\]\s+(\w+)} $var2]
foreach {whole upper lower name} $fields {
    puts "$name: range=$upper:$lower; width=[expr {$upper - $lower + 1}]"
}

# Replace matches with regsub.
set var1 hello
puts "returned text=[regsub {hello} $var1 tcl]"
puts "original=$var1"
set count [regsub {hello} $var1 tcl replace]
puts "count=$count; destination=$replace; original=$var1"

set var1 {hello hello hello}
puts "first replacement=[regsub {hello} $var1 tcl]"
puts "all words=[regsub -all {\w+} $var1 123]"
puts "two-word match=[regsub -all {\w+\s\w+} $var1 123]"
puts "three-word match=[regsub -all {\w+\s\w+\s\w+} $var1 123]"
puts "original still=$var1"
set var1 [regsub -all {hello} $var1 tcl]
puts "saved text=$var1"
