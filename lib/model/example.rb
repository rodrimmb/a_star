require_relative './search_state.rb'
require_relative './handler_json.rb'
require 'json'

class Example < SearchState

	attr_reader :name, :children, :value

	def initialize(value, name, goal, children = [])
		@value = value
		@name = name
		@goal = goal
		@children = children
		super value
	end

	def is_final?
		@goal
	end

	def has_children?
		if @children.size > 0 then true else false end
	end

	def expand
		states = []
		children.each do |state_name|
			states << HandlerJson.get_state(state_name, "./public/res/astar.json")
		end
		return states
	end

	def ==(state)
		@name == state.name
	end
end