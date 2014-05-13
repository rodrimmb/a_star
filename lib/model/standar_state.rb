require_relative './search_state.rb'
require 'json'

class StandarState < SearchState

	attr_reader :name, :children, :value, :father

	def initialize(value, name, goal, children = [], father = [], search)
		@value = value
		@name = name
		@goal = goal
		@children = children
		@search = search
		@father = father
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
		children.each do |child|
			value = @search.get_node(child["name"], child["path_cost"])
			states << value
		end
		return states
	end

	def ==(state)
		@name == state.name #&& @value == state.value
	end
end