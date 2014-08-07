describe ShowAllUserCurrentRanking do

  describe '#run' do

    let(:presenter) { double('Presenter') }

    it 'should return current RankingItems for all users' do
      expected_ranking_items = double('CurrentRankingItems')
      current_ranking_finder = CurrentRankingFinder.new(nil)

      expect(CurrentRankingFinder).to receive(:create_for_all_users).and_return(current_ranking_finder)
      expect(current_ranking_finder).to receive(:find).with(page: 2).and_return(expected_ranking_items)

      expect(presenter).to receive(:ranking_items=) do |actual_ranking_items|
        expect(actual_ranking_items).to be actual_ranking_items
      end

      subject.run(presenter, 2)
    end
  end
end