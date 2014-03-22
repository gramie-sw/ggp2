describe RankingItemSetPositionSetter do

  let(:ranking_items) do
    [
        build(:ranking_item, points: 5, correct_tips_count: 99, correct_tendency_tips_only_count: 99, user: build(:player, created_at: 8.days.ago)),
        build(:ranking_item, points: 5, correct_tips_count: 99, correct_tendency_tips_only_count: 99, user: build(:player, created_at: 9.days.ago)),
        build(:ranking_item, points: 6, correct_tips_count: 100, correct_tendency_tips_only_count: 100, user: build(:player, created_at: 10.days.ago)),
        build(:ranking_item, points: 5, correct_tips_count: 100, correct_tendency_tips_only_count: 100, user: build(:player, created_at: 10.day.ago)),
        build(:ranking_item, points: 5, correct_tips_count: 99, correct_tendency_tips_only_count: 100, user: build(:player, created_at: 10.days.ago))
    ]

  end


  describe '::set_ranking' do

  end

  #
  #describe '::sort' do
  #  it 'should sort ranking items by points and user creation date' do
  #    sorted_ranking_items = RankingItemSetPositionSetter.sort ranking_items
  #
  #    sorted_ranking_items[0].should eq ranking_items[2]
  #    sorted_ranking_items[1].should eq ranking_items[3]
  #    sorted_ranking_items[2].should eq ranking_items[4]
  #    sorted_ranking_items[3].should eq ranking_items[1]
  #    sorted_ranking_items[4].should eq ranking_items[0]
  #  end
  #end
end