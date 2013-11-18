class AStar
	def initialize(start = nil)
		@startNode = start
	end

	def start_node
		@startNode
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