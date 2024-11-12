## Exercise 1: Advanced String Manipulation

```tcl
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
```

## Exercise 2: File Operations and Data Parsing

```tcl
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
```

## Exercise 3: Procedures and Recursion

```tcl
proc factorial {x} {
    if {$x > 1} {
        return [expr {$x * [factorial [expr {$x - 1}]]}]
    }

    return 1
}

set input 0
puts "Input a number to calculate its factorial:"
gets stdin input

set output [factorial $input]
puts "$input! = $output"
```

## Exercise 4: Regular Expressions and Pattern Matching

```tcl
set file [open "emails.txt" r]

set valid_emails {}
set invalid_emails {}

while {[gets $file line] >= 0} {
    set email [string trim $line]

    set regex {^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$}
    set is_valid [regexp $regex $email]

    if {$is_valid} {
        lappend valid_emails $email
    } else {
        lappend invalid_emails $email
    }
}

close $file

puts "Valid email addresses:"
foreach email $valid_emails {
    puts $email
}

puts "\nInvalid email addresses:"
foreach email $invalid_emails {
    puts $email
}
```

## Exercise 5: Interfacing with External Commands

```tcl
set files [glob -directory "." *]

puts [format "%-30s %-10s %-20s" "Filename" "\tSize" "\tLast Modified"]
puts "-------------------------------------------------------------"

foreach file $files {
    set size [file size $file]
    set mtime [file mtime $file]
    set last_modified [clock format $mtime -format "%Y-%m-%d"]

    puts [format "%-30s %-10d %-20s" [file tail $file] "\t$size" "\t$last_modified"]
}
```

## Exercise 6: Integration with Jasper

```tcl
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
```

The `toggle` had most of its signals either tagged as `Covered and Checked` or `Unreachable or Undetected`.
This happends because Jasper can check most of the input values, and thus they're covered (eg., all `in_a`
bits and `a_is_zero`). It could not verify output and some bits of `in_b` and `opcode`, though.

The `branch` model, on the other hand, covered all of the items, but most were tagged as
`Unreachable or Undetected`. In this case, it could be implied the branches were exercised by the stimuli,
but there were no specific behaviors to check – likely due to a lack of assertions or expected cases.