describe RankingItem do

  it 'should have valid factory' do
    build(:ranking_item).should be_valid
  end

  describe 'associations' do
    it { should belong_to(:match) }
    it { should belong_to(:user) }
  end

  describe 'scopes' do

    let(:ranking_items) do
      [
          create(:ranking_item, match_id: 12),
          create(:ranking_item, match_id: 13),
          create(:ranking_item, match_id: 12)
      ]
    end

    before(:each) do
      ranking_items
    end

    describe '::ranking_items_by_match_id' do
      it 'should return ranking items with given match id' do
        actual_ranking_items = RankingItem.ranking_items_by_match_id(12)
        actual_ranking_items.size.should eq 2
        actual_ranking_items.should include ranking_items.first, ranking_items.last
      end
    end
  end

  describe '#ranking_hash' do

    it 'should return ranking hash which consists of points correct tips count and correct tendency tips only count' do
      ranking_item = build(:ranking_item, points: 12, correct_tips_count: 13, correct_tendency_tips_only_count: 14)
      ranking_item.ranking_hash.should eq '0121314'
      ranking_item = build(:ranking_item, correct_champion_tip: true, points: 12, correct_tips_count: 13, correct_tendency_tips_only_count: 14)
      ranking_item.ranking_hash.should eq '1121314'
    end
  end

  describe '::neutral' do
    it 'should return neutral ranking item object' do
      neutral_ranking_item = RankingItem.neutral
      neutral_ranking_item.position.should eq 0
      neutral_ranking_item.correct_tips_count.should eq 0
      neutral_ranking_item.correct_tendency_tips_only_count.should eq 0
      neutral_ranking_item.points.should eq 0
    end
  end

  describe '::update_multiple' do

    let(:ranking_items) do
      [
          create(:ranking_item, match_id: 12, user_id: 12),
          create(:ranking_item, match_id: 13, user_id: 12)
      ]
    end

    before(:each) do
      ranking_items
    end

    it 'should update all given ranking items' do

      ranking_item_1 = build(:ranking_item, match_id: 12, user_id: 13)
      ranking_item_2 = build(:ranking_item, match_id: 12, user_id: 14)

      RankingItem.update_multiple(12, [ranking_item_1, ranking_item_2]).should be_true

      actual_ranking_items = RankingItem.all
      actual_ranking_items.size.should eq 3
      ranking_item_1.reload
      ranking_item_2.reload
      actual_ranking_items.should include ranking_items[1], ranking_item_1, ranking_item_2
    end

    it 'should update all given ranking items transactional' do
      ranking_item_1 = build(:ranking_item, match_id: 12, user_id: 13)
      ranking_item_1.should_receive(:save!).and_raise(ActiveRecord::Rollback)

      RankingItem.update_multiple(12, [ranking_item_1]).should be_false
      RankingItem.all.should include ranking_items[0], ranking_items[1]
    end
  end

  describe '::exists_by_match_id?' do

    let(:match_id) { 3 }
    let(:relation) { double('RankingItemRelation') }
    subject { RankingItem }

    context 'when RankingItems exists for given match_id' do

      it 'should return true' do
        relation.should_receive(:exists?).and_return(true)
        RankingItem.should_receive(:ranking_items_by_match_id).with(match_id).and_return(relation)
        subject.exists_by_match_id?(match_id).should be_true
      end
    end

    context 'when not RankingItem exist for given match_id' do

      it 'should return false' do
        relation.should_receive(:exists?).and_return(false)
        RankingItem.should_receive(:ranking_items_by_match_id).with(match_id).and_return(relation)
        subject.exists_by_match_id?(match_id).should be_false
      end
    end
  end
end
