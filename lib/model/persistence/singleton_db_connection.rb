class SingletonDbConnection

	@instance = nil

	def self.get_instance(db, collection){
		if(@instance == nil){
			@instance = self.connection(db, collection)
		}
		return @instance
	}

	private

	def connection(db, collection){
		conn = Mongo::Connection.new("localhost", 27017)
		db = conn.db(db)
		return db.collection(collection)
	}
end