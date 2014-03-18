require 'model/priority_queue'
require 'model/node'

describe PriorityQueue do 

	before(:each) do
		@pqueue = PriorityQueue.new

		state_1 = create_state("A",false, 2, [], false)
		state_2 = create_state("B",false, 14, [], false)
		state_3 = create_state("C",false, 4, [], false)
		state_4 = create_state("D",false, 0, [], false)

		@node_1 = Node.new(state_1)
		@node_2 = Node.new(state_2)
		@node_3 = Node.new(state_3)
		@node_4 = Node.new(state_4)
    end

	it 'can add new elements and get them back in order' do
		expected_result = @node_1
		@pqueue.add_node(@node_1.state.value + @node_1.deep, @node_1)

		expect(@pqueue.next).to eq expected_result
		expect(@pqueue.is_empty?).to be_true
	end

	it 'can add various nodes to a priority queue and get them back in order' do
		@pqueue.add_node(@node_1.state.value + @node_1.deep, @node_1)
		@pqueue.add_node(@node_2.state.value + @node_2.deep, @node_2)
		@pqueue.add_node(@node_3.state.value + @node_3.deep, @node_3)
		@pqueue.add_node(@node_4.state.value + @node_4.deep, @node_4)

		expect(@pqueue.next).to eq @node_4
		expect(@pqueue.next).to eq @node_1
		expect(@pqueue.next).to eq @node_3
		expect(@pqueue.next).to eq @node_2
		expect(@pqueue.is_empty?).to be_true
	end

	it 'when I insert the same node with better heuristic the old one is substituted' do 
		state = create_state("A",false, 8, [], false)
		better_state = create_state("A",false, 2, [], false)

		node = Node.new(state)
		better_node = Node.new(better_state)

		@pqueue.add_node(node.state.value + node.deep, node)

		expect(@pqueue.add_node(better_node.state.value + better_node.deep, better_node).queue).to eq [better_node]
	end
end

def create_state(name, is_final, value, expand, children)
	state = double "state"
	state.stub(:name => name)
  	state.stub(:is_final? => is_final)
  	state.stub(:value => value)
  	state.stub(:expand => expand)
  	state.stub(:has_children? => children)
  	state.stub(:==) do |arg|
  	  if arg == name then true else false end
	end
  	state
end