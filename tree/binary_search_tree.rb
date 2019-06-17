class Node
  attr_reader :key, :left, :right

  def initialize(key)
    @key = key
    @left = nil # [Node]
    @right = nil # [Node]
  end

  def insert(new_key)
    if new_key <= @key
      @left.nil? ? @left = Node.new(new_key) : @left.insert(new_key)
    else
      @right.nil? ? @right = Node.new(new_key) : @right.insert(new_key)
    end
  end
end

class BinarySearchTree
  def initialize(root_node = nil)
    @root = root_node
  end

  def insert(key)
    if @root.nil?
      @root = Node.new(key)
    else
      @root.insert(key)
    end
  end

  def in_order(node = @root, &block)
    return if node.nil?

    in_order(node.left, &block)
    yield node
    in_order(node.right, &block)
  end

  def pre_order(node = @root, &block)
    return if node.nil?

    yield node
    in_order(node.left, &block)
    in_order(node.right, &block)
  end

  def post_order(node = @root, &block)
    return if node.nil?

    in_order(node.left, &block)
    in_order(node.right, &block)
    yield node
  end

  def search(key, node = @root)
    return nil if node.nil?

    return node if key == node.key

    if key < node.key
      search(key, node.left)
    else
      search(key, node.right)
    end
  end

  # NOTE: definition of a balanced tree
  # * The left and right subtrees' heights differ by at most one, AND
  # * The left subtree is balanced, AND
  # * The right subtree is balanced
  # ref: https://stackoverflow.com/questions/8015630/definition-of-a-balanced-tree
  #
  # EXAMPLE: a balanced tree
  #      A (h=3)
  #       /     \
  #   B(h=1)     C (h=2)
  #   /          /   \
  # D (h=0)  E(h=0)  F (h=1)
  #                  /
  #                G (h=0)
  #
  # EXAMPLE: NOT a balanced tree
  #      A (h=3)
  #     /     \
  # B(h=0)     C (h=2)  <-- Unbalanced: 2-0 =2 > 1
  #           /     \
  #         E(h=1)   F (h=0)
  #         /    \
  #     H (h=0)  G (h=0)

  def check_height(node)
    return 0 if node.nil?

    leftHeight = check_height(node.left)
    return -1 if leftHeight == -1

    rightHeight = check_height(node.right)
    return -1 if rightHeight == -1

    diff = leftHeight - rightHeight
    height = nil

    if diff.abs > 1
      height = -1
    else
      height = [leftHeight, rightHeight].max + 1
    end

    height
  end

  def is_balanced?(node = @root)
    check_height(node) == -1 ? false : true
  end
end

def construct_tree(*keys)
  tree = BinarySearchTree.new

  keys.each { |key| tree.insert(key) }

  tree
end

tree = construct_tree(50, 25, 75, 12, 37, 87, 63)
puts tree.inspect
puts "is tree balanced? #{tree.is_balanced?}"

puts "printing pre_order..."
tree.pre_order do |node|
  puts node.key
end

puts "printing in_order..."
tree.in_order do |node|
  puts node.key
end

puts "printing post_order..."
tree.post_order do |node|
  puts node.key
end

puts "searching key 75... #{tree.search(75) ? "found" : "not found"}"
puts "searching key 36... #{tree.search(36) ? "found" : "not found"}"
