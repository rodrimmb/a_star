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

	def has_children
		if @children
			true
		else
			false
		end
	end

	def parent
		@parent
	end

	def has_parents
		if @parent
			true
		else
			false
		end
	end
end