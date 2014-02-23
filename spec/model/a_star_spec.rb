require 'model/a_star'
require 'model/node'

describe AStar do
	it 'first node is de goal node' do
		a_star = AStar.new

		state = double "state"
  		state.stub(:is_final? => true)
  		state.stub(:value => "AAAAAaaaa")

		initial_node = Node.new(state)
		goal_node = initial_node

		expected_path = goal_node.path

		expect(a_star.find_path(initial_node, goal_node)).to eq expected_path
	end
	
end