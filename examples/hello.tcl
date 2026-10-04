# Run from PowerShell: .\tclsh.cmd .\examples\hello.tcl

set name "Kapil"
puts "Hello, $name!"
puts "Tcl version: [info patchlevel]"

# expr evaluates arithmetic; braces keep the expression together.
set a 12
set b 8
puts "$a + $b = [expr {$a + $b}]"

# A procedure is a reusable command.
proc square {number} {
    return [expr {$number * $number}]
}

foreach number {1 2 3 4 5} {
    puts "square($number) = [square $number]"
}
