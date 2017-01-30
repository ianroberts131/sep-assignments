def fib(n)
 if (n == 0)
   return 0
 elsif (n == 1)
   return 1
 else
   return fib(n-1) + fib(n-2)
 end
end

puts "Fib(20) is #{fib(20)}"

require 'benchmark'
puts Benchmark.measure { fib(20) }