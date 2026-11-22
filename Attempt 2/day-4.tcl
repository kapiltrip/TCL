#list : to work with multiple variables , array vs list 
set x 12 
puts [set lista {1 2 3} ]
puts [set listb {{element a } {element b }}]
puts [set listc {"element a " "element b "}]
puts [set listd [list {element an } {element bn}]]
#to combine 2 lists 
#to append b , like both the list together  
puts [set listcomb [list $lista $listb ] ]
#concatenation will form a single list 

#merged to form a single list 
puts [set concatlist [concat $lista $listb ]]

#a(101) -> hr , b(201) -> se , c(301) -> hwe 
#a single list of id used so far , whereas each id have a independent list (employee data )
set hr_list [list 101 ]
set sw_list [list 201 ]
set hw_list [list 301 ]
set employee_id [concat $hr_list $sw_list $hw_list]
set employee_data {
    {101 "a" 25}
    {201 "b" 26}
    {301 "c" 27}
}
#lrepeat 
puts [set listrepeat [lrepeat 3 a b c]  ]
puts [set listbrepeat [lrepeat 4 $listb]]
#lindex and llength 
puts [set lengthoflist [llength $listb]] ; #will count just the list size 
set listc [list {1 2 2} 4 6 8 ]
puts [set lengthc [llength $listc]]
#lindex will return an element at the index , it can return a list in case of nested list 
puts [set index0 [lindex $listc 0 ]]
puts [set index1 [lindex $listc 1 ]]
puts [set indexnested [lindex $listc 0 0 ]]
puts [set indexcurly [lindex $listc {0 1 }]]

#lrange 
set listm [list a b c d e ]
#lassign -> left shift operation 

puts [set indexed [lrange $listm 0 3 ]]
puts [set assigned [lassign $listm x]]
puts $x 

#lassign to put the value into a variable , essentially moving form the list to the variable 
puts [set assigning [lassign $listm x y z w ]]
puts " $x $y $z $w " 

puts $listm  
# lappend $listm
puts [set appended [lappend listm f g h]]
#a b c d e 
puts $appended 
puts [set insertedl [linsert $appended 1 12 ]]
puts [set deletedbasedonrange [lreplace $insertedl 0 3 ]]
puts $deletedbasedonrange 
puts [set replaced [lreplace $deletedbasedonrange 0 1 r e ]]
#lreplace keep original list untouched , and then copy to original list 
#lset to handle that 
#works on the orignal list 

puts [lset deletedbasedonrange 0 1  ]
#lsearch with exact or we can use wildcards 
set lista [list abc ade afg aty ]
puts [lsearch $lista abc]
#will return a index of the pattern 
puts [lsearch -glob $lista {*d*}]
puts [lsearch -all -glob $lista a*]




#lsort | 1) lexicographic sort 
set lista [list a d c d asd dd ]
puts [lsort $lista]
#can print the name decreasing 

puts [lsort -ascii -decreasing $lista ]

set listb [list 33 2324 12 1 0 ]
puts [lsort -integer -increasing $listb]
puts [lsort -integer -decreasing $listb]
set listc [list 1.12 3.22 111.11 0.3]
puts [lsort -real -increasing $listc ]


# in and ni 
set lista [list a b c d ]
puts [expr {"a" in $lista}] 
puts [expr {"a" ni $lista}]
#for each loop 

set lista [list 1 2 3 54 55  1 2 23]
foreach i $lista {
    puts "$i" 
}
set listb [list a  b c ddd eee]
foreach j $listb {
    puts "$j"
}
foreach {j k } $listb {
    puts "$j $k "
}
foreach i $lista j $listb {
    puts "$i $j "
}

#string to a list based on the specified rule (character )
set string "Hello"
puts [llength [split $string e ]]

set str "abcdabcdabab "
puts [split $str "ab"] ; #either a or b 

#regexp and regsub 
#pattern matching regexp options , source matchVar 
puts [regexp {h} "hello" ]
puts [regexp -all {[hello]} "hello"]


puts [set valueReg [regexp -all -inline {[ho]} "hello"]] 
puts $valueReg 

puts [regexp -indices {[ho]} "hello"] 
regexp -all {[ho]} "hello" match 
puts $match 
#last match , will be stored in the match variable 
puts [regexp -all -inline {[ho]} "hello" ]
#cant use inline and match , together 
puts [regexp -indices -all {[ho]} "hello" ]
puts [regexp -nocase -all {[hel]} "Hello"] ; #h or e or l 
puts [regexp {hel|lo} "hello"] ; #trying to find a substring 
#literal character 
puts [regexp -all -inline {[hel]} "hello"]  ; #either of the char hel in the string "hello"
#pipe operator 
puts [regexp -all -inline {hel|lo} "hello"]
puts [regexp -all -inline {h.} "hello"] ; #exactly 1 character after h 
puts [regexp -all -inline {h*} "hello"] ; #0 and more occurance of a single character h 
puts [regexp -all -inline {a*} "abababaaa"] ; #0 or more occurance of specified character 

#? 0 or more occurance of preceding element 
puts [regexp -all -inline {h?l} "hello"] ; #l , hl , h
puts [regexp -all -inline {h?l} "hlolo"]
# + matches one or more occurance of the preceding element 
puts [regexp -all -inline {hl+} "hlolohl" ]

puts [regexp -all -inline {^hel} "helloo"]
puts [regexp -all -inline {o$} "hello"]

#{} specifies how many times the preceding element should be matched {n} {n,} {n,m}
puts [regexp -all -inline {l{2,}} "ohelllllo"]
puts [regexp {3\.14} "3.14"]

puts [regexp -inline {\d+} "123"]
puts [regexp -inline {\w+} "abc"]
#example 
set input {[7:0] data_in}
puts [regexp -inline -all {\[(\d+):(\d+)\]\s(\w+)} $input ]
regexp -all {\[(\d+):(\d+)\]\s(\w+)} $input match size port 
puts $size
puts $match
puts $port 
set var1 {
    module my_design (
        input wire clk_main,
        input wire clk_secondary , 
        input wire data_in,
        output wire data_out , 
        output wire clk_out 
    );
}
puts [regexp -all -inline -indices {clk+} $var1] ; #inline will return string -all will return the occurance  
puts [set listb [regexp -all -inline {clk+\w+} $var1 ]]
#+ means one or more occurance of the preceding element 
puts $listb 
puts [lindex $listb 0 ]
foreach i $listb {
    puts $i
}


set var2 {
    module alu(
        input [7:0] data_in,
        input [3:0] control,
        output [15:0] result,
        output done
    );
}
puts [regexp -all -inline {\[(\d+):(\d+)\]\s(\w+)} $var2]
set listc [regexp -all -inline {\[\d+:\d+\]\s(\w+)} $var2]
puts $listc
foreach i $listc {
    puts $i
}

set var1 hello
puts [regsub "hello" $var1 "tcl" replaced ]
puts $replaced 
set var3  "hello hello hello"
puts [regsub -all "hello" $var3 "tcl"] 
puts [regsub -all {\w+} $var3 "123" replaced_num]
puts $replaced_num








