require 'mongo'

class NodesService

	def initialize
		conn = Mongo::Connection.new("localhost", 27017)
		db = conn.db("mydb")
		@coll = db.collection('testData')
	end

	def add_node(node, search)
		puts "Add node to search " + search
		@coll.update( 
			{ "url" => search },
            { "$addToSet" => { "nodes" => node } }
        )
	end

	def get_all_nodes(search)
		
	end

	def delete_node(node,search)
		
	end

	def get_node(node,search)
		
	end

	def update_node(node,search)
		
	end
end