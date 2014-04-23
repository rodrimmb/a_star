require 'model/persistence/searches_service'
require 'mongo'
require 'json/ext'

describe SearchesService do

	it 'add new search to data base' do 
		service = SearchesService.new
		puts service.add_search('search1')
	end

	it 'view all searches' do 
		service = SearchesService.new
		service.get_all_searches().each { |x| puts x }
	end
end