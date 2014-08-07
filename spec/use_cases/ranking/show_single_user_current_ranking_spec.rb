describe ShowSingleUserCurrentRanking do

  describe '#run' do

    it 'should return current RankingItem for specified user' do
      expected_ranking_item = RankingItem.new
      current_ranking_finder = CurrentRankingFinder.new(nil)

      expect(CurrentRankingFinder).to receive(:create_for_single_user).and_return(current_ranking_finder)
      expect(current_ranking_finder).to receive(:find).with(user_id: 5).and_return(expected_ranking_item)

      expect(subject.run(5)).to eq expected_ranking_item
    end
  end
end