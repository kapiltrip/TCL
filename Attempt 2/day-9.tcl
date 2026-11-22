#file io forward slash , to mention paths 

if {0} {
puts [file dirname file_path ]
puts [file nativename $file_path ]
puts [file rootname $file_path ]
puts [set lista [file split $file_path]]
puts $lista 
puts [file join {*}$lista]
#{*} used to unpack the list 
# glob command will return all the files 
puts [glob *] 
puts [glob *.txt]
puts [glob *{.tcl,.txt}]
puts [glob -nocomplain *.c]
puts [glob -types f *.tcl]
puts [glob -directory file_path ]

file mkdir Temp_folder 
file delete -force Temp_folder
file mkdir Temp_folder 
file delete *.txt
#file delete {*}[glob *.txt]
#file copy day-1.tcl day99.tcl
#file rename day99.tcl day10.tcl
#file rename "C:/Users/kapil/OneDrive/Desktop/TCL/Attempt 2/hello.tcl" "C:/Users/kapil/OneDrive/Desktop/TCL/Attempt 2/Temp_folder/"
puts [file exists Temp_folder]
puts [file isfile day-1.tcl]
puts [file isdirectory day-1.tcl] 
puts [file readable day-3.tcl]


set file_path "C:\\Users\\kapil\\OneDrive\\Desktop\\TCL\\Attempt 2\\sample.tcl"
set fileId [open $file_path "r"]
set data [read $fileId]
#close $fileId 
puts $data
puts [llength $data]
puts [lindex $data 6]
puts [file size day-1.tcl]
#puts [set data [read $fileId 6]]

set fileId [open $file_path "r"]
while {[gets $fileId data] >= 0 } {
    puts $data 
}  
#to access a single line 

#file_path 
set violation_count 0 
set total_paths 0 
set file_path {C:/Users/kapil/OneDrive/Desktop/TCL/Attempt 2/timing.txt}
set fileId [open $file_path "r"]
while {[gets $fileId data] >= 0} {
    set total_paths [expr {$total_paths + 1 }] 
    if {[regexp {viol\w+} $data]} {
        set violation_count [expr {$violation_count + 1 }] 
    }
}
puts "total nubmer of timing violation are : $violation_count"
puts "total number of paths in the design are : $total_paths"
}

set file_path {C:/Users/kapil/OneDrive/Desktop/TCL/Attempt 2/timing.txt}
#set fileId [open $file_path "w"]
set fileId [open $file_path "a"]
set data "new data added by me is this , in the timing im appending " 
#puts $fileId $data
puts -nonewline $fileId $data
close $fileId 