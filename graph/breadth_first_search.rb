require "set"

class Vertex
  attr_accessor :name, :adjacents

  def initialize(name)
    # Set implements a collection of unordered values with no duplicates(ri doc)
    @adjacents = Set.new
    @name = name
  end

  def to_s
    @name
  end
end

# undirected graph
class Graph
  def add_edge(vertex_a, vertex_b)
    vertex_a.adjacents << vertex_b
    vertex_b.adjacents << vertex_a
  end
end

class BreadthFirstSearch
  def initialize(graph, source_vertex)
    @graph = graph
    @source_vertex = source_vertex
    @visited = []
    @edge_to = {}

    bfs(source_vertex)
  end

  # @param vertex[<Vertex>]
  # return an array of <Vertex> representing the path
  def shortest_path_to(vertex)
    return unless has_path_to?(vertex)
    path = []

    while(vertex != @source_vertex) do
      path.unshift(vertex) # unshift adds the vertex to the beginning of the array
      vertex = @edge_to[vertex]
    end

    path.unshift(@source_vertex)
  end

  private

  def bfs(vertex)
    # mark visited vertex by storing them in visited array, ensure only visit once
    # queue contains vertex to visite, always pop out the 1st element in the queue
    queue = []
    queue << vertex
    @visited << vertex

    # Repeat until the queue is empty:
    # - Remove the least recently added vertex n
    # - add each of n's unvisited adjacents to the queue and mark them as visited
    while queue.any?
      current_vertex = queue.shift # remove first element
      current_vertex.adjacents.each do |adjacent_vertex|
        next if @visited.include?(adjacent_vertex)
        queue << adjacent_vertex
        @visited << adjacent_vertex
        @edge_to[adjacent_vertex] = current_vertex
      end
    end
  end

  def has_path_to?(vertex)
    @visited.include?(vertex)
  end
end

@vertex1 = Vertex.new("Vertex #1")
@vertex2 = Vertex.new("Vertex #2")
@vertex3 = Vertex.new("Vertex #3")
@vertex4 = Vertex.new("Vertex #4")
@vertex5 = Vertex.new("Vertex #5")

graph = Graph.new
graph.add_edge(@vertex1, @vertex2)
graph.add_edge(@vertex2, @vertex3)
graph.add_edge(@vertex2, @vertex4)
graph.add_edge(@vertex4, @vertex5)
graph.add_edge(@vertex1, @vertex5)

path = BreadthFirstSearch.new(graph, @vertex1).shortest_path_to(@vertex5)

puts "shortest path to V5 is V1 -> V5? #{path == [@vertex1, @vertex5]}"
