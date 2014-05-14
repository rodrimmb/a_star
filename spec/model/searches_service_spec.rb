require 'model/persistence/searches_service'
require 'model/persistence/singleton_db_connection'

describe SearchesService do

	before(:all) do
		collection = SingletonDbConnection.get_instance('mydb','spec')
		@searches_service = SearchesService.new(collection)
	end

	it 'can insert a solution and get search solution'  do
		@searches_service.set_solution('example', ["A","F"])
		expect(@searches_service.get_solution('example')).to eq ["A","F"]
	end

	it 'can remove a solution' do
		@searches_service.remove_solution('example')
		expect(@searches_service.get_solution('example')).to eq []
	end
end