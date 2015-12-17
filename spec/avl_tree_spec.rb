require 'rspec'
require_relative '../lib/avl_tree'
require 'pry'

describe AVLTree do
  it 'works' do
    node = Node.new(1)
    tree = AVLTree.new(node)
    (2..10).each do |i|
      tree.insert(i)
    end
    node1, parent1 = tree.find_vertex_and_parent(10)
    expect(node1.value).to eq 10
    expect(node1.parent.value).to eq 9
    node2, parent2 = tree.find_vertex_and_parent(5)
    expect(node2.value).to eq 5
    expect(node2.parent.value).to eq 6
    node3, parent3 = tree.find_vertex_and_parent(1)
    expect(node3.value).to eq 1
    expect(node3.parent.value).to eq 2
    expect(tree.root.height).to eq 4
  end
end
