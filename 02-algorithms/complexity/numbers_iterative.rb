def iterative(n)
  num1 = 0
  num2 = 1
  iterations = 0
  i = 0
  while i < n-1
    iterations += 1
    puts "That took #{iterations} iterations"
    tmp = num1 + num2
    num1 = num2
    num2 = tmp
    i+=1
  end
  

  num2
end

iterative(5)