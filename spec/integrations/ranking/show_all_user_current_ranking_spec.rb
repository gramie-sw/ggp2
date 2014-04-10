describe ShowAllUserCurrentRanking do

  subject { ShowAllUserCurrentRanking.new }
  let(:user) { create(:player) }

  # context 'when no current Tip-RankingItem for specified user exits' do
  #
  #   it 'should return neutral RankingItem belonging to specified user' do
  #     user_1 = create(:user)
  #     user_2 = create(:user)
  #
  #     actual_ranking_items = subject.run(2)
  #     actual_ranking_items.count.should eq 2
  #     # actual_ranking_item.user_id.should eq user.id
  #   end
  # end
end