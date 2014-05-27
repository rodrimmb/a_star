require "graphviz"

class GenerateGraph
	def initialize
		@graph = GraphViz.new("G", :type => :digraph)
	end

	def get_svg
		a = @graph.add_nodes(
				"A", 
				:label => "{A|2}", 
				:style => "filled, rounded",
				:shape => "record", 
				:fillcolor => "#294b76",
				:fontname => "Trebuchet MS",
				:fontcolor => "white"
			)
		b = @graph.add_nodes("B", :label => "{B|5}", :style=>"rounded",:shape=>"record")

		@graph.add_edges(a,b)

		@graph.save(:svg => String)
		@graph.output(:svg => "String.svg")
	end
end