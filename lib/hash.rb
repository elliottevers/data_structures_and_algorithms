require 'pry'

class HashImplementation
  DEFAULT_SIZE = 8
  LOAD_FACTOR = 1

  attr_reader :num_of_values

  def initialize
    self.buckets = Array.new(DEFAULT_SIZE) { [] }
    self.num_of_values = 0
  end

  def insert(value)
    return false if include?(value)
    resize if (num_of_values + 1).fdiv(buckets.length) > LOAD_FACTOR
    correct_bucket(value) << value
    self.num_of_values += 1
    true
  end

  def delete(value)
    return unless include?(value)
    bucket_for(value).delete(value)
    self.num_of_values -= 1
  end

  def include?(value)
    correct_bucket(value).include?(value)
  end

  protected
  attr_accessor :buckets
  attr_writer :num_of_values

  def resize
    resized = Array.new(buckets.length * 2){[]}
    buckets.each do |bucket|
      bucket.each do |value|
        resized[hash(value) % buckets.length] << value
      end
    end
    self.buckets = resized
  end

  def correct_bucket(value)
    buckets[hash(value) % buckets.length]
  end

  def hash(value)
    value.hash
  end
end
