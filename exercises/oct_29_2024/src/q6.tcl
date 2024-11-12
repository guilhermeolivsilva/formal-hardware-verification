proc parse {report_type} {
    set input_file [open "jasper_report_$report_type.txt" r]
    set data {}
    set numbers_list ""

    while {[gets $input_file line] >= 0} {
        lappend data [split $line "|"]
    }
    close $input_file

    for {set i 1} {$i < [llength $data]} {incr i} {
        set row [lindex $data $i]
        set model_id [lindex $row 6]

        if {[string trim $model_id] ne "" && [string is integer [string trim $model_id]]} {
            append numbers_list [string trimright $model_id] " "
        }
    }

    puts "The covered items ID for model $report_type are:\n$numbers_list"
}

parse "branch"
parse "toggle"