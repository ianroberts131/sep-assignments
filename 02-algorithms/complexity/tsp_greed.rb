class Vertex
  attr_accessor :name, :neighbors, :distances, :visited
  
  def initialize(name)
    @name = name
    @visited = false
    @neighbors = []
    @distances = []
  end
end

class Graph
  attr_accessor :vertices
  
  def initialize
    @vertices = []
  end
  
  def add_vertex(name)
    @vertices << Vertex.new(name)
  end
  
  def find_vertex_by_name(name)
    vertices.each do |v|
      return v if v.name == name
    end
    nil
  end
  
  def count
    vertices.length
  end
  
  def add_edge(city1, city2, distance)
    
    from = vertices.index { |v| v.name == city1 }
    to = vertices.index { |v| v.name == city2 }
    
    if (city1 == city2)
      vertices[from].neighbors[from] = nil
      vertices[from].distances[from] = nil
    else
      vertices[from].neighbors[to] = city2
      vertices[to].neighbors[from] = city1
      vertices[from].distances[to] = distance
      vertices[to].distances[from] = distance
    end
  end
end

graph = Graph.new

cities = ["San Diego", "Los Angeles", "Chicago", "New York", "Portland", "San Francisco", "Austin", "Charleston"]

cities.each do |city|
  graph.add_vertex(city)
end

graph.add_edge("San Diego", "Los Angeles", 121)
graph.add_edge("San Diego", "Chicago", 2077)
graph.add_edge("San Diego", "New York", 2761)
graph.add_edge("San Diego", "Portland", 1083)
graph.add_edge("San Diego", "San Francisco", 502)
graph.add_edge("San Diego", "Austin", 1300)
graph.add_edge("San Diego", "Charleston", 2446)
graph.add_edge("Los Angeles", "Chicago", 2016)
graph.add_edge("Los Angeles", "New York", 2789)
graph.add_edge("Los Angeles", "Portland", 963)
graph.add_edge("Los Angeles", "San Francisco", 382)
graph.add_edge("Los Angeles", "Austin", 1378)
graph.add_edge("Los Angeles", "Charleston", 2480)
graph.add_edge("Chicago", "New York", 790)
graph.add_edge("Chicago", "Portland", 2119)
graph.add_edge("Chicago", "San Francisco", 2131)
graph.add_edge("Chicago", "Austin", 1164)
graph.add_edge("Chicago", "Charleston", 913)
graph.add_edge("New York", "Portland", 2894)
graph.add_edge("New York", "San Francisco", 2906)
graph.add_edge("New York", "Austin", 1742)
graph.add_edge("New York", "Charleston", 758)
graph.add_edge("Portland", "San Francisco", 636)
graph.add_edge("Portland", "Austin", 2054)
graph.add_edge("Portland", "Charleston", 2896)
graph.add_edge("San Francisco", "Austin", 1759)
graph.add_edge("San Francisco", "Charleston", 2780)
graph.add_edge("Austin", "Charleston", 1257)
graph.add_edge("Charleston", "Charleston", 0)


# The name input is a string
def nsp(graph, city_name)
  current_city = graph.find_vertex_by_name(city_name)
  path = [current_city.name]
  while (current_city.visited == false)
    
    # Initialize an array to house the path
    
    
    # Initialize a shortest distance local variable to infinity
    shortest_distance = 1.0 / 0.0
    
    next_city_name = current_city.neighbors[0]
    next_city_vertex = graph.find_vertex_by_name(next_city_name)
    current_city.distances.each_with_index do |distance, index|

      next if distance == nil
      next if graph.vertices[index].visited == true
  
      if (distance < shortest_distance)
        shortest_distance = distance
        next_city_vertex = graph.vertices[index]
      end
    end

    path << next_city_vertex.name if (next_city_vertex.visited == false)
    
    current_city.visited = true
    current_city = next_city_vertex
  end
  return path
end

puts "The path is: #{nsp(graph, "San Diego")}"

puts "The vistited tags are #{graph.vertices.each { |vertex| puts "the city #{vertex.name} has visited tag #{vertex.visited}" }}"