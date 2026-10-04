# Day 1: variables, substitution, literal text, and assignment checks.

puts "Variable naming"
set var2_3 23
puts $var2_3
set res LUT
puts ${res}6

puts "Incrementing from an unset state"
unset -nocomplain var2 var3
incr var3 5
incr var2
puts $var3
puts $var2

puts "Command substitution"
set var1 56
set var2 [set var1 87 ]
puts $var1
puts $var2

puts "Literal characters"
set var1 \$5
puts $var1
set var2 mem\[addr]
puts $var2
set var3 \\n
puts $var3

puts "Assignment 1"
set vdd 5
puts $vdd

puts "Assignment 2"
set clk_freq 50
puts $clk_freq

puts "Assignment 3"
set bus_width 64
puts $bus_width

puts "Assignment 4"
set vdd 1.0
puts $vdd

puts "Assignment 5"
set clk_freq 100
puts $clk_freq

puts "Deleting a variable"
set temporary 23
unset temporary
puts [info exists temporary]

puts "Grouping preview"
puts "Voltage = $vdd V"
puts {Voltage = $vdd V}
