describe ShowAllUserCurrentRanking do

  let(:users) do
    [
        create(:player),
        create(:player)
    ]
  end
  let(:presenter) { double('Presenter') }
  subject { ShowAllUserCurrentRanking.new }

  before :each do
    users
  end

  context 'when no current Tip-RankingItem for specified user exits' do

    it 'should return neutral RankingItem belonging to specified user' do


      expect(presenter).to receive(:ranking_items=) do |actual_ranking_items|

        expect(actual_ranking_items.count).to eq 2
        expect(actual_ranking_items.first.user_id).to eq users.first.id
        expect(actual_ranking_items.first).to be_neutral
        expect(actual_ranking_items.second.user_id).to eq users.second.id
        expect(actual_ranking_items.second).to be_neutral
      end

      subject.run(presenter, 1)
    end
  end

  context 'when current Tip-RankingItem for specified user exists' do

    it 'should return RankingItems' do
      match = create(:match)
      create(:ranking_item, user: users.first, position: 2, match: match)
      create(:ranking_item, user: users.second, position: 1, match: match)
      Property.set_last_tip_ranking_set_match_id_to match.id

      expect(presenter).to receive(:ranking_items=) do |actual_ranking_items|

        expect(actual_ranking_items.count).to eq 2
        expect(actual_ranking_items.first.user_id).to eq users.second.id
        expect(actual_ranking_items.second.user_id).to eq users.first.id
      end

      subject.run(presenter, 1)
    end
  end

  context 'when current Tip-RankingItem and ChampionTip-RankingItem for specified user exists' do

    it 'should return ChampionTip-RankingItems' do
      match = create(:match)
      create(:ranking_item, user: users.first, position: 2, match: nil)
      create(:ranking_item, user: users.second, position: 1, match: nil)

      Property.set_last_tip_ranking_set_match_id_to match.id
      Property.set_champion_tip_ranking_set_exists_to true

      expect(presenter).to receive(:ranking_items=) do |actual_ranking_items|

        expect(actual_ranking_items.count).to eq 2
        expect(actual_ranking_items.first.user_id).to eq users.second.id
        expect(actual_ranking_items.second.user_id).to eq users.first.id
      end

      subject.run(presenter, 1)
    end
  end
end