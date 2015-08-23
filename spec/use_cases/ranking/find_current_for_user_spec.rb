describe Ranking::FindCurrentForUser do

  subject { Ranking::FindCurrentForUser }
  let(:user) { create(:player) }

  context 'when no current Tip-RankingItem for specified user exits' do

    it 'should return neutral RankingItem belonging to specified user' do
      actual_ranking_item = subject.run(user_id: user.id)
      expect(actual_ranking_item).to be_neutral
      expect(actual_ranking_item.user_id).to eq user.id
    end
  end

  context 'when current Tip-RankingItem for specified user exists' do

    it 'should return RankingItem' do
      expected_ranking_item = create(:ranking_item, user: user)
      Property.set_last_tip_ranking_set_match_id_to expected_ranking_item.match.id

      expect(subject.run(user_id: user.id)).to eq expected_ranking_item
    end
  end

  context 'when current Tip-RankingItem and ChampionTip-RankingItem for specified user exists' do

    it 'should return ChampionTip-RankingItem' do
      tip_ranking_item = create(:ranking_item, user: user)
      expected_champion_tip_ranking_item = create(:ranking_item, user: user, match: nil)
      Property.set_last_tip_ranking_set_match_id_to tip_ranking_item.match.id
      Property.set_champion_tip_ranking_set_exists_to true

      expect(subject.run(user_id: user.id)).to eq expected_champion_tip_ranking_item
    end
  end
end