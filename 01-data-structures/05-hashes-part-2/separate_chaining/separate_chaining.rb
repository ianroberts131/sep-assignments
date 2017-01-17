require_relative 'linked_list'

class SeparateChaining
  attr_reader :max_load_factor

  def initialize(size)
    @max_load_factor = 0.7
    @items = Array.new(size)
  end

  def []=(key, value)
    index = index(key, size)
    node = Node.new(key, value)
    # If the index is not in the array, create a new linked list and add item to it
    # Otherwise, add the item to the tail of the existing linked list
    if (@items[index] == nil)
      @items[index] = LinkedList.new
      @items[index].add_to_tail(node)
    else
      @items[index].add_to_tail(node)
    end
    resize if self.load_factor > @max_load_factor
    
    puts "Just inserted another item with key: #{key} and value: #{value}"
    puts "The hash size is now #{self.size}"
    puts "The hash is #{self.inspect}"
    puts "--------------------------------"
  end

  def [](key)
    index = index(key, size)
    if (@items[index] == nil)
      nil
    elsif (@items[index].head.key == key)
      return @items[index].head.value
    elsif (@items[index].tail.key == key)
      return @items[index].tail.value
    else
      current = @items[index].head
      while (current.key != key && current.next != nil)
        current = current.next
      end
      return current.value
    end
  end

  # Returns a unique, deterministically reproducible index into an array
  # We are hashing based on strings, let's use the ascii value of each string as
  # a starting point.
  def index(key, size)
    (key.split(//).map { |char| char.ord }.reduce(:+)) % size
  end

  # Calculate the current load factor
  def load_factor
    item_count = 0.0
    @items.each do |branch|
      if (branch != nil)
        current = branch.head
        while (current != nil)
          item_count += 1.0
          current = current.next
        end
      end
    end
    return (item_count / size)
  end

  # Simple method to return the number of items in the hash
  def size
    @items.length
  end

  # Resize the hash
  def resize
    original_array = @items
    @items = Array.new(size * 2)
    original_array.each do |branch|
      if (branch != nil)
        current = branch.head
        while (current != nil)
          key = current.key
          value = current.value
          self[key] = value
          current = current.next
        end
      end
    end
  end
end



