require_relative './search_state.rb'
require_relative './handler_json.rb'
require 'json'

class Example < SearchState

	attr_reader :name, :children

	def initialize(value, name, goal, children)
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
		result = []
		@children.each do |state_name|
			result << HandlerJson.get_state(state_name)
		end
		result
	end

	def set_children(children)
		
	end

	def ==(state)
		self.name == state.name
	end
end