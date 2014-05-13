require 'mongo'

class SingletonDbConnection

	attr_reader :instance

	def initialize(db, collection)
		conn = Mongo::Connection.new("localhost", 27017)
		db = conn.db(db)
		@instance = db.collection(collection)
	end

	@instance = nil

	def self.get_instance(db, collection)
		if(@instance == nil)
			@instance = SingletonDbConnection.new(db, collection).instance
		end
		return @instance
	end
end