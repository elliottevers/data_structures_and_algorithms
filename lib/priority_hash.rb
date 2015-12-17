require_relative 'heap'

class PriorityHash
  attr_accessor :store, :heap

  def initialize()
    self.store = {}
    self.heap = MinHeap.new
  end

  def [](key)
    self.store[key]
  end

  def []=(key, value)
    if self.store.has_key?(key)
      update(key, value)
    else
      insert(key, value)
    end
  end

  def size
    self.store.size
  end

  def extract
    key = self.heap.extract
    value = self.store.delete(key)
    [key, value]
  end

  def has_key?(key)
    self.store.has_key?(key)
  end

  protected

  def insert(key, value)
    self.store[key] = value
    self.heap.push(key)
  end

  def update(key, value)
    self.store[key] = value
    self.heap.reduce!(key)
  end
end
