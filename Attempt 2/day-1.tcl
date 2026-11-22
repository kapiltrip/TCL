if (0) {
#command name and the remaining words are parameters we can use spaces 
#; or /n (newline ) set variable_name variable_value 
set var1 1
set var2 "Hello"
# assign a value to a variable in a declaration itself , cant leave it unassigned 
puts "$var1 $var2 " 
unset var1 

# substitution variable , command , backslash 
#to store var2's value in variable 3 
set var3 $var2
puts $var3
#set var4.1 34 
# puts $var4.1 - and . should be avoided since its string delimiter 
set var4_1 32 
puts $var4_1
set res LUT 
#need to append 6 to this 
puts ${res}6 
# to append a variable to a string 
#incr method 
incr var7 5 
puts $var7
#command substitution 
set var8 [set var9 84]
puts $var8 
}
#back slash substitution 
# $ variable substitution , [] command substitution , 
set var1 \$5 
puts $var1 
set var2 mem\[addr\]
puts $var2 
set var3 \\n 
puts $var3 
# parsing -> then substitution -> execution 
