require 'model/standar_state'

describe StandarState do

	before(:all) do
		@search = Search.new

		@state = StandarState.new(
			Search.get_tree[0]["cost"], 
			Search.get_tree[0]["name"], 
			Search.get_tree[0]["goal"], 
			Search.get_tree[0]["children"],
			Search.get_tree[0]["father"], 
			@search
		)
	end

	it 'obtanin the propieties of state prperly (name, value, father, children, goal)' do
		
		
		expect(@state.name).to eq "A"
		expect(@state.value).to eq 4
		expect(@state.is_final?).to be_false
		expect(@state.father).to eq []
		expect(@state.children).to eq [
					{"name" => "B", "path_cost" => 1},
					{"name" => "C", "path_cost" => 1}
				]
	end

	it 'get the state of children of node A (the children are B and C)' do
		state_B = StandarState.new(
			Search.get_tree[1]["cost"]+1, 
			Search.get_tree[1]["name"], 
			Search.get_tree[1]["goal"], 
			Search.get_tree[1]["children"],
			Search.get_tree[1]["father"], 
			@search
		)

		state_C = StandarState.new(
			Search.get_tree[2]["cost"]+1, 
			Search.get_tree[2]["name"], 
			Search.get_tree[2]["goal"], 
			Search.get_tree[2]["children"],
			Search.get_tree[2]["father"], 
			@search
		)

		expect(@state.expand).to eq [state_B, state_C]
	end



	private

	class Search
		@tree = [
			{ 	"name"=> "A", "cost"=> 4, "father"=> [], 
				"children"=> [
					{"name" => "B", "path_cost" => 1},
					{"name" => "C", "path_cost" => 1}
				], "goal"=> false 
			},
			{ 	"name"=> "B", "cost"=> 5, "father"=> ["A"], 
				"children"=> [], "goal"=> false 
			},
			{ 	"name"=> "C", "cost"=> 3, "father"=> ["A"], 
				"children"=> [], "goal"=> true 
			}
		]		

		def get_node(name, cost)
			Search.get_tree.each do |node|
				if(node["name"] == name)
					return StandarState.new(
						node["cost"] + cost, 
						node["name"], 
						node["goal"], 
						node["children"], 
						self
					)
				end
			end
		end

		def self.get_tree
			@tree
		end
	end
end