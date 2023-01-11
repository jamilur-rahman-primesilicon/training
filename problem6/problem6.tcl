######################################
#Title:Intermediate Problem 06 (data separation from file and calculate max, min, avg delay)
#Author:Md. Jamilur Rahman
#Version:01
#Date :17-11-2022
#####################################
set tcl_precision 3
set clockinput [clock clicks -microseconds]
set f1 [open "all_timing_report.rpt" r]
set f2 [open "problem6out.csv" w]
puts $f2 "libcell, Min_delay,Average_delay,Max_delay"
while {[gets $f1 line]>=0 } {
    set line [ string map {"(" "" ")" "" } $line ]
	if {[regexp {/Y } $line] || [regexp {/ECK } $line] || [regexp {/Q } $line]} {
	    set cellname [lindex $line 1]
		if {[llength $line] >6} {
		    if {[info exists delaylist($cellname)]} {
			set delaylist($cellname) [lappend delaylist($cellname) [lindex $line 4]]
		    } else { set delaylist($cellname) [lindex $line 4]}
		} else { gets $f1 line 
		    if {[info exists delaylist($cellname)]} {
			set delaylist($cellname) [lappend delaylist($cellname) [lindex $line 2]]
		    } else { set delaylist($cellname) [lindex $line 2]}
		}
	}
}
foreach libcell [array names delaylist] {
    set sum 0
	set max 0
	set min 10000
	foreach delay $delaylist($libcell) {
	    if { $delay > $max } {
		set max $delay
	    }
	    if {$delay < $min} {
		set min $delay
	    }
	    set sum [expr $sum + $delay]
	}
    set avg [expr $sum/[llength $delaylist($libcell)]]
	puts $f2 "$libcell,$min,$avg,$max"
} 
set clockoutput [clock clicks -microseconds]
set t [expr $clockoutput - $clockinput]
puts "time stamp: $t us"


