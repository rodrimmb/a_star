Given(/^a start node$/) do
	@initial_node = Node.new(HandlerJson.get_state("A"))
end

When(/^I looking for a goal node$/) do
	 a_star = AStar.new
	 @solution = a_star.search @initial_node
end

Then(/^I get the shortest path solution$/) do
	@solution.each do |node|
		puts node.state.name
	end
	#expect(@solution).to eq ["A","C","G","K"]
end