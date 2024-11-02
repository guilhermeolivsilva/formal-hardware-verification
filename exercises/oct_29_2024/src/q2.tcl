set input_file [open "students.csv" r]
set data {}

while {[gets $input_file line] >= 0} {
    lappend data [split $line ","]
}
close $input_file

set highest_grade -999
set top_student ""
set average_grade 0

for {set i 1} {$i < [llength $data]} {incr i} {
    set row [lindex $data $i]

    set curr_name [lindex $row 0]
    set curr_grade [lindex $row 2]

    if { $curr_grade > $highest_grade } {
        set top_student $curr_name
        set highest_grade $curr_grade
    }

    incr average_grade $curr_grade
}

set average_grade [expr { $average_grade / ($i - 1) }]

set output_file [open "q2.txt" w]

puts $output_file "Student with top grade: $top_student"
puts $output_file "Average grade: $average_grade"

close $output_file