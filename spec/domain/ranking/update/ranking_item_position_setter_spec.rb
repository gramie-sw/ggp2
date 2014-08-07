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

      expect(sorted_ranking_items[0]).to eq ranking_items[3]
      expect(sorted_ranking_items[0].position).to be 1
      expect(sorted_ranking_items[1]).to eq ranking_items[2]
      expect(sorted_ranking_items[1].position).to be 2
      expect(sorted_ranking_items[2]).to eq ranking_items[4]
      expect(sorted_ranking_items[2].position).to be 3
      expect(sorted_ranking_items[3]).to eq ranking_items[5]
      expect(sorted_ranking_items[3].position).to be 4
      expect(sorted_ranking_items[4]).to eq ranking_items[1]
      expect(sorted_ranking_items[4].position).to be 5
      expect(sorted_ranking_items[5]).to eq ranking_items[0]
      expect(sorted_ranking_items[5].position).to be 5
    end
  end
end