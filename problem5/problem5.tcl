######################################
#Title:Intermediate Problem 05(data separation from multiple file and calculate slack)
#Author:Md. Jamilur Rahman
#Version:01
#Date :17-11-2022
#####################################

set clockinput [clock clicks -microseconds]
set tcl_precision 5
set fi [glob -path "data_trans2" *]
set fout [open "problem5out.csv" w+]
puts $fout "Filename,Pin,Direction,Max_rise_time,Max_fall_time,Worst_transition,Limit,Slack"
foreach item $fi {
	set finput [open $item r]
		while {[gets $finput line] >=0} {
			if {[regexp "Pin " $line]} {
				if {[regexp inout $line]} {
				continue;
				}
			set line1 [split [lrange $line 4 end] ","]
			set line2 [string map {"(" "" ")" "" "R=" "" "F=" "" "Threshold=" "" "LibThreshold=" ""} $line1]
			set pin [lindex $line 3]
			set dir [lindex $line2 0]
			set r [lindex $line2 1]
			set f [lindex $line2 2]
			set l [lindex $line2 3]
			set worst $r
			if {$r<$f} {
			set worst $f
			}
			set slack "[expr $worst - $l]"
			puts $fout "$item,$pin,$dir,$r,$f,$worst,$l,$slack"
		}
		}
}
close $finput
close $fout

set clockoutput [clock clicks -microseconds]
set t [expr $clockoutput - $clockinput]
puts "time stamp: $t us"

