require 'model/priority_queue'
require 'model/node'

describe PriorityQueue do 

	before(:each) do
		@pqueue = PriorityQueue.new

		state_1 = create_state(false, 2, [], false)
		state_2 = create_state(false, 14, [], false)
		state_3 = create_state(false, 4, [], false)
		state_4 = create_state(false, 0, [], false)

		@node_1 = Node.new(state_1)
		@node_2 = Node.new(state_2)
		@node_3 = Node.new(state_3)
		@node_4 = Node.new(state_4)
    end

	it 'can add new elements and get them back in order' do
		expected_result = [@node_4, @node_1, @node_3, @node_2]

		expect(@pqueue.set_nodes([@node_1, @node_2, @node_3, @node_4])).to eq expected_result
	end

	it 'can add new elements to a priority queue with elements and get them back in order' do
		expected_result = [@node_4, @node_1, @node_3, @node_2]

		@pqueue.set_nodes([@node_1, @node_2])		

		expect(@pqueue.set_nodes([@node_3, @node_4])).to eq expected_result
	end


	
end

def create_state(is_final, value, expand, children)
	state = double "state"
  	state.stub(:is_final? => is_final)
  	state.stub(:value => value)
  	state.stub(:expand => expand)
  	state.stub(:has_children? => children)
  	state
end