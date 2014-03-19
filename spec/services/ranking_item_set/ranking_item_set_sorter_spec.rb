describe RankingItemSetSorter do

  let(:ranking_items) do
    [
        build(:ranking_item, points: 5, user: build(:player, created_at: 3.days.ago)),
        build(:ranking_item, points: 5, user: build(:player, created_at: 1.day.ago)),
        build(:ranking_item, points: 6, user: build(:player, created_at: 2.days.ago))
    ]

  end

  describe '::sort' do
    it 'should sort ranking items by points and user creation date' do
      sorted_ranking_items = RankingItemSetSorter.sort ranking_items

      sorted_ranking_items.first.should eq ranking_items.third
      sorted_ranking_items.second.should eq ranking_items.first
      sorted_ranking_items.third.should eq ranking_items.second
    end
  end
end