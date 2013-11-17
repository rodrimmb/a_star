require 'a_star'

describe 'AStar' do
	context 'When we dont pass any argument to A star' do
		it 'should has open list empty' do
			aStart = AStar.new
			expect(aStart.open_list).to eq []
		end

		it 'should has a close list empty' do
			aStart = AStar.new
			expect(aStart.closed_list).to eq []
		end
	end
end