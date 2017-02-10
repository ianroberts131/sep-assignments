def binary_search(collection, value, low, high)
  
  if (low <= high)
    mid = ((low + high) / 2).floor
    if (collection[mid] > value)
      high = mid - 1
    elsif (collection[mid] < value)
      low = mid + 1
    else
      return mid
    end
    return binary_search(collection, value, low, high)
  end
  
  return "NOT FOUND"
end

collection = [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20]

puts "The index location of 3 is #{binary_search(collection, 3, 0, collection.length - 1)}"

puts "The index location of 18 is #{binary_search(collection, 18, 0, collection.length - 1)}"

puts "The index location of 21 is #{binary_search(collection, 21, 0, collection.length - 1)}"