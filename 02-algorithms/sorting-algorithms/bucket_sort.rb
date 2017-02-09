def insertion_sort(collection)
 sorted_collection = [collection.delete_at(0)]

 for val in collection
   sorted_collection_index = 0
   while sorted_collection_index < sorted_collection.length
     if val <= sorted_collection[sorted_collection_index]
       sorted_collection.insert(sorted_collection_index, val)
       break
     elsif sorted_collection_index == sorted_collection.length - 1
       sorted_collection.insert(sorted_collection_index + 1, val)
       break
     end
     sorted_collection_index += 1
   end
 end

 sorted_collection
end

def bucket_sort(collection)
 min = collection.min
 max = collection.max
 
 num_buckets = Math.sqrt(collection.length).round
 
 delta = ((max - min) / num_buckets).floor + 1
 
 buckets = Array.new(num_buckets) { [] }
 
 collection.each do |value|
   bucket_index = ((value - min) / delta).floor
   buckets[bucket_index].push(value)
 end
 
 (0..buckets.length - 1).each do |index|
   buckets[index] = insertion_sort(buckets[index])
 end
 
 sorted_collection = []
 buckets.each do |bucket|
   bucket.each do |item|
     sorted_collection << item
   end
 end
 return sorted_collection
end

array = [279, 242, 470, 451, 209, 30, 261, 222, 119, 91,
        225, 360, 419, 431, 355, 149, 302, 172, 178, 494, 
        259, 202, 250, 218, 17, 3, 20, 294, 115, 390, 164, 
        470, 236, 452, 304, 104, 82, 29, 76, 214, 259, 323, 
        273, 366, 31, 49, 401, 341, 138, 188]

puts "The array to sort is:"
puts "#{array.inspect}"

puts "The array after bucket sort is:"
puts "#{bucket_sort(array)}"

require 'benchmark'

puts "The bucket sort speed is:"
puts Benchmark.measure {
  bucket_sort(array)
}