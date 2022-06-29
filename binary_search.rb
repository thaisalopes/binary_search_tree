class Node
  attr_accessor :left, :right, :data

  def initialize(data)
    @data = data
    @left = nil
    @right = nil
  end
end

class Tree
  attr_accessor :root

  def initialize(array)
    @root = build_tree(array)
  end

  def build_tree(array)
    return nil if array.empty?
    mid = array.length / 2
    root = Node.new(array[mid])
    root.left = build_tree(array[0...mid])
    root.right = build_tree(array[(mid+1)..])
    return root
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end

  def insert(value, root =@root)
    return Node.new(value) if root.nil?
    if root.data == value
      return root
    elsif root.data < value
      root.right = insert(value, root.right)
    else
      root.left = insert(value, root.left)
    end
    return root
  end

  def delete_value(value, root=@root)
    return root if root.nil?

    if value < root.data
      root.left = delete_value(value, root.left)
    elsif value > root.data
      root.right = delete_value(value, root.right)
    else
      return root.right if root.left.nil?
      return root.left if root.right.nil?
      root.data = minValue(root.right)
      root.right = delete_value(root.data, root.right)
    end
    return root
  end

  def minValue(root)
    minv = root.data
    until root.left.nil?
      minv = root.left.data
      root = root.left
    end
    minv
  end

  def find(value, root = @root)
    return "No match" if root.nil?
    if value == root.data
      return root
    elsif value > root.data
      return find(value, root.right)
    else
      return find(value, root.left)
    end
  end

end

class Array
  def prep_array
    self.uniq.sort
  end
end

array = [0, 20, -1, 8, 20, 1, 2, 0, 99, 56, 54, 9]
prepped_array = array.prep_array
tree = Tree.new(prepped_array)
#tree.insert(133)
#tree.insert(21)
#tree.pretty_print
#tree.delete_value(9)
#tree.pretty_print
p tree.find(99)