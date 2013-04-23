##
# AvlTree Test
assert("AvlTree#insert") do
  tree = AvlTree.new
  tree.insert 'C', 1
  1 == tree.root.value
end

assert("AvlTree right insertion") do
  tree = AvlTree.new
  tree.insert 'A', 1
  tree.insert 'B', 2
  'B' == tree.right.key
end

assert("AvlTree left insertion") do
  tree = AvlTree.new
  tree.insert 'B', 2
  tree.insert 'A', 1
  'A' == tree.left.key
end

assert('AvlTree update with insert') do
  tree = AvlTree.new
  tree.insert 'A', 1
  tree.insert 'A', 2
  2 == tree['A']
end

assert('AvlTree update with hash like access') do
  tree = AvlTree.new
  tree.insert 'A', 1
  tree['A'] = 2
  2 == tree['A']
end

assert('AvlTree hash like access') do
  tree = AvlTree.new
  tree.insert 'A', 1
  tree.insert 'B', 2
  tree.insert 'C', 3
  3 == tree['C']
  2 == tree['B']
  1 == tree['A']
end

assert('AvlTree not found') do
  tree = AvlTree.new
  nil == tree['D']
end

assert('AvlTree rotate left') do
  tree = AvlTree.new
  tree.insert 'C', 1
  tree.insert 'D', 2
  tree.insert 'E', 3
  'C' == tree.left.key
  'E' == tree.right.key
end

assert('AvlTree rotate right') do
  tree = AvlTree.new
  tree.insert 'E', 1
  tree.insert 'D', 2
  tree.insert 'C', 3
  'C' == tree.left.key
  'E' == tree.right.key
end

assert('AvlTree double rotate right left') do
  tree = AvlTree.new
  tree.insert 5, 1
  tree.insert 9, 1
  tree.insert 7, 1
  7 == tree.root.key
end

assert('AvlTree double rotate left right') do
  tree = AvlTree.new
  tree.insert 9, 1
  tree.insert 5, 1
  tree.insert 7, 1
  7 == tree.root.key
end

assert('AvlTree multi generation right side build') do
  tree = AvlTree.new
  tree.insert 'C', nil
  tree.insert 'D', nil
  tree.insert 'E', nil
  tree.insert 'F', nil
  tree.insert 'G', nil
  tree.insert 'H', nil
  tree.insert 'I', nil

  'D' == tree.left.key
  'C' == tree.left.left.key
  'E' == tree.left.right.key
  'H' == tree.right.key
  'G' == tree.right.left.key
  'I' == tree.right.right.key
end

assert('AvlTree multi generation left side build') do
  tree = AvlTree.new
  tree.insert 'G', nil
  tree.insert 'F', nil
  tree.insert 'E', nil
  tree.insert 'D', nil
  tree.insert 'C', nil
  tree.insert 'B', nil
  tree.insert 'A', nil


  'B' == tree.left.key
  'A' == tree.left.left.key
  'C' == tree.left.right.key
  'F' == tree.right.key
  'E' == tree.right.left.key
  'G' == tree.right.right.key
end

assert('AvlTree delete root') do
  tree = AvlTree.new
  tree.insert 'A', 1
  tree.delete 'A'
  true == tree.root.is_a?(AvlTree::Node::TerminalNode)
end

assert('AvlTree delete barren child') do
  tree = AvlTree.new
  tree.insert 'A', 1
  tree.insert 'B', 2
  tree.delete 'B'
  true == tree.right.is_a?(AvlTree::Node::TerminalNode)
end

assert('AvlTree delete with single child') do
  tree = AvlTree.new
  tree.insert 'A', 1
  tree.insert 'B', 2
  tree.delete 'A'
  'B' == tree.root.key
end

assert('AvlTree delete barren child with rebalance') do
  tree = AvlTree.new
  tree.insert 'D', nil
  tree.insert 'C', nil
  tree.insert 'A', nil
  tree.insert 'B', nil
  tree.insert 'E', nil
  tree.insert 'F', nil
  tree.insert 'G', nil

  tree.delete 'B'

  'E' == tree.root.key
  'C' == tree.left.key
  'F' == tree.right.key
  'D' == tree.left.right.key
  'A' == tree.left.left.key
  'G' == tree.right.right.key
end

assert('AvlTree delete using in order successor') do
  tree = AvlTree.new
  %w(1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20).each do |item|
    tree.insert item, nil
  end
  tree.delete '14'
  '17' == tree.root.key
  '11' == tree.left.key
  '15' == tree.left.right.key
end

assert('AvlTree delete using in order predecessor') do
  tree = AvlTree.new
  (1..10).to_a.each do |item|
    tree.insert item, nil
  end
  tree.delete 8
  7 == tree.right.key
end

assert('AvlTree delete not found') do
  tree = AvlTree.new
  tree.insert 1, 1
  tree.insert 2, 2
  tree.insert 3, 3

  tree.delete 'a'
  2 == tree.root.key
end

