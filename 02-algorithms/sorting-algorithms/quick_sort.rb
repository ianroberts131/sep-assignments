def quick_sort(array, p, r)
  if (r - p > 0)
    q = partition(array, p, r)
    quick_sort(array, p, q - 1)
    quick_sort(array, q + 1, r)
  end
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

def swap(array, first_index, second_index)
  temp = array[first_index]
  array[first_index] = array[second_index]
  array[second_index] = temp
end

array = [279, 242, 470, 451, 209, 30, 261, 222, 119, 91,
          225, 360, 419, 431, 355, 149, 302, 172, 178, 494, 
          259, 202, 250, 218, 17, 3, 20, 294, 115, 390, 164, 
          470, 236, 452, 304, 104, 82, 29, 76, 214, 259, 323, 
          273, 366, 31, 49, 401, 341, 138, 188]
          
puts "The original array is:"
puts "#{array.inspect}"
quick_sort(array, 0, array.length - 1)
puts "Array after sorting:"
puts "#{array.inspect}"

require 'benchmark'

puts "The quick sort speed is:"
puts Benchmark.measure {
  quick_sort(array, 0, array.length - 1)
}

