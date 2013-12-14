class Node

	def initialize(name, parent = nil, children = [])
		@name = name;
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

	def set_children(children)
		@children = children
	end

	def children
		@children
	end

	def parent
		@parent
	end

	def cost
		4
	end
end