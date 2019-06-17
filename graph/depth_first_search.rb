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

class DepthFirstSearch
  def initialize(graph, source_vertex)
    @graph = graph
    @source_vertex = source_vertex
    @visited = []
    @edge_to = {}

    dfs(source_vertex)
  end

  # finding any connected vertice is [O(1)] (constant time) after dfs
  # finding a path to this vertex is time [O(n)] (linear time)
  # @param vertex[<Vertex>]
  # return an array of <Vertex> representing the path
  def path_to(vertex)
    return unless has_path_to?(vertex)
    path = []
    current_vertex = vertex

    while(current_vertex != @source_vertex) do
      path.unshift(current_vertex)
      current_vertex = @edge_to[current_vertex]
    end

    path.unshift(@source_vertex)
  end

  private
  def dfs(vertex)
    @visited << vertex
    vertex.adjacents.each do |adjacent_vertex|
      next if @visited.include?(adjacent_vertex)
      dfs(adjacent_vertex)
      @edge_to[adjacent_vertex] = vertex
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
graph.add_edge(@vertex1, @vertex5)
graph.add_edge(@vertex2, @vertex3)
graph.add_edge(@vertex2, @vertex4)
graph.add_edge(@vertex4, @vertex5)

path = DepthFirstSearch.new(graph, @vertex1).path_to(@vertex5)

# puts "path to V5 is V1 -> V2 -> V4 -> V5? #{path[0] == nil}"
puts "path to V5 is V1 -> V2 -> V4 -> V5? #{path == [@vertex1, @vertex2, @vertex4, @vertex5]}"
