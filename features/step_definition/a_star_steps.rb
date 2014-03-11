Given(/^A start node and goal node$/) do
	res = "./res/tree.json" 
	json = File.read(res)

	@tree = JSON.parse(json)

	name = @tree["node"]["node_name"]
	value = @tree["node"]["value"].to_i
	if @tree["node"]["goal"] == "true" then goal = true else goal = false end
	children = @tree["node"]["children"]

	@initial_node = Node.new(Example.new(value, name, goal, children))
end

When(/^I want to know the path in the tree$/) do
	@a_star = AStar.new
	@path = @a_star.find_path(@initial_node) 
end

Then(/^the result is the shortest path$/) do
	
end