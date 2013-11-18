class AStar
	def initialize(startNode = nil, endNode = nil)
		@startNode = startNode
		@endNode = endNode

		@openList = []
		@closedList = []

		if @startNode
			@openList << @startNode
		end
	end

	def search
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
end