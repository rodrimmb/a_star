require_relative './standar_state.rb'

class NodesHandler

	def initialize(search_name, nodes_service)
		@search_name = search_name
		@nodes_service = nodes_service
	end

	def get_node(node_name, path_cost = 0, parent = "_")
		node = @nodes_service.get_node(node_name,@search_name)
		output = StandarState.new(
			node["cost"], 
			node["name"], 
			node["goal"], 
			node["children"],
			[parent],
			path_cost, 
			self
		)
	end
end