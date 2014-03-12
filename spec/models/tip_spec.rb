describe Tip do

  it 'should have valid factory' do
    build(:tip).should be_valid
  end

  it 'should be extended with ModelBatchUpdatable' do
    Tip.singleton_class.included_modules.should include RecordBatchUpdatable
  end

  it 'should be included with ScoreValidatable' do
    Tip.included_modules.should include ScoreValidatable
  end

  describe 'validations' do

    let(:match) { create(:match) }
    subject { Tip.new(match: match) }

    describe 'for base' do

      context 'if not tippable' do

        it 'should validate no change in score_team_1' do
          subject.stub(:tippable?).and_return(false)
          subject.score_team_1 = 1
          subject.should_not be_valid
          subject.errors[:base].should include t('errors.messages.scores_not_changeable_after_match_started')
        end

        it 'should validate no change in score_team_2' do
          subject.stub(:tippable?).and_return(false)
          subject.score_team_2 = 1
          subject.should_not be_valid
          subject.errors[:base].should include t('errors.messages.scores_not_changeable_after_match_started')
        end
      end
    end

    describe 'for user' do
      it { should validate_presence_of :user }
    end

    describe 'for match' do
      it { should validate_presence_of :match }
    end

    describe 'for match_id' do
      it { should validate_uniqueness_of(:match_id).scoped_to(:user_id) }
    end
  end

  describe 'associations' do

    it { should belong_to(:user) }
    it { should belong_to(:match) }
  end

  describe '#scopes' do

    it 'should order tip by matches position' do
      tip_3 = create(:tip, match: create(:match, position: 3))
      tip_1 = create(:tip, match: create(:match, position: 1))
      tip_2 = create(:tip, match: create(:match, position: 2))

      actual_tips = Tip.order_by_match_position
      actual_tips.first.should eq tip_1
      actual_tips.second.should eq tip_2
      actual_tips.third.should eq tip_3
    end

    it 'should return all tips by given match' do
      match = create(:match)
      tip_1 = create(:tip, match: match)
      create(:tip, match: create(:match))
      tip_3 = create(:tip, match: match)

      tips = Tip.match_tips match.id
      tips.count.should eq 2
      tips.should include tip_1, tip_3
    end

    it 'should return all tipped tips' do
      tip_1 = create(:tip, score_team_1: 1, score_team_2: 0)
      create(:tip, score_team_1: nil, score_team_2: nil)
      tip_3 = create(:tip, score_team_1: 2, score_team_2: 2)

      tips = Tip.tipped
      tips.count.should eq 2
      tips.should include tip_1, tip_3
    end
  end

  describe '#tippable?' do

    let(:match) { Match.new }
    subject { Tip.new(match: match) }

    context 'if match has not started yet' do

      it 'should return false' do
        match.stub(:started?).and_return(true)
        subject.should_not be_tippable
      end
    end

    context 'if match has started' do

      it 'should return true' do
        match.stub(:started?).and_return(false)
        subject.should be_tippable
      end
    end
  end

  describe '#tipped?' do

    let(:match) { Match.new }
    subject { Tip.new(match: match)}

    it 'should return true if score_team_1 and score_team_2 are set' do
      subject.score_team_1 = 1
      subject.score_team_2 = 1

      subject.tipped?.should be_true
    end

    it 'should return true if score_team_1 is not set' do
      subject.score_team_1 = nil
      subject.score_team_2 = 1

      subject.tipped?.should be_false
    end

    it 'should return true if score_team_1 is not set' do
      subject.score_team_1 = 1
      subject.score_team_2 = nil

      subject.tipped?.should be_false
    end

    it 'should return false if score_team_1 and score_team_2 are not set' do
      subject.score_team_1 = nil
      subject.score_team_2 = nil

      subject.tipped?.should be_false
    end
  end

  describe '#points' do

    it 'should return correct tip points if correct tip' do
      subject.stub(:result).and_return(Tip::RESULTS[:correct])
      subject.points.should eq Ggp2.config.correct_tip_points
    end

    it 'should return incorrect tip points if incorrect tip' do
      subject.stub(:result).and_return(Tip::RESULTS[:incorrect])
      subject.points.should eq Ggp2.config.incorrect_tip_points
    end

    it 'should return correct tendency tip points if correct tendency tip' do
      subject.stub(:result).and_return(Tip::RESULTS[:correct_tendency])
      subject.points.should eq Ggp2.config.correct_tendency_tip_points
    end

    it 'should return nil if result is 0' do
      subject.stub(:result).and_return(nil)
      subject.points.should be_nil
    end
  end
end