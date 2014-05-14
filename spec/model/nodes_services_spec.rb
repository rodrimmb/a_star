require 'model/persistence/nodes_service'
require 'model/persistence/singleton_db_connection'

describe NodesService do

	before(:all) do
		collection = SingletonDbConnection.get_instance('mydb','spec')
		@nodes_service = NodesService.new(collection)
	end

	it 'get all nodes' do
		expect(@nodes_service.get_all_nodes('example').size).to eq 13
	end

	it 'get one node' do
		node = @nodes_service.get_node("A",'example')

		expect(node["name"]).to eq "A"
		expect(node["cost"]).to eq 4
		expect(node["goal"]).to be_false
		expect(node["children"]).to eq [{"name"=>"B","path_cost"=>1.0},{"name"=>"C","path_cost"=>1.0}]
	end	

	it 'can get the first node' do
		node = @nodes_service.get_first_node('example')

		expect(node["name"]).to eq "A"
		expect(node["cost"]).to eq 4
		expect(node["goal"]).to be_false
		expect(node["children"]).to eq [{"name"=>"B","path_cost"=>1.0},{"name"=>"C","path_cost"=>1.0}]
	end
end