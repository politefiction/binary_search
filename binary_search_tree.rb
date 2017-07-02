require './bst_search'

class Node
	attr_accessor :value, :parent, :left_child, :right_child
	def initialize (value=nil, parent=nil, left_child=nil, right_child=nil)
		@value = value
		@parent = parent
		@left_child = left_child
		@right_child = right_child
	end
end

class BinarySearchTree
	include BST_Search
	attr_accessor :tree

	def initialize
		@tree = []
	end

	# build BST w/ sorted array
	def build_tree_sorted(array, tree=[])
		if tree.length == 1
			tree[0].parent.left_child ||= tree[0] or tree[0].parent.right_child ||= tree[0]
		end

		tree if array.empty? and tree.empty?
		array.sort!.each { |i| tree << Node.new(i) } unless array.empty?

		left = tree.slice(0, (tree.length)/2)
		right = tree.slice((tree.length/2+1)..-1)

		lc = left.length/2
		rc = right.length/2
		par = tree.length/2

		unless left.empty?
			left[lc].parent = tree[par]
			tree[par].left_child = left[lc]
			build_tree_sorted([], left)
		end

		unless right.empty?
			right[rc].parent = tree[par]
			tree[par].right_child = right[rc]
			build_tree_sorted([], right) 
		end

		@tree = tree
		@tree
	end

	# build BST with unsorted array 
	# (not quite a refactored method, but it works; may rework later)
	def build_tree(array)
		array.each do |i|
			if @tree.empty?
				@tree << Node.new(i)
			else
				@tree << Node.new(i)
				root = @tree[0]
				while @tree[-1].parent == nil
					if i < root.value
						(root.left_child = @tree[-1] and @tree[-1].parent = root) if root.left_child == nil
						root = root.left_child
					elsif i > root.value
						(root.right_child = @tree[-1] and @tree[-1].parent = root) if root.right_child == nil
						root = root.right_child
					else
						if i < @tree[0].value
							(@tree[0].right_child = @tree[-1] and @tree[-1].parent = @tree[0]) if @tree[0].right_child == nil
							root = @tree[0].right_child
						else
							(@tree[0].left_child = @tree[-1] and @tree[-1].parent = @tree[0]) if @tree[0].left_child == nil
							root = @tree[0].left_child
						end
					end
				end
			end
		end
		@tree
	end

end


test_array = [1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324]


=begin
bsts = BinarySearchTree.new
bsts.build_tree_sorted(test_array)
puts bsts.breadth_first_search(67)
puts bsts.dfs_stack(67)
puts bsts.dfs_rec(67)
puts


bstu = BinarySearchTree.new
bstu.build_tree(test_array)
puts bstu.breadth_first_search(67)
puts bstu.dfs_stack(67)
puts bstu.dfs_rec(67)
=end