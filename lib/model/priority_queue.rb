class PriorityQueue

	def initialize
		@queue = []
	end
	def set_node(nodes)
		nodes.each do |node|
			@queue << node
		end
		#sort_queue
		self
	end

	def sort_queue

	end

	def is_empty?
		@queue.empty?
	end

	def next
		@queue.first
	end
end