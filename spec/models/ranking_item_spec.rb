describe RankingItem, :type => :model do

  it 'should have valid factory' do
    expect(build(:ranking_item)).to be_valid
  end

  describe 'associations' do
    it { is_expected.to belong_to(:match) }
    it { is_expected.to belong_to(:user) }
  end

  describe '#ranking_hash' do

    it 'should return ranking hash which consists of points correct tips count and correct tendency tips only count' do
      ranking_item = build(:ranking_item, points: 12, correct_tips_count: 13, correct_tendeny_tips_count: 14)
      expect(ranking_item.ranking_hash).to eq '0121314'
      ranking_item = build(:ranking_item, correct_champion_tip: true, points: 12, correct_tips_count: 13, correct_tendeny_tips_count: 14)
      expect(ranking_item.ranking_hash).to eq '1121314'
    end
  end

  describe '::neutral' do

    context 'when no user_id given' do

      it 'should return neutral RankingItem where use_id is nil and position is 0' do
        actual_ranking_item = RankingItem.neutral
        expect(actual_ranking_item).to be_neutral
        expect(actual_ranking_item.user_id).to eq nil
        expect(actual_ranking_item.points).to eq 0
      end
    end

    context 'when user_id is given' do

      it 'should return neutral RankingItem with given user_id' do
        actual_ranking_item = RankingItem.neutral(5)
        expect(actual_ranking_item).to be_neutral
        expect(actual_ranking_item.user_id).to eq 5
      end
    end
  end

  describe '#neutral?' do

    subject { RankingItem.new(id: 0, position: 0, correct_tips_count: 0, correct_tendeny_tips_count: 0, points: 0) }

    context 'when all statistic and id are except points are 0' do

      it 'should return true' do
        expect(subject).to be_neutral
      end
    end

    context 'when at least one statistic value or id is not 0' do

      it 'should return false' do
        subject.correct_tips_count = nil
        expect(subject).not_to be_neutral
        subject.correct_tips_count = 1
        expect(subject).not_to be_neutral
      end
    end
  end
end
