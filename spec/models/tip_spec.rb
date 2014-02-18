describe Tip do

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

    describe 'for score_team_1' do

      it { should validate_numericality_of(:score_team_1).only_integer }
      it { should allow_value(nil).for(:score_team_1) }
      it { should_not allow_value(-1).for(:score_team_1) }
      it { should allow_value(0).for(:score_team_1) }
      it { should allow_value(1000).for(:score_team_1) }
      it { should_not allow_value(1001).for(:score_team_1) }

      context 'if score_team_2 present' do
        subject { Tip.new(score_team_2: 1) }
        it { subject.should validate_presence_of :score_team_1 }
      end

      context 'if score_team_2 not present' do
        it { should_not validate_presence_of :score_team_1 }
      end
    end

    describe 'for score_team_2' do

      it { should validate_numericality_of(:score_team_2).only_integer }
      it { should allow_value(nil).for(:score_team_2) }
      it { should_not allow_value(-1).for(:score_team_2) }
      it { should allow_value(0).for(:score_team_2) }
      it { should allow_value(1000).for(:score_team_2) }
      it { should_not allow_value(1001).for(:score_team_2) }

      context 'if score_team_1 present' do
        subject { Tip.new(score_team_1: 1) }
        it { subject.should validate_presence_of :score_team_2 }
      end

      context 'if score_team_1 not present' do
        it { should_not validate_presence_of :score_team_2 }
      end
    end

    describe 'for points' do
      it { should validate_numericality_of(:points).only_integer }
      it { should allow_value(nil).for(:points) }
      it { should_not allow_value(-1).for(:points) }
      it { should allow_value(0).for(:points) }
      it { should allow_value(1000).for(:points) }
      it { should_not allow_value(1001).for(:points) }
    end
  end

  describe 'associations' do

    it { should belong_to(:user) }
    it { should belong_to(:match) }
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
end