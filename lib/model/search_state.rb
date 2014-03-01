class SearchState

	def initialize(value)
		@value = value
	end

	def is_final? 
		raise NotImplementedError, "Implement this method in a child class of SearchState"
	end

	def expand 
		raise NotImplementedError, "Implement this method in a child class of SearchState"
	end

	def has_children?
		raise NotImplementedError, "Implement this method in a child class of SearchState"
	end
	
	def value
		@value
	end

	def set_value(value)
		@value = value
	end
end