# This method takes n arrays as input and combine them in sorted ascending  order
 def sort(*arrays)
  combined_array = arrays.flatten

  sorted_array = [combined_array.pop]
  
  combined_array.each do |val|
    i = 0
    while i < sorted_array.length
      if val <= sorted_array[i]
        sorted_array.insert(i,val)
        break
      elsif i == sorted_array.length - 1
        sorted_array.insert(i + 1, val)
        break
      end
      i += 1
    end
  end

   # Return the sorted array
   sorted_array
 end
 
 array = [0, 4, 10, 5, 7, 8, 2, 3, 11, 1]
 
 sorted_array = sort(array)
 
 puts "The sorted array is: #{sorted_array.inspect}"