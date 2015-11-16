describe Tip do

  it 'should have valid factory' do
    expect(build(:tip)).to be_valid
  end

  it 'should be extended with ModelBatchUpdatable' do
    expect(Tip.singleton_class.included_modules).to include RecordBatchUpdatable
  end

  it 'should be included with ScoreValidatable' do
    expect(Tip.included_modules).to include ScoreValidatable
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
          allow(subject).to receive(:tippable?).and_return(false)
          subject.score_team_1 = 1
          expect(subject).not_to be_valid
          expect(subject.errors[:base]).to include t('errors.messages.scores_not_changeable_after_match_started')
        end

        it 'should validate no change in score_team_2' do
          allow(subject).to receive(:tippable?).and_return(false)
          subject.score_team_2 = 1
          expect(subject).not_to be_valid
          expect(subject.errors[:base]).to include t('errors.messages.scores_not_changeable_after_match_started')
        end
      end
    end

    describe 'for user' do
      it { is_expected.to validate_presence_of :user }
    end

    describe 'for match' do
      it { is_expected.to validate_presence_of :match }
    end

    describe 'for match_id' do
      it { is_expected.to validate_uniqueness_of(:match_id).scoped_to(:user_id) }
    end
  end

  describe 'associations' do

    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:match) }
  end

  describe '#tippable?' do

    let(:match) { Match.new }
    subject { Tip.new(match: match) }

    context 'if match has not started yet' do

      it 'should return false' do
        allow(match).to receive(:started?).and_return(true)
        expect(subject).not_to be_tippable
      end
    end

    context 'if match has started' do

      it 'should return true' do
        allow(match).to receive(:started?).and_return(false)
        expect(subject).to be_tippable
      end
    end
  end

  describe '#tipped?' do

    let(:match) { Match.new }
    subject { Tip.new(match: match) }

    it 'returns true if score_team_1 and score_team_2 present' do
      subject = Tip.new(score_team_1: 1, score_team_2: 1)
      expect(subject.tipped?).to be true

      subject = Tip.new(score_team_1: 0, score_team_2: 0)
      expect(subject.tipped?).to be true
    end

    it 'returns false if at least on score value is missing' do
      subject = Tip.new(score_team_1: nil, score_team_2: 1)
      expect(subject.tipped?).to be false

      subject = Tip.new(score_team_1: 1, score_team_2: nil)
      expect(subject.tipped?).to be false

      subject = Tip.new(score_team_1: nil, score_team_2: nil)
      expect(subject.tipped?).to be false
    end
  end

  describe '#points' do

    it 'should return correct tip points if correct tip' do
      subject.result = Tip::RESULTS[:correct]
      expect(subject.points).to eq Ggp2.config.correct_tip_points
    end

    it 'should return incorrect tip points if incorrect tip' do
      subject.result = Tip::RESULTS[:incorrect]
      expect(subject.points).to eq Ggp2.config.incorrect_tip_points
    end

    it 'should return correct tendency tip only points if correct tendency tip only' do
      subject.result = Tip::RESULTS[:correct_tendency_only]
      expect(subject.points).to eq Ggp2.config.correct_tendency_tip_only_points
    end

    it 'should return nil if result is nil' do
      subject.result = nil
      expect(subject.points).to be_nil
    end
  end

  describe 'correct?' do

    context 'when result is correct' do

      it 'should return true' do
        subject.result = Tip::RESULTS[:correct]
        expect(subject).to be_correct
      end
    end

    context 'when result is correct_tendency_only' do

      it 'should return false' do
        subject.result = Tip::RESULTS[:correct_tendency_only]
        expect(subject).not_to be_correct
      end
    end

    context 'when result is incorrect' do

      it 'should return false' do
        subject.result = Tip::RESULTS[:incorrect]
        expect(subject).not_to be_correct
      end
    end
  end

  describe 'correct_tendency_only?' do

    context 'when result is correct' do

      it 'should return false' do
        subject.result = Tip::RESULTS[:correct]
        expect(subject).not_to be_correct_tendency_only
      end
    end

    context 'when result is correct_tendency_only' do

      it 'should return true' do
        subject.result = Tip::RESULTS[:correct_tendency_only]
        expect(subject).to be_correct_tendency_only
      end
    end

    context 'when result is incorrect' do

      it 'should return false' do
        subject.result = Tip::RESULTS[:incorrect]
        expect(subject).not_to be_correct_tendency_only
      end
    end
  end

  describe '#set_result' do

    let(:match) { Match.new(score_team_1: 1, score_team_2: 2) }

    it 'sets result to incorrect if tip is wrong' do
      subject = Tip.new(score_team_1: 1, score_team_2: 0)
      subject.set_result(match)
      expect(subject.result).to be Tip::RESULTS[:incorrect]

      subject = Tip.new(score_team_1: nil, score_team_2: nil)
      subject.set_result(match)
      expect(subject.result).to be Tip::RESULTS[:incorrect]

      subject = Tip.new(score_team_1: 2, score_team_2: 1)
      subject.set_result(match)
      expect(subject.result).to be Tip::RESULTS[:incorrect]
    end

    it 'sets result to correct_tendency_only if tip has correct tendence' do
      subject = Tip.new(score_team_1: 2, score_team_2: 3)
      subject.set_result(match)
      expect(subject.result).to be Tip::RESULTS[:correct_tendency_only]

      subject = Tip.new(score_team_1: 0, score_team_2: 1)
      subject.set_result(match)
      expect(subject.result).to be Tip::RESULTS[:correct_tendency_only]

      subject = Tip.new(score_team_1: 1, score_team_2: 1)
      subject.set_result(Match.new(score_team_1: 2, score_team_2: 2))
      expect(subject.result).to be Tip::RESULTS[:correct_tendency_only]
    end

    it 'sets result to correct if tip is correct' do
      subject = Tip.new(score_team_1: 1, score_team_2: 2)
      subject.set_result(match)
      expect(subject.result).to be Tip::RESULTS[:correct]
    end
  end
end