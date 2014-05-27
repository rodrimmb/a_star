require "graphviz"

class GenerateGraph
	def initialize
		@graph = GraphViz.new("G", :type => :digraph)
	end

	def get_svg
		new_node({"name" => "A", "cost" => 5})
		new_node({"name" => "B", "cost" => 12})
		new_node({"name" => "C", "cost" => 2})

		@graph.add_edges("A","B", 
			:arrowhead=>"open", 
			:fontname=>"Trebuchet MS", 
			:fontsize=>"15",
			:label => "8"
		)

		@graph.add_edges("A","C", 
			:arrowhead=>"open", 
			:fontname=>"Trebuchet MS", 
			:fontsize=>"15",
			:label => "4"
		)

		@graph.output(:svg => "String.svg")
		@graph.save(:svg => String)
	end

	private

	def new_node(node)
		@graph.add_nodes(
				"#{node["name"]}",
				:id => "#{node["name"]}", 
				:label => "{#{node["name"]}|#{node["cost"]}}", 
				:style => "filled,rounded",
				:shape => "record",
				:fontname => "Trebuchet MS",
				:fillcolor => "#428bca",
				:fontcolor => "white"
			)
	end
end