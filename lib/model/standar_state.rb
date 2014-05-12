require_relative './search_state.rb'
require 'json'

class StandarState < SearchState

	attr_reader :name, :children, :value

	def initialize(value, name, goal, children = [], search)
		@value = value
		@name = name
		@goal = goal
		@children = children
		@search = search
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
			states << @search.get_node(state_name)
		end
		return states
	end

	def ==(state)
		@name == state.name
	end
end