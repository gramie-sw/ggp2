describe RankingItem do

  it 'should have valid factory' do
    build(:ranking_item).should be_valid
  end

  describe 'associations' do
    it { should belong_to(:match) }
    it { should belong_to(:user) }
  end

  describe '::neutral' do
    it 'should return neutral ranking item object' do
      neutral_ranking_item = RankingItem.neutral
      neutral_ranking_item.position.should eq 0
      neutral_ranking_item.correct_tips_count.should eq 0
      neutral_ranking_item.correct_tendency_tips_only_count.should eq 0
      neutral_ranking_item.points.should eq 0
    end
  end
end
