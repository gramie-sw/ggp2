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

      it 'should return neutral RankingItem where use_id is nil and position is 0' do
        actual_ranking_item = RankingItem.neutral
        actual_ranking_item.should be_neutral
        actual_ranking_item.user_id.should eq nil
        actual_ranking_item.points.should eq 0
      end
    end

    context 'when user_id is given' do

      it 'should return neutral RankingItem with given user_id' do
        actual_ranking_item = RankingItem.neutral(5)
        actual_ranking_item.should be_neutral
        actual_ranking_item.user_id.should eq 5
      end
    end
  end

  describe '#neutral?' do

    subject { RankingItem.new(id: 0, position: 0, correct_tips_count: 0, correct_tendency_tips_only_count: 0, points: 0) }

    context 'when all statistic and id are except points are 0' do

      it 'should return true' do
        subject.should be_neutral
      end
    end

    context 'when at least one statistic value or id is not 0' do

      it 'should return false' do
        subject.correct_tips_count = nil
        subject.should_not be_neutral
        subject.correct_tips_count = 1
        subject.should_not be_neutral
      end
    end
  end
end
