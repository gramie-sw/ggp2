describe ScoreValidatable do

  class ModelWithScores
    include ActiveModel::Model
    include ScoreValidatable

    attr_accessor :score_team_1, :score_team_2

    alias :score_team_1? :score_team_1
    alias :score_team_2? :score_team_2
  end

  subject { ModelWithScores.new }

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
end