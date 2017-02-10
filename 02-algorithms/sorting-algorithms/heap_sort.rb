def heap_sort(collection)
  build_heap(collection, collection.length)
  heap_size = collection.length
  sorted_array = []
  while (heap_size > 0)
    sorted_array.unshift(collection[0])
    temp = collection[0]
    collection[0] = collection[heap_size - 1]
    collection[heap_size - 1] = temp
    heap_size -= 1
    heapify(collection, 0, heap_size)
  end
  return sorted_array
end

def build_heap(collection, length)
  heap_size = length
  node = (length / 2).floor
  while (node >= 0)
    heapify(collection, node, heap_size)
    node -=1
  end
  return collection
end

def heapify(collection, node_index, heap_size)
  left_index = 2 * node_index + 1
  right_index = left_index + 1
  largest = node_index

  if (left_index < heap_size && collection[left_index] > collection[largest])
    largest = left_index
  end
  
  if (right_index < heap_size && collection[right_index] > collection[largest])
    largest = right_index
  end
  
  if (collection[node_index] >= collection[largest])
    largest = node_index
  end
  
  if (largest != node_index)
    temp = collection[node_index]
    collection[node_index] = collection[largest]
    collection[largest] = temp
    heapify(collection, largest, heap_size)
  end
  return collection
end

array = [279, 242, 470, 451, 209, 30, 261, 222, 119, 91,
          225, 360, 419, 431, 355, 149, 302, 172, 178, 494, 
          259, 202, 250, 218, 17, 3, 20, 294, 115, 390, 164, 
          470, 236, 452, 304, 104, 82, 29, 76, 214, 259, 323, 
          273, 366, 31, 49, 401, 341, 138, 188]

puts "The input array is:"
puts "#{array.inspect}"

length = array.length

node = (length / 2).floor

new_array = build_heap(array, array.length)

puts "After building the heap, the array is:"
puts "#{new_array.inspect}"

puts "After the heap sort, the array is:"
puts "#{heap_sort(array)}"

require 'benchmark'

puts "The heap sort speed is:"
puts Benchmark.measure {
  heap_sort(array)
}

