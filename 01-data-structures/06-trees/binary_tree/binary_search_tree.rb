require_relative 'node'

class BinarySearchTree
  attr_accessor :root
  # attr_accessor :items

  def initialize(root)
    @root = root
    # @items =[@root]
  end

  def insert(root, node)
    return nil if node == nil
    # Base Case 1: Node is less than parent node and left node unfilled
    if (node.rating <= root.rating && root.left == nil)
      root.left = node
      node.parent = root
      # parent_index = @items.index(root)
      # child_index = parent_index * 2 + 1
      # if (child_index >= @items.length)
        # items_to_add = ( ( @items.length + 1 ) / 2 ) * 2
        # @items + Array.new(items_to_add)
      # end
      
      # @items[child_index] = node
      return node
    end
    
    # Base Case 2: Node is greater than parent node and right node unfilled
    if (node.rating >= root.rating && root.right == nil)
      root.right = node
      node.parent = root
      parent_index = @items.index(root)
      child_index = parent_index * 2 + 2
      if (child_index >= @items.length)
        items_to_add = ( ( @items.length + 1 ) / 2 ) * 2
        @items + Array.new(items_to_add)
      end
      
      @items[child_index] = node
      return node
    end
    
    # If appropriate node is not available for insertion, recursively search until 1 is found
    if (node.rating <= root.rating && root.left != nil)
      insert(root.left, node)
    elsif (node.rating >= root.rating && root.right != nil)
      insert(root.right, node)
    end
  end

  # Recursive Depth First Search
  # Data refers to the title
  def find(root, data)
    return nil if data == nil
    return nil if root == nil
    
    if (root.title == data)
      return root
    end
    
    return find(root.right, data) ? find(root.right, data) : find(root.left, data)
  end

  def delete(root, data)
    return nil if data == nil
    item = find(root, data)
    parent = item.parent
    
    direction = ""
    
    parent.right == item ? direction = "right" : direction = "left"
    
    if (item.left == nil && item.right == nil)
      direction == "right" ? parent.right = nil : parent.left = nil
    elsif (item.left != nil && item.right == nil)
      direction == "right" ? parent.right = item.left : parent.left = item.left
    elsif (item.left == nil && item.right != nil)
      direction == "right" ? parent.right = item.right : parent.left = item.right
    elsif (item.left != nil && item.right != nil)
      # find the item with the lowest rating in the right tree
      # replace the item to be deleted with the values of the lowest item
      # delete the replacement item from its original location
      array = [item.right]
      array << item.right.left if item.right.left
      array << item.right.right if item.right.right
      
      min = array.min
      
      item.title = min.title
      item.rating = min.rating
      
      delete(item.right, min)
    end
  end

  # Recursive Breadth First Search
  def printf(children=nil)
    queue = Queue.new
    queue << root
    
    while queue.empty? == false
      current = queue.deq
      puts "#{current.title}: #{current.rating}"
      queue << current.left if current.left
      queue << current.right if current.right
    end
  end
end

root = Node.new("The Big Lebowski", 81)
tree = BinarySearchTree.new(root)
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

tree.insert(root, memento)
tree.insert(root, primer)
tree.insert(root, looper)
tree.insert(root, cloud_atlas)
tree.insert(root, american_history_x)
tree.insert(root, fight_club)
tree.insert(root, shawshank)
tree.insert(root, pulp_fiction)
tree.insert(root, forrest_gump)
tree.insert(root, ususal_suspects)
tree.insert(root, sandlot)

tree.printf

require 'benchmark'
puts "-----------------------------------------------------------"
puts "Benchmark Testing:"
puts "Test how long it takes to insert 100,000 numbers"
print Benchmark.measure{
  root = Node.new(1,1)
  tree = BinarySearchTree.new(root)
  (2..100000).each do |number|
    node = Node.new(number, number)
    tree.insert(root, node)
  end
}

# puts "Test how long it takes to find the 50,000th element"
# root = Node.new(1,1)
# tree = BinarySearchTree.new(root)
# (2..100000).each do |number|
#   node = Node.new(number, number)
#   tree.insert(root, node)
# end
# print Benchmark.measure{
#   tree.find(root, 50000)
# }

# puts "Test how long it takes to delete the 50,000th element"
# root = Node.new(1,1)
# tree = BinarySearchTree.new(root)
# (2..100000).each do |number|
#   node = Node.new(number, number)
#   tree.insert(root, node)
# end
# print Benchmark.measure{
#   tree.delete(root, 50000)
# }
