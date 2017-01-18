require_relative 'node'

class OpenAddressing
  def initialize(size)
    @items = Array.new(size)
  end

  def []=(key, value)
    index = index(key, size)
    node = Node.new(key, value)
    if (next_open_index(index) != -1)
      index = next_open_index(index)
    else
      self.resize
      index = index(key, size)
      index = next_open_index(index)
    end
    @items[index] = node
  end

  def [](key)
    # The best case scenario is that the hash value is unique and we find the index on the first try
    index = index(key, size)
    # If the hash value is not unique, then it's possible the first try won't work.
    # At this point, iterate through the array until you find a key that matches
    if (@items[index].key != key)
      index += 1
      count = 1
      while (count < size)
        if (@items[index].key == key)
          break
        end
        count += 1
        # If the index reaches the end of the array and there are still unsearched items, set the index to 0
        index == size - 1 ? index = 0 : index += 1
      end
    end
    item = @items[index]
    return item.value
  end

  # Returns a unique, deterministically reproducible index into an array
  # We are hashing based on strings, let's use the ascii value of each string as
  # a starting point.
  def index(key, size)
    (key.split(//).map { |char| char.ord }.reduce(:+)) % size
  end

  # Given an index, find the next open index in @items
  def next_open_index(index)
    open_space_found = false
    count = 0
    # Walk through all items of the array until an open space is found
    while (count < size)
      if (@items[index] == nil)
        open_space_found = true
        break
      end
      count += 1
      # If the index reaches the end of the array and there are still unsearched items, set the index to 0
      index == size - 1 ? index = 0 : index += 1
    end
    return open_space_found ? index : -1
  end

  # Simple method to return the number of items in the hash
  def size
    @items.length
  end

  # Resize the hash
  def resize
    original_array = @items
    @items = Array.new(size * 2)
    original_array.each do |item|
      if (item != nil)
        key = item.key
        new_index = index(key, size)
        index = next_open_index(new_index)
        @items[index] = item
      end
    end
  end
  
  def print_array
    @items.each_with_index do |item, index|
      puts "Array index #{index}:"
      if (item == nil)
        print "- Empty array item"
        puts ""
      else
        puts "- Key:    #{item.key}"
        puts "- Value:  #{item.value}"
      end
    end
  end
end

hash = OpenAddressing.new(4)
puts "Inserting 4 items..."
hash["key one"] = "The first item"
hash["key two"] = "The second item"
hash["key three"] = "The third item"
hash["key four"] = "The fourth item"
hash.print_array
puts "-------------------------------"
puts "Inserting a 5th item..."
hash["key five"] = "The fifth item"
hash.print_array