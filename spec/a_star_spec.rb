require 'a_star'

describe 'AStar' do
	it 'should has open list empty' do
		aStart = AStar.new
		expect(aStart.openList).to eq([])
	end
end