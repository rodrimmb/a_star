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
		it 'should has a start node' do
			start = Node.new
			aStart = AStar.new(start)
			expect(aStart.start_node).to eq start
		end

	end
end