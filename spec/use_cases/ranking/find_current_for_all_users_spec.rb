describe Ranking::FindCurrentForAllUsers do

  let(:matches) {
    [
        create(:match),
        create(:match)
    ]
  }


  let(:ranking_items) {
    [
        create(:ranking_item, match: matches.first),
        create(:ranking_item, match: matches.second, position: 2),
        create(:ranking_item, match: matches.first),
        create(:ranking_item, match: matches.second, position: 3),
        create(:ranking_item, match: matches.second, position: 1)
    ]
  }

  subject { Ranking::FindCurrentForAllUsers }

  before :each do
    ranking_items
  end

  describe '#run' do

    it 'should return current RankingItems for all users by given page' do

      expect(AllUserRankingProvider).to receive(:user_page_count).and_return(2)
      expect(Property).to receive(:last_tip_ranking_set_match_id).and_return(matches.second.id)

      actual_ranking_items = subject.run(page: 2)

      expect(actual_ranking_items.size).to eq 1
      expect(actual_ranking_items.first).to eq ranking_items.fourth
    end
  end
end