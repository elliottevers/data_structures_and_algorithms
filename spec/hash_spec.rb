require 'pry'
require_relative '../lib/hash'

describe HashImplementation do
  it 'stores a variety of items' do
    array = Array.new
    number = 10
    string = "string"
    hash = HashImplementation.new
    hash.insert(array)
    hash.insert(number)
    hash.insert(string)
    expect(hash.num_of_values).to eq 3
  end

  it 'resizes' do
    hash = HashImplementation.new
    (0..7).each do |value|
      hash.insert(value)
    end
    hash.insert("this will fail")
    expect(hash.num_of_values).to be > 8
  end
end
