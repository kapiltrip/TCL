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
