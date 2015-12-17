require_relative '../lib/linked_list'
require 'pry'

describe DoublyLinkedList do
  before(:each){@list = DoublyLinkedList.new}
  
  it "pushes links" do
    (1..3).each do {|i| @list.push_link(Link.new(i))}
    (1..3).each do |i|
      expect(@list[i].data).to eq i
    end
  end

  it "pushes values" do
    (1..3).each do {|i| @list.push_link(i)}
    (1..3).each do |i|
      expect(@list[i].data).to eq i
    end
  end

end
