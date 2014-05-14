require 'model/nodes_handler' 
require 'model/persistence/singleton_db_connection'
require 'model/persistence/nodes_service'

describe NodesHandler do

	before(:all) do
		collection = SingletonDbConnection.get_instance('mydb','spec')
		nodes_service = NodesService.new(collection)
		@nodes_handler = NodesHandler.new('example',nodes_service)
	end

	it 'get the state of node A' do
		state_A = @nodes_handler.get_node("A")

		expect(state_A.name).to eq "A"
		expect(state_A.path_cost).to eq 0
		expect(state_A.value).to eq 4
	end

	it 'get the child B of node A and check its path_cost is 1' do
		state_A = @nodes_handler.get_node("A")

		children = state_A.expand

		children.each do |child|
			expect(child.path_cost).to eq 1
		end
	end
end