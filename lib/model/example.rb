require_relative './search_state.rb'
require 'json'

class Example < SearchState

	attr_reader :name, :children

	def initialize(value, name, goal, children)
		super value
	end

	def is_final?
		
	end

	def has_children?
		
	end

	def expand
		
	end

	def set_children(children)
		
	end

	def ==(state)
	
	end
end