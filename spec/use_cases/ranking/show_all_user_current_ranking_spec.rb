describe ShowAllUserCurrentRanking do

  describe '#run' do

    it 'should return current RankingItems for all users' do
      expected_ranking_items = double('CurrentRankingItems')
      current_ranking_finder = CurrentRankingFinder.new(nil)

      CurrentRankingFinder.should_receive(:create_for_all_users).and_return(current_ranking_finder)
      current_ranking_finder.should_receive(:find).with(page: 2).and_return(expected_ranking_items)

      subject.run(2).should eq expected_ranking_items
    end
  end
end