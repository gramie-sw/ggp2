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

  describe '::order_by_position_asc' do

    it 'should return RankingItems ordered by position' do
      ranking_item_3 = create(:ranking_item, position: 3)
      ranking_item_1 = create(:ranking_item, position: 1)
      ranking_item_2 = create(:ranking_item, position: 2)

      actual_ranking_items = subject.ordered_by_position_asc
      actual_ranking_items.count.should eq 3
      actual_ranking_items.first.should eq ranking_item_1
      actual_ranking_items.second.should eq ranking_item_2
      actual_ranking_items.third.should eq ranking_item_3
    end
  end

  describe '::query_list_ranking_set' do

    it 'should return paginated RankingItems with given match_id ordered by position' do
      match = create(:match)
      create(:ranking_item, position: 3, match: match)
      expected_ranking_item_1 = create(:ranking_item, position: 1, match: match)
      expected_ranking_item_2 = create(:ranking_item, position: 2, match: match)
      create(:ranking_item)

      actual_ranking_items = subject.query_list_ranking_set(match_id: match.id, page: 1, per_page: 2)
      actual_ranking_items.count.should eq 2
      actual_ranking_items.first.should eq expected_ranking_item_1
      actual_ranking_items.second.should eq expected_ranking_item_2
    end

    it 'should includes user' do
      relation = double('RankingItemRelation')
      relation.as_null_object

      relation.should_receive(:includes).with(:user)
      subject.should_receive(:where).and_return(relation)

      subject.query_list_ranking_set(match_id: nil, page: nil, per_page: nil)
    end
  end
end