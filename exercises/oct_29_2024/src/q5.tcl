set files [glob -directory "." *]

puts [format "%-30s %-10s %-20s" "Filename" "\tSize" "\tLast Modified"]
puts "-------------------------------------------------------------"

foreach file $files {
    set size [file size $file]
    set mtime [file mtime $file]
    set last_modified [clock format $mtime -format "%Y-%m-%d"]

    puts [format "%-30s %-10d %-20s" [file tail $file] "\t$size" "\t$last_modified"]
}
