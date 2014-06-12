describe UserStatistic do

  let(:user) { build(:player) }
  let(:current_ranking_item) { build(:ranking_item, user: user, position: 3) }
  let(:tournament) { Tournament.new }
  subject { UserStatistic.new(user: user, tournament: tournament, current_ranking_item: current_ranking_item) }

  it 'should delegate badges_count to RankingItem#user' do
    expect(user).to receive(:badges_count).and_return(5)
    expect(subject.badges_count).to eq 5
  end

  describe '#position' do

    context 'if current ranking item is present' do

      it 'should return position of current_ranking_item' do
        subject.position.should eq current_ranking_item.position
      end
    end
  end

  describe '#correct_tips_count' do

    it 'should return correct_tips_count of current_ranking_item' do
      subject.correct_tips_count.should eq current_ranking_item.correct_tips_count
    end
  end

  describe 'correct_tendency_tips_only_count' do

    it 'should return correct_tendency_tips_only_count of current_ranking_item' do
      subject.correct_tendency_tips_only_count.should eq current_ranking_item.correct_tendency_tips_only_count
    end
  end

  describe '#correct_tips_ratio' do

    context 'if no match has already been played' do

      it 'should return 0' do
        tournament.stub(:played_match_count).and_return(0)
        subject.correct_tips_ratio.should eq 0
      end
    end

    context 'if matches has been played' do

      it 'should return rounded ratio' do
        tournament.stub(:played_match_count).and_return(9)
        subject.stub(:correct_tips_count).and_return(4)
        subject.correct_tips_ratio.should eq 44

      end
    end
  end

  describe '#correct_tendency_tips_only_ratio' do

    context 'if no match has already been played' do

      it 'should return 0' do
        tournament.stub(:played_match_count).and_return(0)
        subject.correct_tendency_tips_only_ratio.should eq 0
      end
    end

    context 'if matches has been played' do

      it 'should return rounded ratio' do
        tournament.stub(:played_match_count).and_return(9)
        subject.stub(:correct_tendency_tips_only_count).and_return(4)
        subject.correct_tendency_tips_only_ratio.should eq 44
      end
    end
  end

end