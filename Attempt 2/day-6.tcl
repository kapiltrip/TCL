
source hello.tcl 
source sample.tcl
source switch.tcl
set a 10 
while { $a<=20} {
    puts "value of a is : $a "
    incr a 
}
#for loop 
for {set i 0} {$i < 10 } {incr i} {
    puts $i ; 
}
set b 0 
for {} {$b <5 } {incr b } {
    puts $b
}