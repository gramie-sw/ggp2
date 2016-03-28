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

    it 'returns correct points' do
      Tip::RESULTS.keys.each do |result_key|
        subject.result = Tip::RESULTS[result_key]
        expect(subject.points).to eq Ggp2.config.send("#{result_key}_tip_points")
      end
    end

    it 'returns 0 if no result set' do
      subject.result = nil
      expect(subject.points).to be 0
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

  describe '#set_result' do

    let(:match) { Match.new(score_team_1: 1, score_team_2: 2) }

    it 'sets result properly to incorrect' do
      subject.assign_attributes(score_team_1: nil, score_team_2: nil)
      subject.set_result(match)
      expect(subject.result).to be Tip::RESULTS[:incorrect]

      subject.assign_attributes(score_team_1: 1, score_team_2: 0)
      subject.set_result(match)
      expect(subject.result).to be Tip::RESULTS[:incorrect]

      subject.assign_attributes(score_team_1: 2, score_team_2: 1)
      subject.set_result(match)
      expect(subject.result).to be Tip::RESULTS[:incorrect]
    end

    it 'sets result properly to correct_tendency_only' do
      subject.assign_attributes(score_team_1: 0, score_team_2: 3)
      subject.set_result(match)
      expect(subject.result).to be Tip::RESULTS[:correct_tendency_only]
    end

    it 'sets result properly to correct_tendency_with_score_difference' do
      subject.assign_attributes(score_team_1: 2, score_team_2: 3)
      subject.set_result(match)
      expect(subject.result).to be Tip::RESULTS[:correct_tendency_with_score_difference]

      subject.assign_attributes(score_team_1: 1, score_team_2: 1)
      subject.set_result(Match.new(score_team_1: 2, score_team_2: 2))
      expect(subject.result).to be Tip::RESULTS[:correct_tendency_with_score_difference]
    end

    it 'sets result properly to correct_tendency_with_one_score' do
      subject.assign_attributes(score_team_1: 0, score_team_2: 2)
      subject.set_result(match)
      expect(subject.result).to be Tip::RESULTS[:correct_tendency_with_one_score]

      subject.assign_attributes(score_team_1: 1, score_team_2: 3)
      subject.set_result(match)
      expect(subject.result).to be Tip::RESULTS[:correct_tendency_with_one_score]
    end

    it 'sets result properly to correct' do
      subject.assign_attributes(score_team_1: 1, score_team_2: 2)
      subject.set_result(match)
      expect(subject.result).to be Tip::RESULTS[:correct]
    end
  end
end