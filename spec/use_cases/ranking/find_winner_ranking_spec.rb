describe FindWinnerRanking do

  describe '#run' do

    it 'should fill presenter' do

      winner_ranking_items = [
          create(:ranking_item, match: nil, position: 2),
          create(:ranking_item, match: nil, position: 1),
          create(:ranking_item, match: nil, position: 2),
          create(:ranking_item, match: nil, position: 3)
      ]

      result = subject.run

      expect(result).to be_an_instance_of(FindWinnerRanking::Result)

      expect(result.first_places.size).to eq 1
      expect(result.first_places.first).to eq winner_ranking_items.second

      expect(result.second_places.size).to eq 2
      expect(result.second_places).to include(winner_ranking_items.first, winner_ranking_items.third)

      expect(result.third_places.size).to eq 1
      expect(result.third_places.first).to eq winner_ranking_items.fourth
    end
  end
end