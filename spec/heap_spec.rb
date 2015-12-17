require 'rspec'
require_relative '../lib/heap'

describe MinHeap do

  describe "heap operation" do
    it "has a store that starts empty" do
      heap = MinHeap.new
      expect(heap.send(:store)).to eq([])
    end

    it "inserts correctly" do
      heap = MinHeap.new
      heap.insert(7)
      expect(heap.send(:store)).to eq([7])

      heap.insert(5)
      expect(heap.send(:store)).to eq([5, 7])

      heap.insert(6)
      expect(heap.send(:store)).to eq([5, 7, 6])

      heap.insert(4)
      expect(heap.send(:store)).to eq([4, 5, 6, 7])
    end

    it "extracts correctly" do
      heap = MinHeap.new
      [7, 5, 6, 4].each { |el| heap.insert(el) }

      expect(heap.extract).to eq(4)
      expect(heap.send(:store)).to eq([5, 7, 6])

      expect(heap.extract).to eq(5)
      expect(heap.send(:store)).to eq([6, 7])
    end
  end
end
