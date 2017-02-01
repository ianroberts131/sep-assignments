class Node
  attr_accessor :index, :name, :visited, :back_pointer, :movies
  
  def initialize(name)
    @name = name
    @visited = false
    @index = nil
    @movies = []
  end
end

class AdjMatrix
  attr_accessor :actors_array, :matrix, :film_hash
  
  def initialize(name)
    root = Node.new(name)
    root.index = 0
    @actors_array = [root]
    @matrix = [[0]]
    @film_hash = {}
  end
  
  # Adds a film as the key, with an array of actors as the value
  def add_film(name, actors)
    actors_node_array = actors.map { |actor| Node.new(actor) }
    @film_hash[name] = actors
    current_actors = @actors_array.length
    actors_to_add = 0
    
    actors_node_array.each do |actor_node|
      if (find_index(actor_node.name) == nil)
        actors_to_add += 1
        actor_node.index = @actors_array.length
        @actors_array << actor_node
        actor_node.movies << name
        @matrix += [[0] * current_actors] 
      else
        actor_index = find_index(actor_node.name)
        actors_array[actor_index].movies << name
      end
    end
    @matrix.each_with_index do |array, index|
      @matrix[index] = array + [0] * (actors_to_add)
    end

    actors_node_array.each do |actor_to_insert|
      @film_hash.each do |film, film_array|
        # If the actor is in a film, give association with every actor in that film
        if (film_array.index(actor_to_insert.name) != nil)
          film_array.each do |actor|
            if (actor_to_insert.name == actor)
              next
            end
            actor_to_insert_index = find_index(actor_to_insert.name)
            actor_index = find_index(actor)
            matrix[actor_to_insert_index][actor_index] = 1
            matrix[actor_index][actor_to_insert_index] = 1
          end
        end
      end
    end
  end
  
  # returns the actor's index if it exists, nil otherwise
  def find_index(actor_name)
    current_index = 0
    actor_found = false
    while (current_index < @actors_array.length)
      if (actor_name == @actors_array[current_index].name)
        actor_found = true
        break
      end
      current_index += 1
    end
    
    return actor_found ? current_index : nil
    
  end
  
  # Actor parameters are entered as names
  def find_common_movie(actor1, actor2)
    actor1_index = find_index(actor1)
    actor2_index = find_index(actor2)
    
    actor1_node = @actors_array[actor1_index]
    actor2_node = @actors_array[actor2_index]
    
    actor1_node.movies.each do |movie|
      if actor2_node.movies.index(movie) != nil
        return movie
      end
    end
  end
  
  # Breadth first search to find shortest path from actor to Kevin Bacon
  def find_kevin_bacon(actor_name)
    node_queue = [0]
    
    loop do
      curr_node = node_queue.pop
      
      return false if curr_node == nil
      if curr_node == find_index(actor_name)
        node = @actors_array[curr_node]
        actors = [node.name]
        while (node.back_pointer != 0)
          actors << @actors_array[node.back_pointer].name
          node = @actors_array[node.back_pointer]
        end
        
        actors << @actors_array[0].name
        return_string = ""
        index = 0
        
        while (index < actors.length - 1)
        actor1 = actors[index]
        actor2 = actors[index + 1]
          common_movie = find_common_movie(actor1, actor2)
          string = "#{actor1} acted in #{common_movie} with #{actor2}\n"
          return_string += string
          index += 1
        end
        return return_string
      end
      matrix_size = @matrix.length
      # puts "The curr node is #{curr_node}"
      children = (0..matrix_size-1).to_a.select do |i|
        @matrix[curr_node][i] == 1
      end
      # puts "The children of curr node are #{children.inspect}"
      
      children.each do |child|
        unless @actors_array[child].visited == true
          @actors_array[child].back_pointer = curr_node
          @actors_array[child].visited = true
        end
      end
      
      node_queue = children + node_queue
      
    end
  end
  
  def print_matrix
    @matrix.each do |row|
      index = @matrix.index(row)
      if index < 10
        print "#{index}:  #{@actors_array[index].name}" + " " * (25 - @actors_array[index].name.length)
      else
        print "#{index}: #{@actors_array[index].name}" + " " * (25 - @actors_array[index].name.length)
      end
      puts (row.collect{|i| i.to_s}).join('  ')    
    end
  end
end


matrix = AdjMatrix.new("Kevin Bacon")

footloose = ["Kevin Bacon", "Lori Singer", "John Lithgow", "Dianne West", "Chris Penn", "Sarah Jessica Parker", "John Laughlin", "Elizabeth Gorcey", "Frances Lee McCain", 
              "Jim Youngs", "Douglas Dirkson", "Lynne Marta", "Arthur Rosenburg", "Timothy Scott", "Alan Haufrect"]

interstellar = ["Ellen Burstyn", "Matthew McConaughey", "Mackenzie Foy", "John Lithgow", "Timothee Chalamet", "David Oyelowo", "Collette Wolfe", "Francis McCarthy", "Bill Irwin",
                "Anne Hathaway", "Andrew Borba", "Wes Bentley", "William Devane", "Michael Caine", "David Gyasi"]

wolf_of_wallstreet = ["Leonardo DiCaprio", "Jonah Hill", "Margot Robbie", "Matthew McConaughey", "Kyle Chandler", "Rob Reiner", "Jon Bernthal", "Jon Favreau", "Jean Dujardin",
                      "Joanna Lumley", "Cristin Milloti", "Christine Ebersole", "Shea Whigham", "Katarina Cas", "P.J. Byrne"]


matrix.add_film("Footloose", footloose)
matrix.print_matrix
matrix.add_film("Interstellar", interstellar)
matrix.print_matrix
matrix.add_film("Wolf of Wallstreet", wolf_of_wallstreet)
matrix.print_matrix

puts "We're gonna find Matthew McConaughey's Bacon connection..."
puts "#{matrix.find_kevin_bacon("Matthew McConaughey")}"

puts "We're gonna find Ron Reiner's Bacon connection..."
puts "#{matrix.find_kevin_bacon("Rob Reiner")}"

