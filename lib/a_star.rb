class AStar
	def initialize(startNode = nil, endNode = nil)
		@startNode = startNode
		@endNode = endNode
	end

	def start_node
		@startNode
	end

	def end_node
		@endNode
	end

	def open_list
		[]
	end

	def closed_list
		[]
	end

	def steps
		[]
	end
end