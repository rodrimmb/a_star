=begin
	A Node le llegara un state, este sera un objeto que dependera del juego que estemos implementando.
	
	El objeto state tendra que implementar la funcion is_final? que indicara al algoritmo de
	busqueda si el nodo es meta o no.
=end

class Node

	def initialize(state, parent = nil, children = [])
		set_state(state)
		set_children(children)
		set_parent(parent)
		@path = []
	end

	def state
		@state
	end

	def set_state(state)
		@state = state
		self
	end

	def parent
		@parent
	end

	def set_parent(parent)
		@parent = parent
		self
	end

	def children
		@children
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
		if @path.empty?
			calculate_path
		else
			@path
		end
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

	def is_goal?
		@state.is_final?
	end

	private

	def calculate_path
		node = self.parent
		while node
			@path << node
			node = node.parent
		end
		if !@path.empty?
			@path = @path.reverse
		end
		@path << self
	end
end