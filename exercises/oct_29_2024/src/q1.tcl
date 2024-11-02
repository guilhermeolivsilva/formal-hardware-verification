set input ""
set output ""

puts "Input the string to process:"
gets stdin input

for {set i [expr {[string length $input] - 1}]} {$i >= 0} {incr i -1} {
    append output [string index $input $i]
}

set output [string toupper $output]

regsub -all {[aeiouAEIOU]} $output "*" output

puts "Original string: $input"
puts "Transformed string: $output"
