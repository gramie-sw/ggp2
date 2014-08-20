describe FindWinnerRanking do

  describe '#run' do

    it 'should fill presenter' do

      winner_ranking_items = [
          create(:ranking_item, match: nil, position: 2),
          create(:ranking_item, match: nil, position: 1),
          create(:ranking_item, match: nil, position: 2),
          create(:ranking_item, match: nil, position: 3)
      ]

      presenter = double('Presenter')
      expect(presenter).to receive(:first_places=) do |actual_ranking_items|
        expect(actual_ranking_items.count).to eq 1
        expect(actual_ranking_items).to include winner_ranking_items.second
      end

      expect(presenter).to receive(:second_places=) do |actual_ranking_items|
        expect(actual_ranking_items.count).to eq 2
        expect(actual_ranking_items).to include winner_ranking_items.first, winner_ranking_items.third
      end

      expect(presenter).to receive(:third_places=) do |actual_ranking_items|
        expect(actual_ranking_items.count).to eq 1
        expect(actual_ranking_items).to include winner_ranking_items.fourth
      end

      subject.run(presenter)
    end
  end
end