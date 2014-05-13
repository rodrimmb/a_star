require 'model/persistence/singleton_db_connection'

describe SingletonDbConnection do

	it 'get conection with database' do
		@collection = SingletonDbConnection.get_instance('mydb','spec')
		expect(@collection.find().first["name"]).to eq "test"
	end

end