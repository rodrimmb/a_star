require 'model/search_state'
require 'json'

class Example < SearchState

	attr_reader :name, :goal, :children

	def initialize(value, name, goal, children)
		@name = name
		@goal = goal
		@children = children
		super value
	end
	
end