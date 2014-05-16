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
		@expanded = false
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

	def expand
		nodes = []
		if not @expanded and @state.has_children?
			@state.expand.each do |s|
				s.path_cost = @state.path_cost.to_i + s.path_cost.to_i
				nodes << Node.new(s, self)
			end
			set_children(nodes)
			expanded
		end
		children
	end

	def has_children?
		state.has_children?
	end

	def has_parent?
		if self.parent
			true
		else
			false
		end
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

	def ==(node)
		state == node.state
	end

	def >(node)
		if state.value > node.state.value
			return true
		end
		return false
	end

	def <(node)
		if state.value < node.state.value
			return true
		end
		return false
	end

	def >=(node)
		if state.value >= node.state.value
			return true
		end
		return false
	end

	def <=(node)
		if state.value <= node.state.value
			return true
		end
		return false
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

	def expanded
		@expanded = true
	end
end