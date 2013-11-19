class Node

	def initialize(parent = nil, children = [])
		@children = children
		@parent = parent
	end

	def set_children(children)
		@children = children
	end

	def get_children
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