######################################
#Title:Intermediate Problem 10(Buffer removal for obtaining best slack) 
#Author:Md. Jamilur Rahman
#Version:01
#Date :23-11-2022
#####################################

set clockinput [clock clicks -microseconds]

set fi [open "Input.txt" r]
set fo [open "problem10out.txt" w]
source "subset.tcl"
set flag 0
set buffer " "
while {[gets $fi line] >= 0} {
    #input file startpoint to till slack (VIOLATED) is written to output file
    puts $fo "$line \n"
	#buffer name with delay is kept to buffer for next calculation
	if {[regexp "Path Type" $line]} {
	    set flag 1
		gets $fi line
		puts $fo "$line \n"
	}
    if {[regexp {slack \(VIOLATED\)} $line]} {
    	#buffer is closed and calculation start with buffer items
	set flag 0
	    set violation "[lindex $line 2]"
	    set cellname " "
	    set celldelay " "
	    #check whether is it possible to met slack by removing buffer
	    foreach item $buffer {
		lappend celldelay "[lindex $item 2]"
	    }
	set min 10
	    foreach item $celldelay {
		if {$min > $item} {
		    set min $item
		}
	    }
	set minviolation [expr 0-$violation]
	    set maxviolation [expr 0.1-$violation]
	    if {$min>$minviolation} {
		puts $fo "\n\n\nCan't be corrected by buffer removal. The smallest buffer removal causes Hold Violation."
	    } else { set powerset [subset "[llength $celldelay]"] ;#check the best combination of buffer removal to meet slack using powerset


		set bestviolation 10
		    set bestsubset ""
		    foreach item1 $powerset {
			set Time 0
			    set delays " "
			    foreach item2 $item1 {
				lappend delays [lindex [lindex $buffer $item2] 2]  ;#buffer value append to delays list
				    set Time [expr [lindex [lindex $buffer $item2] 2]+$Time] ;#buffer value summation calulation for different combination
			    }
			set newviolation [expr $Time + $violation] 
			    if {$newviolation<=.1 && $newviolation>=0} {  ;#choose the combition of buffer value and cell
				puts $fo "New slack = [format %0.4f $newviolation]; Delay values are: $delays "
				    if {$newviolation < $bestviolation} {
					set bestviolation $newviolation
					    set bestsubset $item1
				    }
			    }
		    }
		puts $fo "\n\n\nBuffers to remove:"
		    foreach item4 $bestsubset {
			puts $fo "[lindex $buffer $item4]" ; #write the buffer name those are to be removed
		    }
		puts $fo "Resulting Slack is:[format %0.4f $bestviolation]\n"
		    set buffer " "
	    }
    }



    if {$flag} {
	lappend buffer "$line \n"
    }
}
close $fi
close $fo

set clockoutput [clock clicks -microseconds]
set t [expr $clockoutput - $clockinput]
puts "time stamp: $t us"
