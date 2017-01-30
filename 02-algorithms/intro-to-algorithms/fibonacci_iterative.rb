def fib(n)
  return 0 if n == 0
  return 1 if n == 1
  
  prev_prev = 0
  prev = 1
  result = 0
  
  (2..n).each do |i|
    result = prev_prev + prev
    prev_prev = prev
    prev = result
  end
  
  return result
  
end

puts "Fib(0) is #{fib(0)}"
puts "Fib(1) is #{fib(1)}"
puts "Fib(2) is #{fib(2)}"
puts "Fib(3) is #{fib(3)}"
puts "Fib(4) is #{fib(4)}"
puts "Fib(5) is #{fib(5)}"
puts "Fib(6) is #{fib(6)}"
puts "Fib(7) is #{fib(7)}"
puts "Fib(8) is #{fib(8)}"
puts "Fib(9) is #{fib(9)}"

puts "Fib(20) is #{fib(20)}"

require 'benchmark'
puts Benchmark.measure { fib(20) }