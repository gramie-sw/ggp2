describe ScoreValidatable, :type => :model do

  class ModelWithScores
    include ActiveModel::Model
    include ScoreValidatable

    attr_accessor :score_team_1, :score_team_2

    alias :score_team_1? :score_team_1
    alias :score_team_2? :score_team_2
  end

  subject { ModelWithScores.new }

  describe 'for score_team_1' do
    it { is_expected.to allow_value(nil).for(:score_team_1) }
    it { is_expected.to validate_numericality_of(:score_team_1).only_integer }
    it { is_expected.to validate_numericality_of(:score_team_1).is_greater_than_or_equal_to(0) }
    it { is_expected.to validate_numericality_of(:score_team_1).is_less_than_or_equal_to(1000) }

    context 'if score_team_2 present' do
      subject { Tip.new(score_team_2: 1) }
      it { expect(subject).to validate_presence_of :score_team_1 }
    end

    context 'if score_team_2 not present' do
      it { is_expected.not_to validate_presence_of :score_team_1 }
    end
  end

  describe 'for score_team_2' do

    it { is_expected.to allow_value(nil).for(:score_team_2) }
    it { is_expected.to validate_numericality_of(:score_team_2).only_integer }
    it { is_expected.to validate_numericality_of(:score_team_2).is_greater_than_or_equal_to(0) }
    it { is_expected.to validate_numericality_of(:score_team_2).is_less_than_or_equal_to(1000) }

    context 'if score_team_1 present' do
      subject { Tip.new(score_team_1: 1) }
      it { expect(subject).to validate_presence_of :score_team_2 }
    end

    context 'if score_team_1 not present' do
      it { is_expected.not_to validate_presence_of :score_team_2 }
    end
  end
end