describe RankingItemRepository do

  subject { RankingItem }

  describe '::all_by_match_id' do

    it 'should return ranking items with given match id' do
      ranking_items = [
          create(:ranking_item, match_id: 12),
          create(:ranking_item, match_id: 13),
          create(:ranking_item, match_id: 12)
      ]

      actual_ranking_items = RankingItem.all_by_match_id(12)
      actual_ranking_items.size.should eq 2
      actual_ranking_items.should include ranking_items.first, ranking_items.last
    end
  end

  describe '::all_by_user_id_and_match_id' do

    it 'should return ranking items with given match id' do
      ranking_items = [
          create(:ranking_item, user_id: 7, match_id: 12),
          create(:ranking_item, user_id: 7, match_id: 13),
          create(:ranking_item, user_id: 7, match_id: 12),
          create(:ranking_item, user_id: 6, match_id: 12)
      ]

      actual_ranking_items = RankingItem.all_by_user_id_and_match_id(user_id: 7, match_id: 12)
      actual_ranking_items.size.should eq 2
      actual_ranking_items.should include ranking_items.first, ranking_items.third
    end
  end

  describe '::first_by_user_id_and_match_id' do

    it 'should return ranking_item for given user_id and match_id' do
      create(:ranking_item, user_id: 2, match_id: 1)
      expected_ranking_item = create(:ranking_item, user_id: 2, match_id: 7)
      create(:ranking_item, user_id: 3, match_id: 7)

      subject.first_by_user_id_and_match_id(user_id: 2, match_id: 7).should eq expected_ranking_item
    end
  end

  describe '::destroy_and_create_multiple' do

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

      subject.destroy_and_create_multiple(12, [ranking_item_1, ranking_item_2]).should be_true

      actual_ranking_items = RankingItem.all
      actual_ranking_items.size.should eq 3
      ranking_item_1.reload
      ranking_item_2.reload
      actual_ranking_items.should include ranking_items[1], ranking_item_1, ranking_item_2
    end

    it 'should update all given ranking items transactional' do
      ranking_item_1 = build(:ranking_item, match_id: 12, user_id: 13, points: -1)
      ranking_item_1.should_receive(:save).and_return(false)

      subject.destroy_and_create_multiple(12, [ranking_item_1]).should be_false
      subject.all.should include ranking_items[0], ranking_items[1]
    end
  end

  describe '::exists_by_match_id?' do

    let(:match_id) { 3 }
    let(:relation) { double('RankingItemRelation') }

    context 'when RankingItems exists for given match_id' do

      it 'should return true' do
        relation.should_receive(:exists?).and_return(true)
        subject.should_receive(:all_by_match_id).with(match_id).and_return(relation)
        subject.exists_by_match_id?(match_id).should be_true
      end
    end

    context 'when not RankingItem exist for given match_id' do

      it 'should return false' do
        relation.should_receive(:exists?).and_return(false)
        subject.should_receive(:all_by_match_id).with(match_id).and_return(relation)
        subject.exists_by_match_id?(match_id).should be_false
      end
    end
  end
end