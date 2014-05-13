require 'model/persistence/singleton_db_connection'

describe SingletonDbConnection do

	it 'get conection with database' do
		@collection = SingletonDbConnection.get_instance('mydb','testData')
		puts @collection.find().to_a
	end

end