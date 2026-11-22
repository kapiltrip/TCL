#operators in tcl , to add computation 
#expression , to execute an expression 
set a 3 
set b 5
puts [expr {$a + $b }]
# + , - , * , / , % , ** (exponent )
puts [expr {$a ** $b }]
#relational operators == , != , >= , <=  logical operators  && || ! (logical not )
#bitwise logical operator (binary format ) %f (floating point number ) , %e (scientific notation ) , %E (upper case scientific notation )
set var1 23
puts "[format %b $var1 ]"
puts "[format %08b $var1]"
#g for floating point numbers , %c single character , %s string %% literal % 
set a 12 
set b 123
puts "[format %09b [expr {$a & $b }]]"
#mathematical function 
set num -11
puts [set floor_val [expr {abs ($num)}]] 
puts [set ceil_var [expr {ceil(4.1)}]]
#log 1222222
puts [set log_val [expr {log(122222)}]]
#power 8 to 10 
puts [set powerof8 [expr {pow(8,10)}]]