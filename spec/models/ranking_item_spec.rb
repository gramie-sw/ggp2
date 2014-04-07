describe RankingItem do

  it 'should have valid factory' do
    build(:ranking_item).should be_valid
  end

  describe 'associations' do
    it { should belong_to(:match) }
    it { should belong_to(:user) }
  end

  describe '#ranking_hash' do

    it 'should return ranking hash which consists of points correct tips count and correct tendency tips only count' do
      ranking_item = build(:ranking_item, points: 12, correct_tips_count: 13, correct_tendency_tips_only_count: 14)
      ranking_item.ranking_hash.should eq '0121314'
      ranking_item = build(:ranking_item, correct_champion_tip: true, points: 12, correct_tips_count: 13, correct_tendency_tips_only_count: 14)
      ranking_item.ranking_hash.should eq '1121314'
    end
  end

  describe '::neutral' do

    context 'when no user_id given' do

      it 'should return neutral RankingItem' do
        neutral_ranking_item = RankingItem.neutral
        #TODO add method neutral? to RankingItem
        neutral_ranking_item.user_id.should eq nil
        neutral_ranking_item.position.should eq 0
        neutral_ranking_item.correct_tips_count.should eq 0
        neutral_ranking_item.correct_tendency_tips_only_count.should eq 0
        neutral_ranking_item.points.should eq 0
      end
    end

    context 'when user_id is given' do

      it 'should return neutral RankingItem with given user_id' do
        neutral_ranking_item = RankingItem.neutral(5)
        neutral_ranking_item.user_id.should eq 5
        neutral_ranking_item.position.should eq 0
        neutral_ranking_item.correct_tips_count.should eq 0
        neutral_ranking_item.correct_tendency_tips_only_count.should eq 0
        neutral_ranking_item.points.should eq 0
      end
    end


  end
end
