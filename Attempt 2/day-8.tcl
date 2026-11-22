#namespaces collection of variables and procedures 
if {0} {
namespace eval n1 {
    proc print {} {
        puts "hello namespace" 
    }
}
n1::print 

namespace eval n2 {
    proc add {a b} {
        return [expr {$a + $b }]
    }
}
puts [n2::add 33 11 ]
set var1 111
set var2 323 
puts [n2::add $var1 $var2]

#nested namespaces 
namespace eval n1 {
    proc print {} {
        puts "im in namespace n1 "
    }
    namespace eval n2 {
        proc print {} {
            puts "im in namespace n2 "
        }
    }
}
puts [n1::print]
puts [n1::n2::print]
#namespace children 


namespace eval n3 {
    namespace eval n4 {} 
    namespace eval n5 {}
    namespace eval p4 {} 
    namespace eval p5 {}
    namespace eval x4 {} 
    namespace eval x5 {}
}
#puts [namespace children ::n3]
#puts [namespace children ]
puts [namespace children ::n3 ::n3::p*]
puts [namespace children ::n3 *4]


namespace eval n3 {
    namespace eval n4 {
        puts "[namespace parent]"
    }
}
puts [namespace exists ::n3]
namespace delete ::n3 
puts [namespace exists ::n3]
}
#variable var1 0 
namespace eval n1 {
    variable var1 0 
    proc set_var1 {user_in} {
        variable var1 
        set var1 $user_in 
    }
}
set var2 12 
n1::set_var1 $var2 
puts $n1::var1
#adding array variable in a namespace 

namespace eval n2 {
    variable arr 
    array set arr {}
    proc update_arr {key value } {
        variable arr 
        set arr($key) $value 
    }
    proc get_element {key} {
        variable arr 
        return $arr($key)
    }
    proc print_element {key} {
        variable arr 
        puts "The value of element @ $key is : $arr($key)"
    }
}
puts [array exists n2::arr ]
n2::update_arr 1 abc 
n2::update_arr 2 def 
puts [array size n2::arr]
puts [n2::get_element 1]
n2::print_element 2


namespace eval n3 {
    proc get_lo {} {
        set localVar 10 
        puts "Local VAriable : $localVar "
    }
}
n3::get_lo 
#namespace variable , is accessiable to all teh procedures inside the variable 
namespace eval n4 {
    variable var1 300 
    proc update_var1 {value} {
        variable var1 
        set var1 $value 
    }
    proc display_var1 {} {
        variable var1
        puts "Namespace n4 and the variable is : $var1 "
    }
}
puts [namespace exists ::n4]
n4::display_var1
puts "$n4::var1"
set n4::var1 71
puts "$n4::var1 "
#global variable , global global_var 
set global_var 133
namespace eval n5 {
    proc update_global_val {value} {
        global global_var ; 
        set global_var = $value 
    }
    proc display_glob {} {
        global global_var 
        puts "Glob : $global_var "
    }
}
n5::display_glob

namespace eval mathop {
    variable cnt 
    proc add {a b} {
        return [expr {$a + $b}]

    }
    proc mul {a b} {
        return [expr {$a * $b }]
    }
    namespace export add
    namespace ensemble create  
}
namespace import mathop::add 
puts [add 4 3 ]
#to allow the access of a procedure outside the namespace 
#to bring command from one namespace to another * means all procedures can be accesses outside the namespace 
if {0} {
puts [info command mathop::*]
puts [info procs mathop::*]
puts [info vars mathop::*]
puts [info body mathop::add]
namespace forget mathop::add 
puts [add 3 3] 
}
puts [mathop add 3 2 ] 


