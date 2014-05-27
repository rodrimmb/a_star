require 'model/generate_graph'
require 'model/persistence/searches_service'
require 'model/persistence/singleton_db_connection'

describe GenerateGraph do 
	it 'genrate a graph' do
		collection = SingletonDbConnection.get_instance('mydb','spec')
		search_service = SearchesService.new(collection)

		g = GenerateGraph.new

		nodes = search_service.get_search_nodes('example')
		g.get_svg(nodes)
	end
end
