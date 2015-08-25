describe Ranking::FindCurrentForUser do

  subject { Ranking::FindCurrentForUser }

  neutral_ranking_item = 'NeutralRankingItem'
  current_tip_ranking_item = 'CurrentTipRankingItem'
  champion_tip_ranking_item = 'ChampionTipRankingItem'
  user_id = 9854

  before :each do
    expect(RankingItem).to respond_to(:neutral)
    allow(RankingItem).to receive(:neutral).with(user_id).and_return(neutral_ranking_item)
  end

  context 'when no RankingSet exist' do

    it 'returns neutral RankingItem' do
      ranking_item = subject.run(user_id: user_id)
      expect(ranking_item).to be neutral_ranking_item
    end
  end

  context 'when RankingSets exist' do

    match_id = 1224

    before :each do
      expect(Property).to respond_to(:last_tip_ranking_set_match_id)
      allow(Property).to receive(:last_tip_ranking_set_match_id).and_return(match_id)
    end

    context 'when a Tip-RankingSet is the last updated one' do

      it 'returns RankinItem for given user_id of last updated Tip-RankingSet' do
        expect(RankingItemQueries).to respond_to(:find_by_user_id_and_match_id)
        expect(RankingItemQueries).to receive(:find_by_user_id_and_match_id).
                                          with(user_id: user_id, match_id: match_id).
                                          and_return(current_tip_ranking_item)

        ranking_item = subject.run(user_id: user_id)

        expect(ranking_item).to be current_tip_ranking_item
      end

      describe 'if current RankingSet has no RankingItem for specified user' do

        it 'returns neutral RankingItem' do
          expect(RankingItemQueries).to receive(:find_by_user_id_and_match_id).
                                            with(user_id: user_id, match_id: match_id).
                                            and_return(nil)

          ranking_item = subject.run(user_id: user_id)
          expect(ranking_item).to be neutral_ranking_item
        end
      end
    end

    context 'when the ChampionTip-RankingSet is the last updated one' do

      before :each do
        expect(Property).to respond_to(:champion_tip_ranking_set_exists?)
        allow(Property).to receive(:champion_tip_ranking_set_exists?).and_return(true)
      end

      it 'returns RankinItem with for user_id of ChampionTip-RankingSet' do
        expect(RankingItemQueries).to respond_to(:find_by_user_id_and_match_id)
        expect(RankingItemQueries).to receive(:find_by_user_id_and_match_id).
                                          with(user_id: user_id, match_id: nil).
                                          and_return(champion_tip_ranking_item)

        ranking_item = subject.run(user_id: user_id)

        expect(ranking_item).to be champion_tip_ranking_item
      end


      describe 'if current RankingSet has no RankingItem for specified user' do

        it 'returns neutral RankingItem' do
          expect(RankingItemQueries).to receive(:find_by_user_id_and_match_id).
                                            with(user_id: user_id, match_id: nil).
                                            and_return(nil)

          ranking_item = subject.run(user_id: user_id)
          expect(ranking_item).to be neutral_ranking_item
        end
      end
    end
  end
end