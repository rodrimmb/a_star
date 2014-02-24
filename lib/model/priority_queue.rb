class PriorityQueue

	def initialize
		@queue = []
	end
	def set_nodes(nodes)
		nodes.each do |node|
			@queue << node
		end
		sort_queue
		@queue
	end

	def sort_queue
		@queue = @queue.sort_by {|node| node.state.value}
	end

	def is_empty?
		@queue.empty?
	end

	def next
		@queue.first
	end

	def queue
		@queue
	end
end