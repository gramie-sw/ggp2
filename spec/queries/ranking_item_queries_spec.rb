describe RankingItemQueries do

  subject { RankingItemQueries }


  describe '::find_by_user_id_and_match_id' do

    let!(:ranking_items) do
      [
          RankingItem.create_unvalidated(user_id: 2, match_id: 1),
          RankingItem.create_unvalidated(user_id: 2, match_id: 7),
          RankingItem.create_unvalidated(user_id: 3, match_id: 7)
      ]
    end

    it 'returns ranking_item for given user_id and match_id' do
      expect(subject.find_by_user_id_and_match_id(user_id: 2, match_id: 7)).to eq ranking_items.second
    end
  end

  describe '::all_by_match_id' do

    it 'should return ranking items with given match id' do
      ranking_items = [
          RankingItem.create_unvalidated(match_id: 12),
          RankingItem.create_unvalidated(match_id: 13),
          RankingItem.create_unvalidated(match_id: 12)
      ]

      actual_ranking_items = RankingItemQueries.all_by_match_id(12)
      expect(actual_ranking_items).to eq [ranking_items.first, ranking_items.last]
    end
  end

  describe '::exists_by_match_id?' do

    match_id = 765

    it 'returns true if RankingItem with given match_id exists' do
      RankingItem.create_unvalidated(match_id: match_id)
      expect(subject.exists_by_match_id?(match_id)).to be true
    end

    it 'returns false if RankingItem with given match_id does not exist' do
      RankingItem.create_unvalidated(match_id: match_id)
      expect(subject.exists_by_match_id?(match_id)).to be true
    end
  end

  describe '::paginated_by_match_id_for_ranking_view' do

    match_id = 567

    let!(:ranking_items) do
      [
          RankingItem.create_unvalidated(match_id: match_id, position: 3),
          RankingItem.create_unvalidated(match_id: match_id, position: 1),
          RankingItem.create_unvalidated(match_id: match_id, position: 2),
          RankingItem.create_unvalidated(match_id: match_id, position: 4),
          RankingItem.create_unvalidated(match_id: match_id+1, position: 2),
          RankingItem.create_unvalidated(match_id: nil, position: 2),
          RankingItem.create_unvalidated(match_id: nil, position: 1)
      ]
    end

    it 'returns RankingItems with given match_id ordered by position' do
      actual_ranking_items = subject.paginated_by_match_id_for_ranking_view(match_id)
      expect(actual_ranking_items).to eq [ranking_items[1], ranking_items[2], ranking_items[0], ranking_items[3]]
    end


    it 'returns RankinItems with no match_id if given match_id is nil' do
      actual_ranking_items = subject.paginated_by_match_id_for_ranking_view(nil)
      expect(actual_ranking_items).to eq [ranking_items[6], ranking_items[5]]
    end

    it 'paginates RankingItems' do
      actual_ranking_items = subject.paginated_by_match_id_for_ranking_view(match_id, page: 2, per_page: 2)

      expect(actual_ranking_items).to eq [ranking_items[0], ranking_items[3]]
      expect(actual_ranking_items.count).to be 2
      expect(actual_ranking_items.current_page).to be 2
      expect(actual_ranking_items.total_count).to be 4
    end
  end

  describe '::destroy_and_create_multiple' do

    let!(:ranking_items) do
      [
          create(:ranking_item, match_id: 12, user_id: 12),
          create(:ranking_item, match_id: 13, user_id: 12)
      ]
    end

    it 'destroys and creates all given ranking items' do

      ranking_item_1 = build(:ranking_item, match_id: 12, user_id: 13)
      ranking_item_2 = build(:ranking_item, match_id: 12, user_id: 14)

      expect(subject.destroy_and_create_multiple(12, [ranking_item_1, ranking_item_2])).to be true

      actual_ranking_items = RankingItem.all
      expect(actual_ranking_items.size).to eq 3
      ranking_item_1.reload
      ranking_item_2.reload
      expect(actual_ranking_items).to include ranking_items[1], ranking_item_1, ranking_item_2
    end

    it 'should update all given ranking items transactional' do
      ranking_item_1 = build(:ranking_item, match_id: 12, user_id: 13, points: -1)
      expect(ranking_item_1).to receive(:save).and_return(false)

      expect(subject.destroy_and_create_multiple(12, [ranking_item_1])).to be false
      expect(RankingItem.all).to include ranking_items[0], ranking_items[1]
    end
  end

end