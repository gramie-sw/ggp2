describe RankingItemQueries do

  subject { RankingItemQueries }


  describe '::find_by_user_id_and_match_id' do

    it 'should return ranking_item for given user_id and match_id' do
      create(:ranking_item, user_id: 2, match_id: 1)
      expected_ranking_item = create(:ranking_item, user_id: 2, match_id: 7)
      create(:ranking_item, user_id: 3, match_id: 7)

      expect(subject.find_by_user_id_and_match_id(user_id: 2, match_id: 7)).to eq expected_ranking_item
    end

  end

end