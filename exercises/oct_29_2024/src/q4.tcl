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