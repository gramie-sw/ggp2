describe RankingItem do

  it 'should have valid factory' do
    build(:ranking_item).should be_valid
  end

  describe 'associations' do
    it { should belong_to(:match) }
    it { should belong_to(:user) }
  end

  describe 'scopes' do

    describe 'ranking_items' do

      it 'should return all ranking items by given match_id' do
        match = create(:match)

        ranking_item_1 = create(:ranking_item, match: match)
        create(:ranking_item)
        ranking_item_2 = create(:ranking_item, match: match)

        ranking_items = RankingItem.ranking_items match.id
        ranking_items.size.should eq 2
        ranking_items.should include ranking_item_1, ranking_item_2
      end
    end
  end
end
