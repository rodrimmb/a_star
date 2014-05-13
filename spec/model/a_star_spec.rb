require 'model/a_star'
require 'model/node'
require 'model/standar_state'

describe AStar do

	before(:each) do
		@a_star = AStar.new

    end

	it 'first node is the goal node' do
		state = StandarState.new(
			SearchAStar1.get_tree[0]["cost"], 
			SearchAStar1.get_tree[0]["name"], 
			SearchAStar1.get_tree[0]["goal"], 
			SearchAStar1.get_tree[0]["children"],
			SearchAStar1.get_tree[0]["father"], 
			SearchAStar1.new
		)

		node = Node.new(state)

		expect(@a_star.search(node)).to eq [node]
	end

	it 'node with two children that one of them was a goal' do		
		state_A = StandarState.new(
			SearchAStar2.get_tree[0]["cost"], 
			SearchAStar2.get_tree[0]["name"], 
			SearchAStar2.get_tree[0]["goal"], 
			SearchAStar2.get_tree[0]["children"],
			SearchAStar2.get_tree[0]["father"], 
			SearchAStar2.new
		)

		state_C = StandarState.new(
			SearchAStar2.get_tree[2]["cost"], 
			SearchAStar2.get_tree[2]["name"], 
			SearchAStar2.get_tree[2]["goal"], 
			SearchAStar2.get_tree[2]["children"],
			SearchAStar2.get_tree[2]["father"], 
			SearchAStar2.new
		)

		node_A = Node.new(state_A)
		node_C = Node.new(state_C)

		expect(@a_star.search(node_A)).to eq [node_A,node_C]
	end

	it 'tree with 3 levels and one node goal' do

		state_A = StandarState.new(
			SearchAStar3.get_tree[0]["cost"], 
			SearchAStar3.get_tree[0]["name"], 
			SearchAStar3.get_tree[0]["goal"], 
			SearchAStar3.get_tree[0]["children"],
			SearchAStar3.get_tree[0]["father"], 
			SearchAStar3.new
		)

		state_C = StandarState.new(
			SearchAStar3.get_tree[2]["cost"], 
			SearchAStar3.get_tree[2]["name"], 
			SearchAStar3.get_tree[2]["goal"], 
			SearchAStar3.get_tree[2]["children"],
			SearchAStar3.get_tree[2]["father"], 
			SearchAStar3.new
		)

		state_G = StandarState.new(
			SearchAStar3.get_tree[6]["cost"], 
			SearchAStar3.get_tree[6]["name"], 
			SearchAStar3.get_tree[6]["goal"], 
			SearchAStar3.get_tree[6]["children"],
			SearchAStar3.get_tree[6]["father"], 
			SearchAStar3.new
		)

		node_A = Node.new(state_A)
		node_C = Node.new(state_C)
		node_G = Node.new(state_G)

		expect(@a_star.search(node_A)).to eq [node_A,node_C,node_G]
	end

	private

	class SearchAStar1
		@tree = [
			{ 	"name"=> "A", "cost"=> 4, "father"=> [], 
				"children"=> [], "goal"=> true 
			}
		]		

		def get_node(name, cost)
			SearchAStar1.get_tree.each do |node|
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

	class SearchAStar2

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
			SearchAStar2.get_tree.each do |node|
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

	class SearchAStar3

		@tree = [
			{ 	"name"=> "A", "cost"=> 4, "father"=> [], 
				"children"=> [
					{"name" => "B", "path_cost" => 1},
					{"name" => "C", "path_cost" => 1}
				], "goal"=> false 
			},
			{ 	"name"=> "B", "cost"=> 5, "father"=> ["A"], 
				"children"=> [
					{"name" => "D", "path_cost" => 1},
					{"name" => "E", "path_cost" => 1}
				],	"goal"=> false 
			},
			{ 	"name"=> "C", "cost"=> 3, "father"=> ["A"], 
				"children"=> [
					{"name" => "F", "path_cost" => 1},
					{"name" => "G", "path_cost" => 1}
				], "goal"=> false 
			},
			{ "name"=> "D", "cost"=> 7, "father"=> ["B"], "children"=> [], "goal"=> false },
			{ "name"=> "E", "cost"=> 9, "father"=> ["B"], "children"=> [], "goal"=> false },
			{ "name"=> "F", "cost"=> 6, "father"=> ["C"], "children"=> [], "goal"=> false },
			{ "name"=> "G", "cost"=> 8, "father"=> ["C"], "children"=> [], "goal"=> true }
		]		

		def get_node(name, cost)
			SearchAStar3.get_tree.each do |node|
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