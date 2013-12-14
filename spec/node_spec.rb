require 'node'

describe Node do
		
	context 'single node' do
		before(:each) do
      		@name = "A"
			@node = Node.new(@name)
    	end

		it 'should has a name' do
			expect(@node.name).to be @name
		end

		it 'has a 0 deep if it hasn\'t parent' do
			expect(@node.deep).to eq 0
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
			expect(@node_father.children).to be @node_child
		end

		it 'child shold have a parent' do
			expect(@node_child.parent).to be @node_father
		end

		it 'the deep of node child should be 1' do
			expect(@node_child.deep).to eq 1
		end

		it 'we can put cost a node' do
			@node_child.set_cost(5)
			expect(@node_child.cost).to eq 5
		end

	end

end