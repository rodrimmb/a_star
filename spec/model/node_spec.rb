require 'model/node'

describe Node do
		
	context 'single node with one state' do
		before(:each) do
			@state_a = create_state("A",true, 3, [], true)
			@state_b = create_state("B",true, 5, [], false)
			@state = create_state("C",false, 4, [@state_a, @state_b], true)
			@node = Node.new(@state)
    	end

		it 'has a 0 deep if it hasn\'t parent' do
			expect(@node.deep).to eq 0
		end

		it 'has a state' do
			expect(@node.state).to eq @state
		end

		it 'can change the state' do
			expect(@node.state).to eq @state
			expect(@node.set_state(10).state).to eq 10
		end

		it 'can add a parent' do
			parent = Node.new(@state_a);
			expect(@node.set_parent(parent).parent).to eq parent
		end

		it 'can check if itself is the goal node' do
			expect(@node.is_goal?).to be_false
		end

		it 'the path is an arry with the state' do
			expect(@node.path).to eq [@node]
		end

		it 'can expand a node and obtain its children' do
			expected_children = [Node.new(@state_a,@node),Node.new(@state_b,@node)]
			expect(@node.expand).to eq expected_children
		end
	end

	context 'node with one child' do 
		before(:each) do
      		father = "father"
			child = "child"
			@node_father = Node.new(father)
			@node_child = Node.new(child, @node_father)
			@node_father.set_children(@node_child)
    	end

		it 'father node shold have a child' do
			expect(@node_father.children[0]).to be @node_child
		end

		it 'child shold have a parent' do
			expect(@node_child.parent).to be @node_father
		end

		it 'the deep of node child should be 1' do
			expect(@node_child.deep).to eq 1
		end

		it 'the path of child should be itself and its father' do
			expect(@node_child.path).to eq [@node_father,@node_child]
		end

		it 'can put another child to the father node' do
			expect(@node_father.children.size).to be 1
			expect(@node_father.set_children(Node.new(0,"child_2")).children.size).to be 2
		end

		it 'can put others children to the father node' do
			expect(@node_father.children.size).to be 1
			children = [Node.new(0,"child_2"), Node.new(0,"child_3")]
			expect(@node_father.set_children(children).children.size).to be 3
		end
	end

	context 'tree with various nodes' do
		before(:each) do
			@node_A = Node.new("A")
			@node_B = Node.new("B", @node_A)
			@node_C = Node.new("C", @node_A)

			@node_D = Node.new("D", @node_B)
			@node_E = Node.new("E", @node_B)

			@node_F = Node.new("F", @node_C)			

			@node_B.set_children([@node_D, @node_E])
			@node_C.set_children(@node_F)

			@node_A.set_children([@node_B,@node_C])
    	end

    	it 'the deep of node child in the three level should be 2' do
			expect(@node_F.deep).to eq 2
		end

		it 'the deep of node child in the two level should be 1' do
			expect(@node_B.deep).to eq 1
		end

		it 'obtain the path of child in the three level' do
			expect(@node_F.path).to eq [@node_A, @node_C, @node_F]
		end
	end
end

def create_state(name, is_final, value, expand, children)
	state = double "state"
	state.stub(:name => name)
  	state.stub(:is_final? => is_final)
  	state.stub(:value => value)
  	state.stub(:expand => expand)
  	state.stub(:has_children? => children)
  	state
end