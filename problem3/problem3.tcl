######################################
#Title:Intermediate Problem 03(Data separation according to path group)
#Author:Md. Jamilur Rahman
#Version:01
#Date :21-11-2022
#####################################

set clockinput [clock clicks -microseconds]
set fi [open "timing.lifcc.rpt" r]
exec mkdir -p pathgroup
set count 0
while {[gets $fi line] >=0} {
	if {[regexp "Startpoint" $line]} {
	set count 1
	set data " "
	set path " "
	}
	if {[regexp "Path Group:" $line]} {
	set path "[lindex $line 2]"
	}
	if {[regexp {slack \(with no derating\) \(VIOLATED\)} $line]} {
	lappend data "$line \n"
        set writefile [open "pathgroup/$path.rpt" a+]
	puts $writefile "[join $data ""]"
	close $writefile 
	set count 0
	set data " "
	set path " "
	}
	if {$count==1} {
	lappend data "$line \n"
	}

}
close $fi

set clockoutput [clock clicks -microseconds]
set t [expr $clockoutput - $clockinput]
puts "time stamp: $t us"

