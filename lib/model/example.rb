require 'model/search_state'
require 'json'

class Example < SearchState

	attr_reader :name, :children

	def initialize(value, name, goal, children)
		@name = name
		@goal = goal
		set_children(children)
		super value
	end

	def is_final?
		@goal
	end

	def has_children?
		if @children.size > 0 then true else false end
	end

	def expand
		@children
	end

	private

	def set_children(children)
		@children = []
		children.each do |child|
			goal = if child["node"]["goal"] == "true" then goal = true else goal = false end
			value = child["node"]["value"].to_i
			name = child["node"]["node_name"]

			child = Example.new(value, name, goal, child["node"]["children"])
			@children << child
		end
	end
end