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
      expect(actual_ranking_items.size).to eq 2
      expect(actual_ranking_items).to include ranking_items.first, ranking_items.last
    end
  end

  describe '::exists_by_match_id?' do

    let(:match_id) { 3 }
    let(:relation) { double('RankingItemRelation') }

    context 'when RankingItems exists for given match_id' do

      it 'should return true' do
        expect(relation).to receive(:exists?).and_return(true)
        expect(subject).to receive(:all_by_match_id).with(match_id).and_return(relation)
        expect(subject.exists_by_match_id?(match_id)).to be_truthy
      end
    end

    context 'when not RankingItem exist for given match_id' do

      it 'should return false' do
        expect(relation).to receive(:exists?).and_return(false)
        expect(subject).to receive(:all_by_match_id).with(match_id).and_return(relation)
        expect(subject.exists_by_match_id?(match_id)).to be_falsey
      end
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

    it 'should destroy and create all given ranking items' do

      ranking_item_1 = build(:ranking_item, match_id: 12, user_id: 13)
      ranking_item_2 = build(:ranking_item, match_id: 12, user_id: 14)

      expect(subject.destroy_and_create_multiple(12, [ranking_item_1, ranking_item_2])).to be_truthy

      actual_ranking_items = RankingItem.all
      expect(actual_ranking_items.size).to eq 3
      ranking_item_1.reload
      ranking_item_2.reload
      expect(actual_ranking_items).to include ranking_items[1], ranking_item_1, ranking_item_2
    end

    it 'should update all given ranking items transactional' do
      ranking_item_1 = build(:ranking_item, match_id: 12, user_id: 13, points: -1)
      expect(ranking_item_1).to receive(:save).and_return(false)

      expect(subject.destroy_and_create_multiple(12, [ranking_item_1])).to be_falsey
      expect(subject.all).to include ranking_items[0], ranking_items[1]
    end
  end

  describe '::ranking_set_for_listing' do

    it 'should return paginated RankingItems with given match_id ordered by position' do
      match = create(:match)
      create(:ranking_item, position: 3, match: match)
      expected_ranking_item_1 = create(:ranking_item, position: 1, match: match)
      expected_ranking_item_2 = create(:ranking_item, position: 2, match: match)
      create(:ranking_item)

      actual_ranking_items = subject.ranking_set_for_listing(match_id: match.id, page: 1, per_page: 2)
      expect(actual_ranking_items.count).to eq 2
      expect(actual_ranking_items.first).to eq expected_ranking_item_1
      expect(actual_ranking_items.second).to eq expected_ranking_item_2
    end

    it 'should includes user, champion_tip and team' do
      relation = double('RankingItemRelation')
      relation.as_null_object

      expect(relation).to receive(:includes).with(user: {champion_tip: :team})
      expect(subject).to receive(:where).and_return(relation)

      subject.ranking_set_for_listing(match_id: nil, page: nil, per_page: nil)
    end
  end

  describe '::ranking_set_for_listing_by_positions' do

    it 'should return RankingItems with given match_id for given positions' do
      match = create(:match)
      create(:ranking_item, position: 3, match: match)
      expected_ranking_item_1 = create(:ranking_item, position: 1, match: match)
      expected_ranking_item_2 = create(:ranking_item, position: 2, match: match)
      expected_ranking_item_3 = create(:ranking_item, position: 2, match: match)
      create(:ranking_item, position: 1)

      actual_ranking_items = subject.ranking_set_for_listing_by_positions(match_id: match.id, positions: [1, 2])
      expect(actual_ranking_items.count).to eq 3
      expect(actual_ranking_items).to include expected_ranking_item_1, expected_ranking_item_2, expected_ranking_item_3
    end

    it 'should use scope ranking_set_for_listing and set match_id, page and per_page nil by default' do
      relation = double('RankingSetRelation')
      relation.as_null_object
      expect(subject).
          to receive(:ranking_set_for_listing).with(match_id: nil, page: nil, per_page: nil).
          and_return(relation)
      subject.ranking_set_for_listing_by_positions(positions: 1)
    end
  end
end