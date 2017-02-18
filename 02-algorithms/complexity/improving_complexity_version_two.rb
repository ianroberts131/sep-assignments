# This method takes n arrays as input and combine them in sorted ascending  order
def sort(*arrays)
  combined_array = arrays.flatten

  build_heap(combined_array, combined_array.length)
  heap_size = combined_array.length
  sorted_array = []
  while (heap_size > 0)
    sorted_array.unshift(combined_array[0])
    temp = combined_array[0]
    combined_array[0] = combined_array[heap_size - 1]
    combined_array[heap_size - 1] = temp
    heap_size -= 1
    heapify(combined_array, 0, heap_size)
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

array = [0, 4, 10, 5, 7, 8, 2, 3, 11, 1]
 
sorted_array = sort(array)
 
puts "The sorted array is: #{sorted_array.inspect}"