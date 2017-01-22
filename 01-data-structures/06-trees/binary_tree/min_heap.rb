require_relative 'node'

class MinHeap
  attr_accessor :root
  attr_accessor :items
  
  def initialize(root)
      @root = root
      @items = [@root]
  end
  
  def insert(root, node)
    @items << node
    node_index = @items.length - 1
    parent_index = ((node_index - 1) / 2).floor
    parent_rating = @items[parent_index].rating
    
    while ((node.rating < parent_rating) && node_index > 0)
      @items[node_index] = @items[parent_index]
      @items[parent_index] = node
      node_index = parent_index
      parent_index = ((node_index - 1) / 2).floor
      parent_rating = @items[parent_index].rating
    end
    
  end
  
  def delete(root, data)
    return nil if data == nil
    if (data == @items.pop.title)
      @items.pop
      return
    end
    last_item = @items.pop
    node = find(root, data)
    node_index = @items.index(node)
    
    @items[node_index] = last_item
    
    parent_index = ((node_index - 1) / 2).floor
    parent_rating = @items[parent_index].rating
    if (node_index > 0 && last_item.rating < parent_rating)
      # If the node has a rating less than its parent, then keep swapping it out
      # until it fulfills the heap requirement
      while ((last_item.rating < parent_rating) && node_index > 0)
        @items[node_index] = @items[parent_index]
        @items[parent_index] = last_item
        node_index = parent_index
        parent_index = ((node_index - 1) / 2).floor
        parent_rating = @items[parent_index].rating
      end
    else
      child_index_1 = node_index * 2 + 1
      child_index_2 = node_index * 2 + 2
      
      rating1 = (@items[child_index_1] != nil ? @items[child_index_1].rating : 101)
      rating2 = (@items[child_index_2] != nil ? @items[child_index_2].rating : 101)
      
      # If the node has any child nodes, and one of those child nodes has a rating that is lower
      # then swap the node with the lowest child node. Continue until each child has a greater rating
      # or there are no child nodes left
      while ((@items[child_index_1] != nil || @items[child_index_2] != nil) && (last_item.rating > rating1 || last_item.rating > rating2))
        min_rating = [rating1, rating2].min
        child_to_swap = min_rating == rating1 ? child_index_1 : child_index_2
        @items[node_index] = @items[child_to_swap]
        @items[child_to_swap] = last_item
        node_index = child_to_swap
        
        child_index_1 = node_index * 2 + 1
        child_index_2 = node_index * 2 + 2
        
        
        rating1 = (@items[child_index_1] != nil ? @items[child_index_1].rating : 101)
        rating2 = (@items[child_index_2] != nil ? @items[child_index_2].rating : 101)
      end
    end
    
  end
  
  # Data refers to the title
  def find(root, data)
    return nil if data == nil
    item_found = false
    index = 0
    while (item_found != true && index < @items.length)
      if (@items[index].title == data)
        item_found = true
        return @items[index]
      end
      index += 1
    end
    return nil if item_found == false
  end
  
  def printf
    @items.each { |item| puts "#{item.title}: #{item.rating}" }
  end
    
end

root = Node.new("The Big Lebowski", 81)
heap = MinHeap.new(root)
memento = Node.new("Memento", 92)
primer = Node.new("Primer", 71)
looper = Node.new("Looper", 93)
cloud_atlas = Node.new("Cloud Atlas", 66)
american_history_x =Node.new("American History X", 83)
fight_club = Node.new("Fight Club", 79)
shawshank = Node.new("The Shawshank Redemption", 91)
pulp_fiction = Node.new("Pulp Fiction", 94)
forrest_gump = Node.new("Forrest Gump", 72)
ususal_suspects = Node.new("The Usual Suspects", 88)
sandlot = Node.new("The Sandlot", 58)

heap.insert(root, memento)
heap.insert(root, primer)
heap.insert(root, looper)
heap.insert(root, cloud_atlas)
heap.insert(root, american_history_x)
heap.insert(root, fight_club)
heap.insert(root, shawshank)
heap.insert(root, pulp_fiction)
heap.insert(root, forrest_gump)
heap.insert(root, ususal_suspects)
heap.insert(root, sandlot)

heap.printf

require 'benchmark'
puts "-----------------------------------------------------------"
puts "Benchmark Testing:"
puts "Test how long it takes to insert 100,000 numbers"
print Benchmark.measure{
  root = Node.new(1,1)
  heap = MinHeap.new(root)
  (2..100000).each do |number|
    node = Node.new(number, number)
    heap.insert(root, node)
  end
}

puts "Test how long it takes to find the 50,000th element"
root = Node.new(1,1)
heap = MinHeap.new(root)
(2..100000).each do |number|
  node = Node.new(number, number)
  heap.insert(root, node)
end
print Benchmark.measure{
  heap.find(root, 50000)
}

puts "Test how long it takes to delete the 50,000th element"
root = Node.new(1,1)
heap = MinHeap.new(root)
(2..100000).each do |number|
  node = Node.new(number, number)
  heap.insert(root, node)
end
print Benchmark.measure{
  heap.delete(root, 50000)
}

