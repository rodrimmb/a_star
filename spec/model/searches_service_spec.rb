require 'model/persistence/searches_service'
require 'mongo'
require 'json/ext'

describe SearchesService do

	it 'add new search to data base' do 
		service = SearchesService.new
		service.add_search('search1')
	end

	it 'view all searches' do 
		service = SearchesService.new
		result = service.get_all_searches().to_a
		puts result
	end

	it 'delete one search' do
		service = SearchesService.new
		puts "Borrado"
		service.delete_search("search1")
	end
end