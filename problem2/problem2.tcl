######################################
 #Title:Intermediate Problem 02(find unique delayname and max occurance value and time)
 #Author:Md. Jamilur Rahman
 #Version:01
 #Date :15-11-2022
 #####################################

set clockinput [clock clicks -microseconds]
set input [open LIF02_Setup_timing.rpt r]; #open a file in read mode
set output [open problem2out.txt w+]; #open a file in read and write mode
set delayname { }; #blank list create to append the value then
while {[gets $input line] >= 0 } {
	if {[regexp delay100x1 $line] || [regexp delay250x1 $line] || [regexp DLY $line]} {
		set delayname [string map {"(" "" ")" ""} [lindex $line 1]]
		if {[info exists delaylist($delayname)]} {
			set delaylist($delayname) [lappend delaylist($delayname) [lindex $line 2]]
		} else { set delaylist($delayname) [lindex $line 2]} 
									
	}	
}

foreach item [array names delaylist] {
	set count ""
	foreach elem $delaylist($item) {
	dict incr count $elem 
	}		
	set max_occur 0
	set max_val 0
	for {set i 0} {$i <[llength $count]} { incr i 2} {
		if {[lindex $count [expr $i +1]]>$max_occur} {
			set max_occur [lindex $count [expr $i +1]]
			set max_val [lindex $count $i]
			}
		}
	puts $output "$item $max_val #occurs $max_occur times"

				
		
 }
close $input
close $output

set clockoutput [clock clicks -microseconds]
set t [expr $clockoutput - $clockinput]
puts "time stamp: $t us"

 

