######################################
#Title:Intermediate Problem 01(read input file and save modified data to outputfile)
#Author:Md. Jamilur Rahman
#Version:01
#Date :11-11-2022
#####################################

set clockinput [clock clicks -microseconds]
set fi [open text.txt r] ; #open the text.txt file
set fo [open problem1out.txt w+] ; #open a file to write the required ans
# reading the file line by line ant store value to line list
while {[gets $fi line] >=0 } {
    if {[regexp summer $line]} {
        # save the line that contained summer
	puts $fo "$line"
        #split the line to print characterwise for reverse the string and find out vowel
	    set char [split $line ""]
	    set reverse [lreverse $char]
	    set reversestring [join $reverse ""]
	    puts $fo "reverse line:$reversestring"
	    #replace the last index of summer contained line by term "replace"
	    set replaceline [lreplace $line end end replace]
	    puts $fo "replace line:$replaceline"
	    #vowel print from summer contained line
	    set n [llength $char]
	    set vowel "a e i o u"
	    set linevowel { } 
	for {set i 0} {$i<$n} {incr i} {
	    if {[regexp -nocase [lindex $char $i] $vowel] && ![regexp " " [lindex $char $i]]} { 
		lappend linevowel [lindex $char $i]
	    }
	}
	    puts $fo "line vowel :[join $linevowel " "]"
            #vowel count from summer contained line
	    puts $fo "total vowel :[llength $linevowel]"
            #unique vowel count from summer contained line
	    set uniquevowel [lsort -nocase -unique $linevowel]
	    set totaluniquevowel [llength $uniquevowel]
	    puts $fo "total unique vowel :$totaluniquevowel"
            #unique vowel position print from summer contained line
	    foreach item $vowel {
		set position [lsearch -all $char $item]
		    puts $fo "position of $item in my line: $position"
	    }
    }
}
close $fo
close $fi
set clockoutput [clock clicks -microseconds]
set t [expr $clockoutput - $clockinput]
puts "time stamp: $t us"

