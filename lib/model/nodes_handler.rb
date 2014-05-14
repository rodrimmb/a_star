class NodesHandler

	def initialize(searchName)
		@searchName = searchName
		@nodeService = new.NodeService
	end

	def get_node(node_name, path_cost, parent)
		@nodeService.get_node(node_name,@search)
	end

end