require 'mongo'

class SearchesService

	def initialize(collection)
		@collection = collection
	end

	def add_search(name)
		exist = @collection.find("name" => name).to_a
		if exist.size == 0
			new_search = { 
				:name => name, 
				:url => make_url(name), 
				:nodes => [],
				:solution =>[], 
				:path =>[], 
				:created_on => Time.now 
			}
			@collection.insert(new_search)
		end
	end

	def get_all_searches
		@collection.find() 
	end

	def delete_search(search)
		@collection.remove("url" => search)
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