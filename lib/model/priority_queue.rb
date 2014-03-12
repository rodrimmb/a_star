class PriorityQueue

	def initialize
		@queue = []
	end
	def add_node(priority, node)
		@queue << [priority, @queue.length, node]
        @queue.sort!
        self
	end

	def is_empty?
		@queue.empty?
	end

	def next
		@queue.shift[2]
	end

	def queue
		list = []
		@queue.each do |element|
			# Don't should give the name only the node
			list << element[2].state.name
		end
		list
	end
end