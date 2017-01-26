# class Node
#   attr_accessor :id, :name, :film_actor_hash
  
#   def initialize(id, name)
#     @name = name
#   end
# end

class AdjMatrix
  attr_accessor :root, :actors_array, :matrix, :film_hash
  
  def initialize(root)
    @actors_array = [root]
    @matrix = [[0]]
    @film_hash = {}
  end
  
  # Adds a film as the key, with an array of actors as the value
  def add_film(name, actors)
    @film_hash[name] = actors
    
    current_actors = @actors_array.length
    actors_to_add = 0
    
    actors.each do |actor|
      if index(actor) == nil
        actors_to_add += 1
        @actors_array << actor
        @matrix += [[0] * current_actors] 
      end
    end
    
    @matrix.each_with_index do |array, index|
      @matrix[index] = array + [0] * (actors_to_add)
    end
    
    actors.each do |actor_to_insert|
      @film_hash.each do |film, film_array|
        if (film_array.index(actor_to_insert) != nil)
          film_array.each do |actor|
            if (actor_to_insert == actor)
              next
            end
            actor_to_insert_index = index(actor_to_insert)
            actor_index = index(actor)
            matrix[actor_to_insert_index][actor_index] = 1
            matrix[actor_index][actor_to_insert_index] = 1
          end
        end
      end
    end
  end
  
  # returns the actor's index if it exists, nil otherwise
  def index(actor_name)
    @actors_array.index(actor_name)
  end
  
  # Breadth first search to find shortest path from actor to Kevin Bacon
  def find_kevin_bacon(actor_name)
    node_queue = [0]
    
    loop do
      curr_node = node_queue.pop
      
      return false if curr_node == nil
      if curr_node == index(actor_name)
        puts "Curr node is #{curr_node}"
        return true
      end
      matrix_size = @matrix.length
      
      children = (0..matrix_size-1).to_a.select do |i|
        @matrix[curr_node][i] == 1
      end
      
      node_queue = children + node_queue
      
    
    end
  end
  
  def print_matrix
    field_size = @matrix.flatten.collect{|i|i.to_s.size}.max
    @matrix.each do |row|
      index = @matrix.index(row)
      if index < 10
        print "#{index}:  #{@actors_array[index]}" + " " * (25 - @actors_array[index].length)
      else
        print "#{index}: #{@actors_array[index]}" + " " * (25 - @actors_array[index].length)
      end
      puts (row.collect{|i| ' ' * (field_size - i.to_s.size) + i.to_s}).join('  ')    
    end
  end
end


matrix = AdjMatrix.new("Kevin Bacon")

footloose = ["Kevin Bacon", "Lori Singer", "John Lithgow", "Dianne West", "Chris Penn", "Sarah Jessica Parker", "John Laughlin", "Elizabeth Gorcey", "Frances Lee McCain", 
              "Jim Youngs", "Douglas Dirkson", "Lynne Marta", "Arthur Rosenburg", "Timothy Scott", "Alan Haufrect"]

interstellar = ["Ellen Burstyn", "Matthew McConaughey", "Mackenzie Foy", "John Lithgow", "Timothee Chalamet", "David Oyelowo", "Collette Wolfe", "Francis McCarthy", "Bill Irwin",
                "Anne Hathaway", "Andrew Borba", "Wes Bentley", "William Devane", "Michael Caine", "David Gyasi"]

matrix.add_film("Footloose", footloose)
puts "The matrix size is: #{matrix.matrix.length}"
matrix.print_matrix
matrix.add_film("Interstellar", interstellar)
puts "The matrix size is: #{matrix.matrix.length}"
matrix.print_matrix

puts "We're gonna find Wes Bentley"
puts "#{matrix.find_kevin_bacon("Wes Bentley")}"
