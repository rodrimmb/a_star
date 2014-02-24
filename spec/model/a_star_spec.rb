require 'model/a_star'
require 'model/node'

describe AStar do

	before(:each) do
		@a_star = AStar.new
    end

	it 'first node is de goal node' do
		state = create_state(true,"A", [])

		initial_node = Node.new(state)
		goal_node = initial_node

		expected_path = goal_node.path

		expect(@a_star.find_path(initial_node, goal_node)).to eq expected_path
	end

	it 'node with two children that one of them was a goal' do
		state_goal = create_state(true, 3, [])
		goal = Node.new(state_goal)

		state_child = create_state(false, 5, [])
		child = Node.new(state_child)

		state_initial = create_state(false, 4, [state_child, state_goal])
		initial = Node.new(state_initial)

		expected_path = [initial, goal]

		expect(@a_star.find_path(initial,goal)).to eq expected_path
	end
end

def create_state(is_final, value, expand)
	state = double "state"
  	state.stub(:is_final? => is_final)
  	state.stub(:value => value)
  	state.stub(:value => expand)
  	state
end