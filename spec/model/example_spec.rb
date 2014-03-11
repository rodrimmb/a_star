require 'model/example'


describe Example do 

	before(:each) do
		
    end

	it 'first node has a name A' do
		expect(@node.name).to eq "A"
	end

	it 'first node is not a goal node' do 
		expect(@node.is_final?).to be_false
	end
	
	it 'first node has children' do 
		expect(@node.has_children?).to be_true
	end

	it 'first node return its children' do 
		expect(@node.expand).to eq children
	end
end