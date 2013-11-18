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

		it 'should has a empty list with all the steps' do
			expect(@aStart.steps).to eq []
		end
	end

	context 'with arguments' do
		it 'should has a start node and end node' do
			startNode = Node.new
			endNode = Node.new
			aStart = AStar.new(startNode, endNode)
			expect(aStart.start_node).to eq startNode
			expect(aStart.end_node).to eq endNode
		end

		it 'should has a node start in open list' do
			startNode = Node.new
			endNode = Node.new
			aStart = AStar.new(startNode, endNode)
			expect(aStart.open_list[0]).to eq startNode
		end
	end
end