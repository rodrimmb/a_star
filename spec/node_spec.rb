require 'node'

describe Node do
		it 'shold has a name' do
			name = "A" 
			node = Node.new(name)

			expect(node.name).to eq "A"
		end
end