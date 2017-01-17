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