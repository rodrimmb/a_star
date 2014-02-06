class Node

	def initialize(value, name = nil, parent = nil, children = [])
		@name = name
		set_value(value)
		set_children(children)
		set_parent(parent)
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
			if children.size > 0
				children.each do |x|
					@children << x
				end
			else
				@children = []
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

	def set_parent(parent)
		@parent = parent
		self
	end
end