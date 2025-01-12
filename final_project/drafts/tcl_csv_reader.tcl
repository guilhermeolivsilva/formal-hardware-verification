set input_file [open "../tests/direct.csv" r]
set data {}

while {[gets $input_file line] >= 0} {
    lappend data [split $line ","]
}
close $input_file

for {set i 1} {$i < [llength $data]} {incr i} {
    set row [lindex $data $i]

    # The entire row
    puts $row

    # Element by element
    for {set j 0} {$j < 6} {incr j} {
        puts [lindex $row $j]
    }
}