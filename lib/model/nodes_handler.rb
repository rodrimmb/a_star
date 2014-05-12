class NodesHandler

	def initialize(searchName)
		@searchName = searchName
		@nodeService = new.NodeService
	end

	def get_node(node_name)
		@nodeService.get_node(node_name,@search)
	end

end