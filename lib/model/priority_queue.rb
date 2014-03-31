class PriorityQueue

	def initialize
		@queue = []
	end
	def add_node(priority, node)
		if not take_the_best(priority,node) then @queue << [priority, @queue.length, node] end
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
			list << element[2]
		end
		list
	end

	def take_the_best(priority, node)
		@queue.each do |element|
			if element[2] == node
			    if element[0] > priority
				    element[0] = priority
				    element[2] = node
				    return true
				end
				return true
			end
		end
		false
	end
end