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

  describe '::ranking_set_for_ranking_view_by_match_id' do

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
      actual_ranking_items = subject.ranking_set_for_ranking_view_by_match_id(match_id)
      expect(actual_ranking_items).to eq [ranking_items[1], ranking_items[2], ranking_items[0], ranking_items[3]]
    end


    it 'returns RankinItems with no match_id if given match_id is nil' do
      actual_ranking_items = subject.ranking_set_for_ranking_view_by_match_id(nil)
      expect(actual_ranking_items).to eq [ranking_items[6], ranking_items[5]]
    end

    it 'paginates RankingItems' do
      actual_ranking_items = subject.ranking_set_for_ranking_view_by_match_id(match_id, page: 2, per_page: 2)

      expect(actual_ranking_items).to eq [ranking_items[0], ranking_items[3]]
      expect(actual_ranking_items.count).to be 2
      expect(actual_ranking_items.current_page).to be 2
      expect(actual_ranking_items.total_count).to be 4
    end

    it 'returns only RankingItems with certain position if position is given' do
      actual_ranking_items = subject.ranking_set_for_ranking_view_by_match_id(match_id, positions: [1,2])
      expect(actual_ranking_items).to eq [ranking_items[1], ranking_items[2]]
    end
  end

end