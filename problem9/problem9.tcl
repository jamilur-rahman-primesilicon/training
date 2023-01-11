######################################
#Title:Intermediate Problem 09(Memory Placement and core area extention according to user input)
#Author:Md. Jamilur Rahman
#Version:01
#Date :22-11-2022
#####################################

set clockinput [clock clicks -microseconds]
set tcl_precision 6
set fi [open "library_spec_14_05_18.txt" r]

while {[gets $fi line] >=0} {
	#lc_dimension read from input file and assign according to lc_name
    if {[regexp {lc_dimension:} $line]} {
	set line [string map {"{" "" "}" ""} $line] 
	    set [lindex $line 1] "[lrange $line 2 3]"
	    set [lindex $line 4] "[lrange $line 5 6]"
	    set [lindex $line 7] "[lrange $line 8 9]"
	    set [lindex $line 10] "[lrange $line 11 12]"
	    set [lindex $line 13] "[lrange $line 14 15]"
    }
	#memory origin read from input file and assign according to lc_name
    if {[regexp {memory_origin} $line]} {
	gets $fi line
	    set memory_m1_origin "[lindex $line 1]"
	    gets $fi line
	    set memory_m2_origin "[lindex $line 1]"
	    gets $fi line
	    set memory_m3_origin "[lindex $line 1]"
    }
    if {[regexp {die_area} $line]} {
	set die_area "[lindex $line 1]"
    }
    if {[regexp {die_aspect_ratio} $line]} {
	set die_aspect_ratio "[lindex $line 1]"
    }
    if {[regexp {core2die} $line]} {
	set line [string map {"'" ""} $line]
	    set core2die "[lrange $line 1 2]"
    }
}
#memory size assign reading from input file
set memory_m1_size $lc_C
set memory_m2_size $lc_A
set memory_m3_size $lc_E
puts "$memory_m1_size $memory_m2_size $memory_m3_size"
close $fi

#take user input 
puts "Enter Memory Name: "
gets stdin m1
puts "Enter Extension: "
gets stdin ext
set height [expr sqrt($die_area/$die_aspect_ratio)]
set width [expr $die_area/$height]
puts "Height is: $height"
puts "Width is: $width"
set core_width [expr $width-[lindex $core2die 0]]
set core_height [expr $height-[lindex $core2die 1]]
puts "Upper Right of core is : $core_width $core_height"
set core_up_x [expr 1612*[lindex $core2die 0]]
set core_up_y [expr 1097*[lindex $core2die 1]]
puts "Upper Right of core alaine with pitch : $core_up_x $core_up_y"
#user input check
if {$m1 eq "memory_m1"} {
    set origin "$memory_m1_origin"
	set size "$memory_m1_size"
}
if {$m1 eq "memory_m2"} {
    set origin "$memory_m2_origin"
	set size "$memory_m2_size"
}
if {$m1 eq "memory_m3"} {
    set origin "$memory_m3_origin"
	set size "$memory_m3_size"
}
puts "LL of memory = $origin"
set memory_up_x [expr [lindex $origin 0] +[lindex $size 0]]
set memory_up_y [expr [lindex $origin 1] +[lindex $size 1]]
puts "UR of memory = $memory_up_x $memory_up_y"
puts "Extension is :$ext "
#user input check is it single or list 
if {[llength $ext]==1} {
    set E [expr [lindex $origin 0]-$ext]
	set N [expr $memory_up_y + $ext]
	set W [expr $memory_up_x +$ext]
	set S [expr [lindex $origin 1] - $ext]
	puts "Extemsion (E N W S): $E $N $W $S"
   
} else {
    set E [expr [lindex $origin 0]-[lindex $ext 0]]
	set N [expr $memory_up_y +[lindex $ext 1]]
	set W [expr $memory_up_x +[lindex $ext 2]]
	set S [expr [lindex $origin 1] - [lindex $ext 3]]
	puts "Extemsion (E N W S): $E $N $W $S"
}
#Cut those area that are outside the core area

if {$E<[lindex $core2die 0]} {
    set E [lindex $core2die 0]
}
if {$S<[lindex $core2die 1]} {
    set S [lindex $core2die 1]
}
if {$N>$core_up_y} {
    set N $core_up_y
}
if {$W>$core_up_x} {
    set W $core_up_x
}

puts "LL IS :$E $S"
puts "UP IS :$W $N"

set clockoutput [clock clicks -microseconds]
set t [expr $clockoutput - $clockinput]
puts "time stamp: $t us"


