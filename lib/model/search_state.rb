class SearchState

	def initialize(value)
		@value = value
	end

	def is_final? 
		raise NotImplementedError, "Implement is_final? in a child class of SearchState"
	end

	def expand 
		raise NotImplementedError, "Implement expand in a child class of SearchState"
	end

	def has_children?
		raise NotImplementedError, "Implement has_children? in a child class of SearchState"
	end
	
	def value
		@value
	end

	def set_value(value)
		@value = value
	end

	def ==(state)
		@value = state.value
	end
end