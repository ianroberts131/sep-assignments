def linear_iterations(max)
  inputs = 1
  while inputs <= max
    iterations = inputs
    puts "#{inputs}: #{iterations}"
    inputs += 1
  end
end

max = 10
linear_iterations(max)

