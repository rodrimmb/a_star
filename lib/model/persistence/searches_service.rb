require 'mongo'
require 'json'

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

	def set_solution(search, solution)
		@collection.update( 
			{ "url" => search },
            { "$set" => { "solution" => solution } }
        )
	end

	def get_solution(search)
		search = @collection.find("url" => search).to_a
		search[0]["solution"]
	end

	def remove_solution(search)
		set_solution(search,[])
	end

	def set_steps(search, steps)
		@collection.update( 
			{ "url" => search },
            { "$set" => { "path" => steps } }
        )
	end

	def get_steps(search)
		search = @collection.find("url" => search).to_a
		search[0]["path"]
	end

	def remove_steps(search)
		set_steps(search,[])
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