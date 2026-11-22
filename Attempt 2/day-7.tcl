#procedures . 
#PRE defined commands set put , expr open etc efficient and platform independent 
#2) user defined procedures 
proc greet {name} {
    puts "Hello procedure $name "
}
greet called
proc getMax {num1 num2 } {
    if {$num1 > $num2} {
        set res $num1 
    } else {
        set res $num2 
    }
    return $res 
}
puts [getMax 12 11]
proc proc12 {{num1 0} {num2 0}} {
    set sum  [expr {$num1 + $num2 }] 
    puts $sum 
}
proc12


proc user_name {name} {
    puts $name
    set y 6 
}
user_name kk
proc proc3 {x} {
    return [expr $x + 3]
}
puts [proc3 3] 
#local and global variable 
proc proc14 {name} {
    set x $name 
    puts $x 
}
proc14 2

proc proc15 {name} {
    global x 
    set x $name
    puts $x 
}
proc15 hello

puts $x 
#pass by value and pass by reference 
set x 10
proc proc1 {var} {
    incr var 
    return $var
}
puts [proc1 $x]
puts $x

#pass by reference we need to passs by h without a $ sign $var is for pass by value , and var is pass by reference 
 
proc proc2 {out_var} {
    upvar $out_var lo_var
    #local variable will point to the user called variable out_var 

    incr lo_var 
    return $lo_var 
}
set h 12 
puts [proc2 h]
puts $h