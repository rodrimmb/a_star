require 'model/generate_graph'

describe GenerateGraph do 
	it 'genrate a graph' do
		g = GenerateGraph.new
		puts g.get_svg
	end
end
