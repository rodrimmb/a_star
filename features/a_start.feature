Feature: I have to find the shortest path to the goal node in a tree given in a json
	Given a json with a tree structure
	As a user 
	I want to know the path to a goal node

	Scenario: Shortest path
		Given A start node and goal node
		When I want to know the path in the tree
		Then the result is the shortest path

