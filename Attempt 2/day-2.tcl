#if (0) {} strings  : space is also a delimiter hence in case of multiple words put "" or {} 

puts "Hello world " 
puts {hello world curly }
set var1 12 
set var2 13 
puts "the value of var1 is $var1 "
puts {the value of var1 curly is $var1 } 
#blocks a variable substitution {} hence we should use " "
#to pass special character 
puts "\"How are u \""
puts {"how are u curly "}
set var1 "apb is used to 
build 
slow peripherals in 
a soc 
" 
puts $var1 
#string : collection of arbitary characters 
puts [string is digit 123 ]
puts [string is integer 456 ]
puts [string is upper ABC ]
puts [string is lower adB]
puts [string is boolean 0 ]
puts [string is boolean dd ]
#string length (including blank spaces ) and string index (return a character at a particular index mentioned end will also work )
puts [string length "hello world "]
puts [string length {hello world }]
puts [string index Hello 1 ]
puts [string index Hello end]
#end , end -1 and end -2 can also work    
#STRING index return a character 
#compare operators 
set var2 Hello 
puts [string first He $var2 ] 
#it will return an index 0 
puts [string first l $var2 ] 
#l at index 2 
puts [string first l $var2 3 ]
#comparision will start form index 3 in the above case 
puts [string last l $var2 ]
#will print the last occurance in the variable 

#string compare match etc 
#no case , special characters 

puts [string match test "test"]
puts [string match -nocase test "TeSt"]
puts [string match *test "Notest"]
#* matches 0 or more characters including spaces 

puts [string match *test* "andtestor "]
puts [string match t?st "tast"]
#it will match anything  a single character 
#string compare , string 1 < () >() or = string 2
puts [string compare a a ]
puts [string compare abc def ] ;  # abc < def hence -1 
puts [string compare Abc def ] 
puts [string compare Abc abc ]
puts [string compare bAc bac] ; #-1  bAc will come before bac 
puts [string compare Ghi7 Ghi6 ]
puts [string compare -nocase abc abc]
#lexicographically compare strings 
#string equal 
puts [string equal -nocase Hello hello ]
puts [string equal -nocase -length 4 Hello Helle]

#string map ; to replace substring 
set var1 "hello"
puts [string map {h k} $var1 ]; 
puts $var1
puts [string map {"hello" "not hello"} $var1]
set var2 "Hello~World~!" 
puts [string map {"~" " " "!" "."} $var2 ]

#remove trailing whitespaces , and leading whitespaces 
set var1 "  Hello world  1"
puts $var1
puts [string trim $var1]
puts $var1 
puts [string tolower $var1 ]
puts [string toupper $var1] ;#spaces digits adn non alphabetic characters remains same 
