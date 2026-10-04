set var1 12
puts "substitution=$var1"
puts {literal=$var1}
puts [string is digit 123a]
puts [string is xdigit 123a]
puts [string length "Hello world "]
puts [string index Kapil end-1]
puts [string first lo hello]
puts [string last o console]
puts [string match {*LUT6*} {LUT6 LUT4 FMUX DFF BUFG BRAM REG}]
puts [string compare -nocase abc Abc]
puts [string equal -nocase Hello hello]
set mapped [string map {~ { } ! .} {Hello~World~!}]
puts $mapped
set text "  Hello world  "
puts "trim=<[string trim $text]>"
puts "upper=<[string toupper $text]>"
set specialString {~@%^+++!!This is special string!! +++^%@~}
puts [string length $specialString]
set memory_block RAM512KB
set character [string index $memory_block 3]
puts [scan $character %c]
