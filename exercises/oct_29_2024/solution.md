## Exercise 1: Advanced String Manipulation

Write a Tcl script that reads a string from the user and performs the following operations:

1. Reverse the string.
2. Convert all characters to uppercase.
3. Replace all vowels with the character '*'.
4. Print the original string and the transformed string.

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

Create a Tcl script that reads a CSV file containing student records (Name, Age, Grade). The
script should:

1. Create sample CSV files for testing your script.
2. Parse the CSV file.
3. Calculate the average grade of the students.
4. Find and print the name of the student with the highest grade.
5. Save the results (average grade and top student) to a new file

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

Write a Tcl procedure to calculate the factorial of a given number using recursion. The script
should:

1. Define a recursive procedure factorial.
2. Read an integer from the user.
3. Call the factorial procedure and print the result.

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

Develop a Tcl script that validates email addresses. The script should:

1. Read a list of email addresses from a file.
2. Use a regular expression to validate each email address.
3. Print valid and invalid email addresses separately.

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

Create a Tcl script that interacts with the operating system to perform the following tasks:

1. List all files in a specified directory.
2. For each file, determine its size and last modification date.
3. Print the file details in a formatted manner.

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