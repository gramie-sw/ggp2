describe ShowSingleUserCurrentRanking do

  subject { ShowSingleUserCurrentRanking.new }
  let(:user) { create(:player) }

  context 'when no current Tip-RankingItem for specified user exits' do

    it 'should return neutral RankingItem belonging to specified user' do
      actual_ranking_item = subject.run(user.id)
      actual_ranking_item.should be_neutral
      actual_ranking_item.user_id.should eq user.id
    end
  end

  context 'when current Tip-RankingItem for specified user exists' do

    it 'should return RankingItem' do
      expected_ranking_item = create(:ranking_item, user: user)
      Property.set_last_tip_ranking_set_match_id_to expected_ranking_item.match.id

      subject.run(user.id).should eq expected_ranking_item
    end
  end

  context 'when current Tip-RankingItem and ChampionTip-RankingItem for specified user exists' do

    it 'should return ChampionTip-RankingItem' do
      tip_ranking_item = create(:ranking_item, user: user)
      expected_champion_tip_ranking_item = create(:ranking_item, user: user, match: nil)
      Property.set_last_tip_ranking_set_match_id_to tip_ranking_item.match.id
      Property.set_champion_tip_ranking_set_exists_to true

      subject.run(user.id).should eq expected_champion_tip_ranking_item
    end
  end
end