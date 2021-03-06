class Vertex
  attr_reader :value, :in_edges, :out_edges

  def initialize(value)
    @value = value
    @in_edges = []
    @out_edges = []
  end
end

class Edge
  attr_reader :to_vertex, :from_vertex, :weight

  def initialize(from_vertex, to_vertex, weight = 1)
    self.to_vertex = to_vertex
    self.from_vertex = from_vertex

    to_vertex.in_edges << self
    from_vertex.out_edges << self

    self.weight = weight
  end

  def delete
    self.to_vertex.out_edges.delete(self)
    self.from_vertex.in_edges.delete(self)
    self.to_vertex = nil
    self.from_vertex = nil
  end

  protected
  attr_writer :from_vertex, :to_vertex, :weight
end
