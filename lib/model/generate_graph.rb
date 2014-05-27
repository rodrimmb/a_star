require "graphviz"

class GenerateGraph
	def initialize
		@graph = GraphViz.new(:type => :digraph)
	end

	def get_svg(nodes)
		nodes.each do |node|
			new_node(node)
		end

		nodes.each do |node|
			create_links(node)
		end
		
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
				:fillcolor => "#428bca",
				:fontcolor => "white"
			)
	end

	def create_links(node)
		father = node["name"]

		node["children"].each do |child|
			@graph.add_edges(
				father,
				child["name"], 
				:arrowhead=>"open", 
				:fontsize=>"15",
				:label => "#{child["path_cost"]}"
			)
		end
	end
end