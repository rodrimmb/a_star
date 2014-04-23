require 'mongo'

class SearchesService

	def initialize
		conn = Mongo::Connection.new("localhost", 27017)
		db = conn.db("mydb")
		@coll = db.collection('testData')
	end

	def add_search(name)
		new_search = { :name => name, :url => make_url(name), :created_on => Time.now }
		search = @coll.insert(new_search)
	end

	def get_all_searches
		@coll.find
	end

	def get_search(name)
		search = Posts.find( :_id => post_id ).first
	end

	private

	def make_url(name)
		name = name.downcase.gsub(/\s+/, "")
		return name
	end
end