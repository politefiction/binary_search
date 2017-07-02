module BST_Search
	attr_accessor :found

	def breadth_first_search(target)
		tree = self.tree
		queue = []
		tree.each { |node| queue << node if node.parent.nil? }
		while queue.length > 0
			if target == queue[0].value
				return "#{queue[0]}, value: #{queue[0].value}"
			else 
				queue << queue[0].left_child unless queue[0].left_child.nil?
				queue << queue[0].right_child unless queue[0].right_child.nil?
				queue.shift
			end
		end
		nil
	end

	# Depth-First Search w/ stack
	def dfs_stack(target)
		tree = self.tree
		stack = []
		tree.each { |node| stack << node if node.parent.nil? }

		parent = stack[0]
		while stack.length < tree.length
			if parent.left_child and !stack.include?(parent.left_child)
				stack << parent.left_child
				parent = parent.left_child
			elsif parent.right_child and !stack.include?(parent.right_child)
				stack << parent.right_child
				parent = parent.right_child
			else
				parent = parent.parent
			end
		end
		while stack.length > 0
			return stack[0] if target == stack[0].value
			stack.shift
		end
		nil
	end

	# Depth-First Search w/ recursion
	@found = nil
	def dfs_rec(target, current_node=nil)
		tree = self.tree
		current_node ||= (tree.select { |node| node.parent.nil? })[0]
		@found ||= current_node if current_node.value == target
		unless @found
			dfs_rec(target, current_node.left_child) if current_node.left_child
			dfs_rec(target, current_node.right_child) if current_node.right_child
		end
		@found
	end

end