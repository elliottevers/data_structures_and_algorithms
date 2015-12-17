require 'pry'

class Link
  attr_accessor :data
  attr_reader :next, :previous

  def initialize(data)
    self.data = data
  end

  def insert_previous(link)
    link.next = self
    link.previous = self.previous
    self.previous.next = link if self.previous
    self.previous = link
    true
  end

  def insert_next(link)
    link.previous = self
    link.next = self.next
    self.next.previous = link if self.next
    self.next = link
    true
  end

  def remove
    self.previous.next, self.next.previous = self.next, self.previous
    self.previous, self.next = nil, nil
  end

  protected
  attr_writer :next, :previous
end

class Sentinel < Link
  def initialize(_end)
    raise "has to be either head or tail" unless [:head, :tail].include?(_end)
    self._end = _end
  end

  def insert_previous(link)
    if _end == :tail
      link.insert_previous(link)
    else
      raise "this is the head of the list"
    end
  end

  def insert_next(link)
    if _end == :head
      link.insert_next(link)
    else
      raise "this is the tail of the list"
    end
  end

  protected
  attr_accessor :_end
end

class DoublyLinkedList
  def initialize
    self.head = Sentinel.new(:head)
    self.tail = Sentinel.new(:tail)
    self.head.send :next=, self.tail
  end

  def push_value(value)
    push_link(Link.new(value))
  end

  def push_link(link)
    tail.insert_previous(link)
    link
  end

  def pop_value
    pop_link.value
  end

  def pop_link
    link = tail.prev
    link.remove
    link
  end

  def shift_value
    shift_link.value
  end

  def shift_link
    link = head.next
    link.remove
    link
  end

  def unshift_value(value)
    unshift_link(Link.new(value))
  end

  def unshift_link(link)
    head.insert_next(link)
    link
  end

  def [](index)
    link = head
    (index + 1).times do |i|
      link = link.next
      raise "range error" if (link == tail && i > 1)
    end
    link
  end

  def []=(index, value)
    link = head
    (index + 1).times do
      link = link.next
      raise "range error" if (link == tail && i > 1)
    end
    link.data = value
  end

  protected
  attr_accessor :head, :tail
end
