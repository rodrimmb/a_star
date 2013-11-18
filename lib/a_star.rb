class AStar
	def initialize(startNode = nil, endNode = nil)
		@startNode = startNode
		@endNode = endNode

		@openList = []

		if @startNode
			@openList << @startNode
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
		[]
	end

	def steps
		[]
	end
end