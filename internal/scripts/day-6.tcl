# Day 6: corrected lesson practice from Kapil's 5 October 2026 session.
# See day-6.md for original attempts and explanations.
# Assignment solutions are not included.

# Run a saved script with source.
set demo_file [file join [file dirname [file normalize [info script]]] source-demo.tcl]
puts "source demo exists=[file exists $demo_file]"
source -encoding utf-8 $demo_file

# Separate the condition from the script body.
set age 18
if {$age >= 18} {
    puts "You are eligible for voting"
} else {
    puts "You are not eligible for voting"
}
set x 5
if {$x == 5} {
    puts "X is equal to 5"
} else {
    puts "X is not equal to 5"
}

# if elseif and else.
foreach score {4 10 14 20} {
    if {$score < 10} {
        set category low
    } elseif {$score <= 15} {
        set category middle
    } else {
        set category high
    }
    puts "$score -> $category"
}

# Match literal values with switch.
set grade b
switch -exact -- $grade {
    a {puts "Well done"}
    b {puts "Good; could be better"}
    c {puts "Try again"}
    default {puts "Unknown grade"}
}
set fruit banana
switch -exact -- $fruit {
    apple {puts "It is an apple"}
    banana {puts "It is a banana"}
    default {puts "Select a listed fruit"}
}

# Match filename patterns and regular expressions.
foreach filename {Filetype.jpg notes.txt data.bin} {
    switch -glob -- $filename {
        *.jpg {set kind {JPEG image}}
        *.txt {set kind {text file}}
        default {set kind {unrecognized extension}}
    }
    puts "$filename -> $kind"
}
set message {warn: clock not locked}
switch -regexp -- $message {
    {^warn:} {puts "Warning message"}
    {^error:} {puts "Error message"}
    default {puts "Ordinary message"}
}

# Share switch bodies and handle whitespace deliberately.
set raw_item "apple "
puts "raw item=|$raw_item| length=[string length $raw_item]"
set item [string trim $raw_item]
switch -exact -- $item {
    apple -
    banana -
    orange {
        # This comment is inside an executable body.
        puts "Fruit"
    }
    diamond -
    emerald {puts "Stone"}
    default {puts "Unknown item"}
}

# Repeat with while and a changing condition.
set a 10
while {$a < 20} {
    puts "Value of a: $a"
    incr a
}
puts "after loop: a=$a"

# Repeat with for and an optional initializer.
for {set i 0} {$i < 10} {incr i} {
    puts "Value of i: $i"
}
puts "after first loop: i=$i"
set b 0
for {} {$b < 3} {incr b} {
    puts "Existing counter: $b"
}
puts "after second loop: b=$b"
