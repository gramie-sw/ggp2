describe RankingItems::FindWinners do

  describe '#run' do

    ranking_items = [
        RankingItem.new(position: 1),
        RankingItem.new(position: 3),
        RankingItem.new(position: 3)
    ]

    before :each do
      expect(RankingItemQueries).to respond_to(:paginated_by_match_id_for_ranking_view)
      expect(RankingItemQueries).
          to receive(:paginated_by_match_id_for_ranking_view).with(nil, page: 1, per_page: 3).and_return(ranking_items)
    end

    it 'returns result with correct RankingItem for place 1, 2 and 3' do
      result = subject.run

      expect(result.first_places).to eq [ranking_items[0]]
      expect(result.second_places).to eq []
      expect(result.third_places).to eq [ranking_items[1], ranking_items[2]]
    end
  end
end