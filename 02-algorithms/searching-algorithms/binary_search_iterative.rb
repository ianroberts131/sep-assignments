def binary_search(collection, value)
  low = 0
  high = collection.length - 1
  
  while low <= high
    mid = ((low + high) / 2).floor
    if (collection[mid] > value)
      high = mid - 1
    elsif (collection[mid] < value)
      low = mid + 1
    else
      return mid
    end
  end
  return "NOT FOUND"
end

collection = [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20]

puts "The index location of 3 is #{binary_search(collection, 3)}"

puts "The index location of 18 is #{binary_search(collection, 18)}"

puts "The index location of 21 is #{binary_search(collection, 21)}"