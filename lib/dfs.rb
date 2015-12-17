require_relative 'graph'

def dfs(start_vertex, target_value)
  stack = []
  reached_from_edge_store = {}
  stack << start_vertex

  until stack.empty? do
    stack.pop.out_edges.each do |edge|
      stack << edge.to_vertex
      reached_from_edge_store[edge.to_vertex] = edge
      if edge.to_vertex.value == target_value
        found_vertex = edge.to_vertex
        break
      end
    end
  end

  previous_vertex = reached_from_edge_store[found_vertex]
  shortest_path_edges = []

  until previous_vertex == start_vertex do
    shortest_path_edges << previous_vertex
    previous_vertex = reached_from_edge_store[previous_vertex]
  end

  shortest_path_edges

end
