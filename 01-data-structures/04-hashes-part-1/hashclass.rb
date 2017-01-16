class HashClass

  def initialize(size)
    @items = Array.new(size)
  end

  def []=(key, value)
    index = index(key, size)
    # If the index is not in the array, insert it
    # If the index is in the array, but the value matches, insert (to avoid resize)
    if @items[index] == nil || @items[index][1] == value
      @items[index] = [key, value]
    else
      # If the key matches but the value is different, resize
      if @items[index][0] == key
        resize
      else
        # If there is a collision, then continue resizing until able to insert value at a unique index
        while @items[index] != nil && @items[index][1] != value
          self.resize
          index = index(key, size)
        end
        @items[index] = [key, value]
      end
    end
    # Print size and state of hash after each insertion
    puts "Just inserted another item with key: #{key} and value: #{value}"
    puts "The hash size is now #{self.size}"
    puts "The hash is #{self.inspect}"
    puts "---------------------------------"
  end


  def [](key)
    index = index(key, size)
    @items[index][1]
  end

  def resize
    # Make a copy of the current array
    original_array = @items
    # Double the @items array size
    @items = Array.new(size * 2)
    # Loop through the original array and create new keys/insert into new @items array
    original_array.each do |item|
      if (item != nil)
        key = item[0]
        new_index = index(key, size)
        @items[new_index] = item
      end
    end
  end

  # Returns a unique, deterministically reproducible index into an array
  # We are hashing based on strings, let's use the ascii value of each string as
  # a starting point.
  def index(key, size)
    # Takes the string 'key', creates an array of individual characters (split), maps to an array of ascii values (map), and then sums them (reduce)
    # Reaminder from dividing above amount by array size produces the array index
    (key.split(//).map { |char| char.ord  }.reduce(:+)) % size
  end

  # Simple method to return the number of items in the hash
  def size
    @items.length
  end

end


