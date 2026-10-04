set a 4
set b 5
puts "sum=[expr {$a + $b}]"
puts "integer division=[expr {$a / $b}]"
puts "fractional division=[expr {double($a) / $b}]"
puts "remainder=[expr {$a % $b}]"
puts "a less than b=[expr {$a < $b}]"
set b 0
puts "logical NOT of b=[expr {!$b}]"
set c 243
set d 123
set cdand [expr {$c & $d}]
set cdor [expr {$c | $d}]
puts "AND=$cdand ([format %08b $cdand])"
puts "OR=$cdor ([format %08b $cdor])"
set totalr [expr {10 + 5}]
set voltage 30.0
puts "current=[expr {$voltage / $totalr}] A"
set supply 1.8
set current_ma 5
puts "power=[expr {$supply * $current_ma}] mW"
set frequency_mhz 200.0
puts "period=[expr {1000.0 / $frequency_mhz}] ns"
set transition_ns [expr {500.0 * 2e-12 * log(2.0) * 1e9}]
puts "transition=[format %.6f $transition_ns] ns"
puts "rounded=[expr {round($transition_ns)}] ns"
