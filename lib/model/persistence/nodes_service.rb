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

	def get_node(node_name,search)
		value = @collection.find("url" => search).first
		value["nodes"].each do |node|
			if node["name"] == node_name
				return node
			end
		end
	end

	def get_first_node(search)
		value = @collection.find("url" => search).first
		value["nodes"][0]
	end

	def update_node(node,search)
		
	end
end