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
