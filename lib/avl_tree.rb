require 'pry'

class Object
  def try(method, *args)
    self && self.send(method, *args)
  end
end

class Node
  attr_accessor :value, :parent, :l_node, :r_node, :height

  def initialize(value)
    self.value = value
    self.height = 1
    self.l_node = nil
    self.r_node = nil
    self.parent = nil
  end

  def balance
    (r_node.try(:height) || 0) - (l_node.try(:height) || 0)
  end

  def calculate_height
    self.height = [l_node.try(:height) || 0, r_node.try(:height) || 0].max + 1
  end

  def l_subtree
    if l_node.nil?
      node = Node.new(nil)
      self.l_node = node
      node.parent = self
      AVLTree.new(node)
    else
      tree = AVLTree.new(self.l_node)
    end
  end

  def r_subtree
    if r_node.nil?
      node = Node.new(nil)
      self.r_node = node
      node.parent = self
      AVLTree.new(node)
    else
      tree = AVLTree.new(self.r_node)
    end
  end

  def l_or_r_child?
    return nil if parent.nil?
    parent.right == self ? :right : :left
  end

  def nil?
    self.value.nil?
  end
end

class AVLTree
  attr_reader :root

  def initialize(root)
    @root = root
  end

  def include?(value)
    if root.value == value
      true
    else
      root.l_subtree.include?(value) || root.r_subtree.include?(value)
    end
  end

  def find_vertex_and_parent(value)
    if root.nil?
      [root, root.parent]
    elsif root.value == value
      [root, root.parent]
    elsif value > root.value
      root.r_subtree.find_vertex_and_parent(value)
    else
      root.r_subtree.find_vertex_and_parent(value)
    end
  end

  def insert(value)
    vertex, parent = find_vertex_and_parent(value)

    return false if vertex.value == value

    if vertex.nil?
      vertex.value = value
    end

    true
  end

  def update(vertex)
    return if vertex.nil?

    if vertex.balance == -2
      if vertex.left.balance == 1
        left_rotate(vertex.left)
      end
      right_rotate(vertex)
    else
      if vertex.right.balance == -1
        right_rotate(vertex.right)
      end
      left_rotate(vertex)
    end
    vertex.calculate_height
    update(vertex.parent)
  end

  def left_rotate(parent)
    grandparent = parent.parent
    child_type = parent.l_or_r_child?
    r_child = parent.r_node
    right_then_left = r_child.try(:left)

    if grandparent && child_type == :left
      grandparent.l_node = r_child
    elsif grandparent && child_type == :right
      grandparent.right = r_child
    else
      root = r_child
    end
    r_child.parent = grandparent

    r_child.l_node = parent
    parent.parent = r_child

    parent.r_node = right_then_left
    right_then_left.parent = parent if right_then_left

    parent.calculate_height
  end

  def right_rotate(parent)
    grandparent = parent.parent
    l_or_r_child = parent.l_or_r_child?
    l_child = parent.l_node
    left_then_right = l_child.try(:right)

    if grandparent && l_or_r_child == :left
      grandparent.left = l_child
    elsif grandparent && l_or_r_child == :right
      grandparent.right = l_child
    else
      root = l_child
    end
    l_child.parent = grandparent

    l_child.r_node = parent
    parent.parent = l_child

    parent.l_node = left_then_right
    left_then_right.parent = parent if left_then_right

    parent.calculate_height
  end
end
