#store and retrive elements in a key value pairs 
array set arr1 {} ;#empty array 
puts [array exist arr1]
set arr1(0) abc 
puts [array size arr1 ]
array set arr1 {
    0 abc 
    1 def 
    2 ghi 
    3 jkl

}
puts [array size arr1]
set arr1(4) mno 
puts [array size arr1]
puts [array exists arr1]
set a 3
puts "$arr1($a)"
puts [array name arr1]
array set arr2 {
    a 1 
    b 3 
    c 4 
    d 5 
}
puts [array name arr2]
puts [lsort [array name arr2]]
#array get to get a key value pair
puts [array get arr1] 
puts [array exists arr1]
array set arr3 [array get arr1]
puts [array name arr3]

#list to array 
array set arr4 {}
set listkey [list 0 1 2 3]
set listvalue [list a b c d ]
foreach i $listkey j $listvalue {
    set arr4($i) $j ; 
}
puts [array size arr4 ]
puts [parray arr4 ]


#array to list 
puts [array get arr4 ]
set values {}
set keys {}
foreach {i j} [array get arr4] {
    lappend keys $i 
    lappend values $j
}
puts $keys 
puts $values 
