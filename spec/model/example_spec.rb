require 'model/example'


describe Example do 

	before(:each) do
		res = "./res/tree.json" 
		json = File.read(res)

		@tree = JSON.parse(json)

		name = @tree["node"]["node_name"]
		value = @tree["node"]["value"].to_i
		if @tree["node"]["goal"] == "true" then goal = true else goal = false end
		children = @tree["node"]["children"]

		@node = Example.new(value, name, goal, children)
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
		children = @tree["node"]["children"].map do |child|
			child = Example.new(child["node"]["value"].to_i, 
								child["node"]["node_name"], 
								if child["node"]["goal"] == "true" then goal = true else goal = false end,
								child["node"]["children"])
		end

		expect(@node.expand).to eq children
	end

	it 'first node children are Example classes' do 
		expect(@node.expand[0].class.to_s).to eq "Example"
	end

	it 'first node children B has a value 5' do 
		expect(@node.expand[0].value).to eq 5
	end

	it 'can access to node D' do 
		expect(@node.expand[0].expand[0].name).to eq "D"
	end

end