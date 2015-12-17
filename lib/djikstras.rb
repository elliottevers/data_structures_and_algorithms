require '../lib/priority_hash'
require 'pry'

def dijkstras(start_vertex)
  paths = PriorityHash.new
  paths[start_vertex] = { cost: 0, last_edge: nil }

  best_paths = {}

  until paths.empty?
    vertex, data = paths.extract
    best_paths[vertex] = data
    recalculate_paths(vertex, best_paths, paths)
  end

  best_paths
end

def recalculate_paths(vertex, best_paths, paths)

  current_path_cost = best_paths[vertex][:cost]

  vertex.out_edges.each do |edge|
    to_vertex = edge.to_vertex
    next if best_paths.has_key?(to_vertex)
    new_cost = current_path_cost + edge.cost
    next if paths[to_vertex][:cost] <= new_cost
    paths[to_vertex] = {cost: new_cost, last_edge: edge}
  end

end
