require 'a_star'

describe 'AStar' do
	it 'should has open list empty' do
		aStart = AStar.new
		aStart.openList should be []
	end
end