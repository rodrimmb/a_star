require 'a_star'
require 'node'

describe 'AStar' do
	context 'without arguments' do
		before(:each) do
      		@aStart = AStar.new
    	end

		it 'should has open list empty' do
			expect(@aStart.open_list).to eq []
		end

		it 'should has a close list empty' do
			expect(@aStart.closed_list).to eq []
		end
	end

	context 'with arguments' do
		before(:each) do
      		@startNode = Node.new
			@endNode = Node.new
			@aStart = AStar.new(@startNode, @endNode)
    	end

		it 'should has a start node and end node' do
			expect(@aStart.start_node).to eq @startNode
			expect(@aStart.end_node).to eq @endNode
		end

		it 'should has a start node in the open list' do
			expect(@aStart.open_list.first).to eq @startNode
		end

		it 'if we don\'t search open list' do
			expect(@aStart.closed_list).to eq []
		end
	end

	context 'search' do
		it 'start node is the goals node' do
			startNode = Node.new()
			aStart = AStar.new(startNode, startNode)

			expect(aStart.search.closed_list).to eq startNode
			expect(aStart.search.open_list).to eq []
		end

	end
end