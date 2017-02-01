def swap(array, first_index, second_index)
  temp = array[first_index]
  array[first_index] = array[second_index]
  array[second_index] = temp
end

def partition(array, p, r)
  q = p
  (p...r).each do |j|
    if (array[j] <= array[r])
      swap(array, q, j)
      q += 1
    end
  end
  swap(array, q, r)
  return q
end

def quick_sort(array, p, r)
  if (r - p > 0)
    q = partition(array, p, r)
    quick_sort(array, p, q - 1)
    quick_sort(array, q + 1, r)
  end
end

array = [9, 7, 5, 11, 12, 2, 14, 3, 10, 4, 6]
puts "The original array is: #{array.inspect}"
quick_sort(array, 0, array.length - 1)
puts "Array after sorting: #{array.inspect}"

puts "---------------------------------"

array = [0, 1, 2, 3, 4, -1, -2, -3, -4, 10]
puts "The original array is: #{array.inspect}"
quick_sort(array, 0, array.length - 1)
puts "Array after sorting: #{array.inspect}"