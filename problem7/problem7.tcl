######################################
#Title:Intermediate Problem 02(cell delay maximum occurs time and maximum value)
#Author:Md. Jamilur Rahman
#Version:01
#Date :18-11-2022
#####################################

set clockinput [clock clicks -microseconds]
puts "Input File Name"
gets stdin Filename
puts "Input Info"
gets stdin Info
set m [llength $Info]
set fi [open $Filename r]
set data " "
set count 0      
while {[gets $fi line] >= 0} {
    if {[regexp -nocase "Name" $line]} {
	incr count
	    lappend data "----------Info of [lindex $line 1 end] ----- \n"
    } else {for {set i 0} {$i<$m} {incr i} {
	if {[regexp -nocase [lindex $Info $i] $line]} {
		lappend data "[lindex $Info $i] >> [lindex $line 1 end] \n"
    }
    }
    }}
    close $fi
    puts "Number of Employee: $count"
		puts "[join $data ""]"

set clockoutput [clock clicks -microseconds]
set t [expr $clockoutput - $clockinput]
puts "time stamp: $t us"
       


   

   

