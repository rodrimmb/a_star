require 'mongo'

class NodesService

	def initialize
		conn = Mongo::Connection.new("localhost", 27017)
		db = conn.db("mydb")
		@coll = db.collection('testData')
	end

	def add_node(node, search)
		exist = @coll.find("name" => name).to_a
		if exist
			new_search = { :name => name, :url => make_url(name), :created_on => Time.now }
			@coll.insert(new_search)
		end
	end

	def get_all_nodes(search)
		@coll.find() 
	end

	def delete_node(node,search)
		@coll.remove("url" => search)
	end

	def get_node(node,search)
		search = Posts.find( :_id => post_id ).first
	end

	def update_node(node,search)
		search = Posts.find( :_id => post_id ).first
	end
end