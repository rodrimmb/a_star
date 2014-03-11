class PriorityQueue

	def initialize
		@queue = []
	end
	def set_nodes(nodes)
		nodes.each do |node|
			@queue << node
		end
		if @queue.size > 1
			sort_queue
		end
		@queue
	end

	def sort_queue
		@queue = @queue.sort_by {|node| node.state.value + node.deep}
	end

	def is_empty?
		@queue.empty?
	end

	def next
		@queue.shift
	end

	def queue
		sort_queue
		@queue
	end
end