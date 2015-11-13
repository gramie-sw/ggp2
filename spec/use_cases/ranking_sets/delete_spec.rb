describe RankingSets::Delete do

  subject { RankingSets::Delete }

  let(:user_1) { create(:player) }
  let(:user_2) { create(:player) }
  let(:match_1) { create(:match) }
  let(:match_2) { create(:match) }
  let(:match_3) { create(:match) }

  let!(:match_1_ranking_items) do
    [create(:ranking_item, user: user_1, match: match_1),
     create(:ranking_item, user: user_2, match: match_1)]
  end

  let!(:match_2_ranking_items) do
    [create(:ranking_item, user: user_1, match: match_2),
     create(:ranking_item, user: user_2, match: match_2)]
  end

  let!(:champion_tip_ranking_items) do
    [create(:ranking_item, user: user_1, match: nil),
     create(:ranking_item, user: user_2, match: nil)]
  end

  before :each do
    Property.set_champion_tip_ranking_set_exists_to(true)
  end

  describe '#run' do

    describe 'if no subsequent RankingSet exists it does not call Rankings::Update' do

      before :each do
        expect(Rankings::Update).not_to receive(:run)
        subject.run(match_id: match_2.id)
      end

      it 'deletes RankingSet for given match_id and ChampionTipRankingSet' do
        expect(RankingItem.all).to eq match_1_ranking_items
      end

      it 'sets last_tip_ranking_set_match_id and champion_tip_ranking_set_exists-Property' do
        expect(Property.last_tip_ranking_set_match_id).to be match_1.id
        expect(Property.champion_tip_ranking_set_exists?).to be false
      end
    end

    describe 'if subsequent RankingSet exits it calls Rankings::Update and' do

      let!(:match_3_ranking_items) do
        [create(:ranking_item, user: user_1, match: match_3),
         create(:ranking_item, user: user_2, match: match_3)]
      end

      before :each do
        expect(Rankings::Update).to receive(:run).with(match_id: match_3.id)
        subject.run(match_id: match_2.id)
      end

      it 'deletes RankingSet for given match_id and ChampionTipRankingSet' do
        expect(RankingItem.all).to eq match_1_ranking_items + match_3_ranking_items
      end

      it 'does not set last_tip_ranking_set_match_id-Property but sets champion_tip_ranking_set_exists-Property' do
        expect(Property.last_tip_ranking_set_match_id).to be_nil
        expect(Property.champion_tip_ranking_set_exists?).to be false
      end
    end
  end
end