describe ShowAllUserCurrentRanking do

  describe '#run' do

    let(:presenter) { double('Presenter') }

    it 'should return current RankingItems for all users' do
      expected_ranking_items = double('CurrentRankingItems')
      current_ranking_finder = CurrentRankingFinder.new(nil)

      CurrentRankingFinder.should_receive(:create_for_all_users).and_return(current_ranking_finder)
      current_ranking_finder.should_receive(:find).with(page: 2).and_return(expected_ranking_items)

      presenter.should_receive(:ranking_items=).with do |actual_ranking_items|
        actual_ranking_items.should be actual_ranking_items
      end

      subject.run(presenter, 2)
    end
  end
end