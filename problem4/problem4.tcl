 ######################################
 #Title:Intermediate Problem 04(prime and composite number list generation taking range from user)  
 #Author:Md. Jamilur Rahman
 #Version:01
 #Date :15-11-2022
 ######################################
 
set clockinput [clock clicks -microseconds]
 #make a proc to check the weather a number is prime or composite
proc isprime {n} {
	set flag 0
	if {$n==0 || $n==1} {
		set flag 2
		}
	for {set i 2} {$i<$n} {incr i} {
		if {[expr $n%$i]==0} {
			set flag 1
			break;
			}
		}
if {$flag ==0} {
	return 1
	} elseif {$flag==2} {

	} else { return 0}
}
#user input to define the list range
puts "Enter a lower range and upper range to know the list composite number of  prime number"
gets stdin a
gets stdin b
#user input to confirm what list does he want ? prime or composite
puts "To know the prime number list please enter 1"
puts "To know the composite number list please enter 2"
gets stdin m
#blank list generate to append the prime and composite number in the list
set primelist { }
set compositelist { }
#to pass the each and every value to the proc from lower to upper range to check whether it is prime or composite
for {set i $a} {$i<=$b} {incr i} { 
	if {[isprime $i]==1} {
	lappend primelist $i
	} elseif {[isprime $i] ==0} { 
	lappend compositelist $i
	} else { }
}
#to calculate the length of the primelist and compositelist
set primelength [llength $primelist]
set compositelength [llength $compositelist]
#to print the list prime or composite
if {$m ==1} {
	if {$primelength ==0} {
		puts "No prime number in the range {$a to $b}"
		} else { puts "The List of prime number of the range {$a to $b}: $primelist"}
	} else {
	if {$compositelength==0} {
		puts "No composite number in the range {$a to $b}"
         	} else { puts "The List of composite number of the range {$a to $b}: $compositelist"}
}
set clockoutput [clock clicks -microseconds]
set t [expr $clockoutput - $clockinput]
puts "time stamp: $t us"

