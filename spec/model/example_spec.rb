require 'model/example'


describe Example do 

	it 'first node has a name A' do
		res = "./res/tree.json" 
		json = File.read(res)

		tree = JSON.parse(json)

		name = tree["node"]["node_name"]
		value = tree["node"]["value"].to_i
		if tree["node"]["goal"] == "true" then goal = true else goal = false end
		children = tree["node"]["children"]

		node = Example.new(value, name, goal, children)
		expect(node.name).to eq "A"
	end
	
end