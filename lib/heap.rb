require 'pry'

class MinHeap
  attr_accessor :store

  def initialize
    self.store = []
  end

  def print
    p store
  end

  def min
    raise "empty" if store.length == 0
    store[0]
  end

  def extract
    raise "empty" if store == 0
    result = store[0]
    if store.length > 1
      store[0] = store.pop
      heapify_down(store, 0)
    else
      store.pop
    end
    result
  end

  def insert(val)
    store << val
    heapify_up(store, store.length - 1)
  end

  protected

  def child_indices(parent_index)
    [2 * parent_index + 1, 2 * parent_index + 2].select do |i|
      i < store.length
    end
  end

  def parent_index(child_index)
    return nil if child_index == 0
    (child_index - 1) / 2
  end

  def heapify_down(heap, index)
    return if index > (heap.length).fdiv(2)
    l_child_index, r_child_index = child_indices(index)
    parent_value = heap[index]
    min_child_index = l_child_index

    if heap[l_child_index] > heap[r_child_index]
      min_child_index = r_child_index
    end

    if heap[min_child_index] < heap[index]
      heap[index], heap[min_child_index] = heap[min_child_index], heap[index]
      heapify_down(heap, min_child_index)
    end


  end

  def heapify_up(heap, index)
    return if index == 0
    if heap[index] < heap[parent_index(index)]
      heap[index], heap[parent_index(index)] = heap[parent_index(index)], heap[index]
      heapify_up(heap, parent_index(index))
    end
  end
end
