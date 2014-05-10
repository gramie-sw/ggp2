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

  it 'should be included with TipRepository' do
    expect(Tip.included_modules).to include(TipRepository)
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

  describe '::MISSED' do

    it 'should not be one of ::RESULTS values' do
      expect(Tip::RESULTS.values).not_to include(Tip::MISSED)
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
      subject.result = Tip::RESULTS[:correct]
      subject.points.should eq Ggp2.config.correct_tip_points
    end

    it 'should return incorrect tip points if incorrect tip' do
      subject.result = Tip::RESULTS[:incorrect]
      subject.points.should eq Ggp2.config.incorrect_tip_points
    end

    it 'should return correct tendency tip only points if correct tendency tip only' do
      subject.result = Tip::RESULTS[:correct_tendency_only]
      subject.points.should eq Ggp2.config.correct_tendency_tip_only_points
    end

    it 'should return 0 if result is nil' do
      subject.result = nil
      subject.points.should eq 0
    end
  end

  describe 'correct?' do

    context 'when result is correct' do

      it 'should return true' do
        subject.result = Tip::RESULTS[:correct]
        subject.should be_correct
      end
    end

    context 'when result is correct_tendency_only' do

      it 'should return false' do
        subject.result = Tip::RESULTS[:correct_tendency_only]
        subject.should_not be_correct
      end
    end

    context 'when result is incorrect' do

      it 'should return false' do
        subject.result = Tip::RESULTS[:incorrect]
        subject.should_not be_correct
      end
    end
  end

  describe 'correct_tendency_only?' do

    context 'when result is correct' do

      it 'should return false' do
        subject.result = Tip::RESULTS[:correct]
        subject.should_not be_correct_tendency_only
      end
    end

    context 'when result is correct_tendency_only' do

      it 'should return true' do
        subject.result = Tip::RESULTS[:correct_tendency_only]
        subject.should be_correct_tendency_only
      end
    end

    context 'when result is incorrect' do

      it 'should return false' do
        subject.result = Tip::RESULTS[:incorrect]
        subject.should_not be_correct_tendency_only
      end
    end
  end
end