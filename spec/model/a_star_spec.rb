require 'model/a_star'
require 'model/node'
require 'model/example'

describe AStar do

	before(:all) do
		@tree = [
					{ "name"=> "A", "cost"=> 4, "father"=> [], "children"=> ["B","C"], "goal"=> false },
					{ "name"=> "B", "cost"=> 5, "father"=> ["A"], "children"=> ["D","E"],	"goal"=> false },
					{ "name"=> "C", "cost"=> 3, "father"=> ["A"], "children"=> ["F","G"], "goal"=> false },
					{ "name"=> "D", "cost"=> 7, "father"=> ["B"], "children"=> [], "goal"=> false },
					{ "name"=> "E", "cost"=> 9, "father"=> ["B"], "children"=> [], "goal"=> false },
					{ "name"=> "F", "cost"=> 6, "father"=> ["C"], "children"=> [],	"goal"=> false },
					{ "name"=> "G", "cost"=> 8, "father"=> ["C"], "children"=> [],	"goal"=> true }
				]
	end

	before(:each) do
		@a_star = AStar.new
    end

	it 'first node is the goal node' do
		state = Example.new(@tree[0]["cost"], @tree[0]["name"], true, [])

		initial_node = Node.new(state)
		goal_node = initial_node

		expected_path = goal_node.path

		expect(@a_star.search(initial_node)).to eq expected_path
	end

	
	it 'node with two children that one of them was a goal' do
		state_goal = Example.new(@tree[2]["cost"], @tree[2]["name"], true, [])
		goal = Node.new(state_goal)

		state_child = Example.new(@tree[1]["cost"], @tree[1]["name"], @tree[1]["goal"], [])
		child = Node.new(state_child)

		state_initial = Example.new(@tree[0]["cost"], @tree[0]["name"], @tree[0]["goal"], [state_child,state_goal])
		initial = Node.new(state_initial)

		expected_path = [initial, goal]

		expect(@a_star.search(initial)).to eq expected_path
	end

	it 'tree with 3 levels and one node goal' do
		state_G = Example.new(@tree[6]["cost"], @tree[6]["name"], true, [])
		state_F = Example.new(@tree[5]["cost"], @tree[5]["name"], @tree[5]["goal"], [])
		state_E = Example.new(@tree[4]["cost"], @tree[4]["name"], @tree[4]["goal"], [])
		state_D = Example.new(@tree[3]["cost"], @tree[3]["name"], @tree[3]["goal"], [])
		state_C = Example.new(@tree[2]["cost"], @tree[2]["name"], @tree[2]["goal"], [state_F,state_G])
		state_B = Example.new(@tree[1]["cost"], @tree[1]["name"], @tree[1]["goal"], [state_D,state_E])
		state_A = Example.new(@tree[0]["cost"], @tree[0]["name"], @tree[0]["goal"], [state_B,state_C])

		node_A = Node.new(state_A)
		node_B = Node.new(state_B)
		node_C = Node.new(state_C)
		node_D = Node.new(state_D)
		node_E = Node.new(state_E)
		node_F = Node.new(state_F)
		node_G = Node.new(state_G)

		expected_path = [node_A, node_C, node_G]


		expect(@a_star.search(node_A)).to eq expected_path
	end
	
end