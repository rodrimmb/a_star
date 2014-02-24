require 'model/priority_queue'
require 'model/node'

describe PriorityQueue do 
	it 'can add new elements and get them back in order' do
		pqueue = PriorityQueue.new

		state_1 = create_state(false, 2, nil)
		state_2 = create_state(false, 14, nil)
		state_3 = create_state(false, 4, nil)
		state_4 = create_state(false, 0, nil)

		node_1 = Node.new(state_1)
		node_2 = Node.new(state_2)
		node_3 = Node.new(state_3)
		node_4 = Node.new(state_4)

		expected_result = [node_4,node_1, node_3, node_2]

		expect(pqueue.set_nodes([node_1, node_2, node_3, node_4])).to eq expected_result
	end
	
end

def create_state(is_final, value, expand)
	state = double "state"
  	state.stub(:is_final? => is_final)
  	state.stub(:value => value)
  	state.stub(:expand => expand)
  	state
end