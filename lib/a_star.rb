class AStar
	def initialize(startNode = nil, endNode = nil)
		@startNode = startNode
		@endNode = endNode

		@openList = []
		@closedList = []

		if @startNode
			@openList << @startNode
		end

		@solution
	end

	def search
		@openList.each do |node|
			if is_goal(node)
				@solution = node
			else
				if node.has_children
					node.children.each do |child|
						@openList << child
					end
				end
				@closedList << @openList.shift
			end
		end
		self
	end

	def solution
		solution =[]
		if @solution.has_parents
			solution.push(@solution.parent, @solution)
		else
			solution << @solution
		end
	end

	def start_node
		@startNode
	end

	def end_node
		@endNode
	end

	def open_list
		@openList
	end

	def closed_list
		@closedList
	end

	private
	def is_goal(node)
		if node == @endNode
			true
		else
			false
		end
	end
end