Node = Struct.new(:value, :parent, :left_child, :right_child)

class BinarySearchTree

  def initialize(arg)
    raise ArgumentError unless arg.is_a? Array
    raise ArgumentError if arg.any?{|val| !(val.is_a? Integer)}
    @count = 1
    @tree = generate_tree(arg)
  end

  def generate_tree(arg)
    current_val = Node.new(arg[0], nil, nil, nil)

    arg = arg[1..-1]

    result_tree = [current_val]
    until arg.empty?
      next_val = arg.shift

      place_child(next_val, current_val)
      @count += 1

    end
    result_tree
  end

  def place_child(next_val, current_val)
    if next_val > current_val.value
      if current_val.right_child.nil?
        current_val.right_child = Node.new(next_val, current_val, nil, nil)
      else
        place_child(next_val, current_val.right_child)
      end
    else
      if current_val.left_child.nil?
        current_val.left_child = Node.new(next_val, current_val, nil, nil)
      else
        place_child(next_val, current_val.left_child)
      end
    end
  end

  def count
    @count
  end

  def find_node_with_value(val)
    queue = [root]
    until queue.empty?
      current = queue.shift
      if current.value == val
        return current
      else
        queue << current.left_child unless current.left_child.nil?
        queue << current.right_child unless current.right_child.nil?
      end
    end

    return nil
  end

  # This obviously isn't actually working. 6 tests fail.
  def sorted_array
    result = []
    stack = [root]
    until stack.empty?
      current = stack.shift
      result << current.value unless current.value.nil?
      stack << current.left_child unless current.left_child.nil?
      stack << current.right_child unless current.right_child.nil?
    end
    result.sort
  end

  def min
    sorted_array.first
  end

  def max
    sorted_array.last
  end

  def root
    @tree[0]
  end
end