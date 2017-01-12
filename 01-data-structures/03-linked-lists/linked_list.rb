require_relative 'node'

class LinkedList
  attr_accessor :head
  attr_accessor :tail

  # This method creates a new `Node` using `data`, and inserts it at the end of the list.
  def add_to_tail(node)
    if (!@head)
      @head = node
      @tail = node
    elsif (@head == @tail)
      @tail = node
      @head.next = tail
    else
      current = head
      while(current.next != nil)
        current = current.next
      end
      current.next = node
      @tail = node
    end
  end

  # This method removes the last node in the lists and must keep the rest of the list intact.
  def remove_tail
    if (@head == @tail)
      @head = nil
      @tail = nil
    elsif (@head.next == @tail)
      @head.next = nil
      @tail = @head
    else
      current = head
      while(current.next != nil && current.next != @tail)
        current = current.next
      end
      @tail = current
    end
  end

  # This method prints out a representation of the list.
  def print
    current = @head
    while (current.next != nil || current == @tail)
      puts current.data
      break if current == tail
      current = current.next
    end
  end

  # This method removes `node` from the list and must keep the rest of the list intact.
  def delete(node)
    if (node == @head)
      @head = node.next
    elsif (node == @tail)
      self.remove_tail
    else
      current = @head
      while (current != node)
        if (current.next == node)
          current.next = node.next
          break
        end
        current = current.next
      end
    end
  end

  # This method adds `node` to the front of the list and must set the list's head to `node`.
  def add_to_front(node)
    if (!@head)
      @head = node
      @tail = node
    else
      prior_head = @head
      @head = node
      @head.next = prior_head
    end
  end

  # This method removes and returns the first node in the Linked List and must set Linked List's head to the second node.
  def remove_front
    if (@head)
      @head = @head.next
    end
  end
end

# Test the efficiency of arrays vs. linked lists

require 'benchmark'

# Test creating a 10,000 item array and linked list
puts "Testing the efficiency of creating a 10,000 item array: "
print Benchmark.measure{Array.new(10_000, "hi")}

puts "Testing the efficiency of creating a 10,000 item linked list: "
print Benchmark.measure{
  list = LinkedList.new
  node = Node.new('hi')
  i = 0
  while (i < 10_000)
    list.add_to_tail(node)
    i += 1
  end
}

# Test the efficiency of retrieving 5,000th element of array vs. linked list

array = Array.new(10_000, "hi")
list = LinkedList.new
node = Node.new('hi')
i = 0
while (i < 10_000)
  list.add_to_tail(node)
  i += 1
end

puts "-------------------------------------------"

puts "Testing the efficiency of accessing the 5,000th element of an array: "
print Benchmark.measure{ array[5000] }

puts "Testing the efficiency of accessing the 5,000th element of a linked list: "
print Benchmark.measure{
  i = 0
  current = list.head
  while (i < 5_000)
    i += 1
    current = current.next
  end
}

puts "--------------------------------------------"

array = Array.new(10_000, "hi")
list = LinkedList.new
node = Node.new('hi')
i = 0
while (i < 10_000)
  list.add_to_tail(node)
  i += 1
end

puts "Testing the efficiency of removing the 5,000th element of an array: "
print Benchmark.measure{ array.delete_at(5000) }

puts "Testing the efficiency of removing the 5,000th element of a linked list: "
print Benchmark.measure{
  i = 0
  current = list.head
  while (i <= 5_000)
    if (i == 5_000)
      list.delete(current)
      break
    end
    current = current.next
    i += 1
  end
}