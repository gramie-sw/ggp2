describe Rankings::FindWinners do

  describe '#run' do

    ranking_items = [
        RankingItem.new(position: 3),
        RankingItem.new(position: 1),
        RankingItem.new(position: 3)
    ]

    before :each do
      expect(RankingItemQueries).to respond_to(:ranking_set_for_ranking_view_by_match_id)
      expect(RankingItemQueries).
          to receive(:ranking_set_for_ranking_view_by_match_id).with(nil, positions: [1,2,3]).and_return(ranking_items)
    end

    it 'returns result with correct RankingItem for place 1, 2 and 3' do
      result = subject.run

      expect(result.first_places).to eq [ranking_items[1]]
      expect(result.second_places).to eq []
      expect(result.third_places).to eq [ranking_items[0], ranking_items[2]]
    end
  end
end