require 'node'

describe Node do
		it 'shold has a name' do
			name = "A" 
			node = Node.new(name)

			expect(node.name).to eq "A"
		end

		it 'has a 0 deep if it hasn\'t parent' do
			name = "A"
			node = Node.new(name)

			expect(node.deep).to eq 0
		end
end