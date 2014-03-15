describe UserStatistic do

  let(:user) { build(:player) }
  let(:current_ranking_item) { build(:ranking_item, user: user, position: 3) }
  let(:tournament) { Tournament.new }
  let(:subject_with_not_current_ranking_item) { UserStatistic.new(user: user, tournament: tournament) }
  subject { UserStatistic.new(user: user, tournament: tournament, current_ranking_item: current_ranking_item) }

  describe '#position' do

    context 'if current ranking item is present' do

      it 'should return position of current_ranking_item' do
        subject.position.should eq current_ranking_item.position
      end
    end

    context 'if current ranking item is not present' do
      subject { subject_with_not_current_ranking_item }

      it 'should return 0' do
        subject.position.should eq 0
      end
    end
  end

  describe 'correct_ips_count' do

    context 'if current ranking item is present' do

      it 'should return correct_tips_count of current_ranking_item' do
        subject.correct_tips_count.should eq current_ranking_item.correct_tips_count
      end
    end

    context 'if current ranking item is not present' do
      subject { subject_with_not_current_ranking_item }

      it 'should return 0' do
        subject.correct_tips_count.should eq 0
      end
    end
  end

  describe 'correct_tendency_tips_only_count' do

    context 'if current ranking item is present' do

      it 'should return correct_tendency_tips_only_count of current_ranking_item' do
        subject.correct_tendency_tips_only_count.should eq current_ranking_item.correct_tendency_tips_only_count
      end
    end

    context 'if current ranking item is not present' do
      subject { subject_with_not_current_ranking_item }

      it 'should return 0' do
        subject.correct_tendency_tips_only_count.should eq 0
      end
    end
  end

end