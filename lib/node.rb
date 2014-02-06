class Node

	def initialize(value, name = nil, parent = nil, children = [])
		@name = name
		@value = value
		@children = children
		@parent = parent
		@path = []
	end

	def name
		@name
	end

	def deep
		node = @parent
		deep = 0
		while node
			deep +=1
			node = node.parent
		end
		deep
	end

	def value
		@value
	end

	def set_value(value)
		@value = value
		self
	end

	def set_children(children)
		if children.class == Array
			children.each do |x|
				@children << x
			end
		else
			@children << children
		end
		self
	end

	def path
		node = self.parent
		while node
			@path << node
			node = node.parent
		end
		@path = @path.reverse
		@path << self
	end


	def children
		@children
	end

	def parent
		@parent
	end
end