require "graphviz"

class GenerateGraph
	def initialize

	end

	def self.creator
		g = GraphViz.new("G", :type => :digraph)

		a = g.add_nodes("A")
		b = g.add_nodes("B")

		g.add_edges(a,b)

		graph = g.save(:svg => String)
	end
end