require 'mongo'
require 'json'

class NodesService

	def initialize(collection)
		@collection = collection
	end

	def add_node(node, search)
		puts "Add node to search " + search
		@collection.update( 
			{ "url" => search },
            { "$addToSet" => { "nodes" => node } }
        )
	end

	def get_all_nodes(search)
		value = @collection.find("url" => search).first
		value["nodes"]
	end

	def delete_node(node,search)
		
	end

	def get_node(node,search)
		
	end

	def update_node(node,search)
		
	end
end