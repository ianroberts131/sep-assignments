class Recursion
  attr_accessor :iterations
  
  def initialize
    @iterations = 0
  end

  def numbers(n)
   @iterations += 1
   if (n == 0)
     return 0
   elsif (n == 1)
     return 1
   else
     return numbers(n-1) + numbers(n-2)
   end
  end
  
end

rec = Recursion.new

rec.numbers(1)
puts "Iterations: #{rec.iterations}"

