require 'model/example'
require 'model/node'
require 'model/handler_json'


describe Example do 

	before(:each) do
		@state = HandlerJson.get_state("A", "./lib/public/res/astar.json")
    end

	it 'first node has a name A' do
		expect(@state.name).to eq "A"
	end

	it 'first node is not a goal node' do 
		expect(@state.is_final?).to be_false
	end
	
	it 'first node has children' do 
		expect(@state.has_children?).to be_true
	end
end