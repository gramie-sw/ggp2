describe RankingItemPositionSetter do

  let(:ranking_items) do
    [
        RankingItem.new(points: 5, correct_tips_count: 99, correct_tendency_tips_only_count: 99, user: User.new(admin: false, created_at: 8.days.ago)),
        RankingItem.new(points: 5, correct_tips_count: 99, correct_tendency_tips_only_count: 99, user: User.new(admin: false, created_at: 9.days.ago)),
        RankingItem.new(points: 6, correct_tips_count: 100, correct_tendency_tips_only_count: 100, user: User.new(admin: false, created_at: 10.days.ago)),
        RankingItem.new(points: 6, correct_champion_tip: true, correct_tips_count: 100, correct_tendency_tips_only_count: 100, user: User.new(admin: false, created_at: 10.days.ago)),
        RankingItem.new(points: 5, correct_tips_count: 100, correct_tendency_tips_only_count: 100, user: User.new(admin: false, created_at: 10.day.ago)),
        RankingItem.new(points: 5, correct_tips_count: 99, correct_tendency_tips_only_count: 100, user: User.new(admin: false, created_at: 10.days.ago))
    ]
  end

  describe '::set_positions' do

    it 'should return sorted ranking items with position set' do
      sorted_ranking_items = RankingItemPositionSetter.set_positions ranking_items

      sorted_ranking_items[0].should eq ranking_items[3]
      sorted_ranking_items[0].position.should be 1
      sorted_ranking_items[1].should eq ranking_items[2]
      sorted_ranking_items[1].position.should be 2
      sorted_ranking_items[2].should eq ranking_items[4]
      sorted_ranking_items[2].position.should be 3
      sorted_ranking_items[3].should eq ranking_items[5]
      sorted_ranking_items[3].position.should be 4
      sorted_ranking_items[4].should eq ranking_items[1]
      sorted_ranking_items[4].position.should be 5
      sorted_ranking_items[5].should eq ranking_items[0]
      sorted_ranking_items[5].position.should be 5
    end
  end
end