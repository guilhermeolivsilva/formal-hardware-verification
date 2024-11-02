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