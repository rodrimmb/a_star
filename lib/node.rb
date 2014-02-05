class Node

	def initialize(value, name = nil, parent = nil, children = [])
		@name = name
		@value = value
		@children = children
		@parent = parent
	end

	def name
		@name
	end

	def deep
		if @parent 
			1
		else
			0
		end
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

	def children
		@children
	end

	def parent
		@parent
	end
end