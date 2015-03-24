describe Match, :type => :model do

  it 'should have valid factory' do
    expect(build(:match)).to be_valid
  end

  it 'should include module ScoreValidatable' do
    expect(Match.included_modules).to include ScoreValidatable
  end

  describe 'validations' do
    describe '#position' do
      it { is_expected.to validate_presence_of(:position) }
      it { is_expected.to validate_uniqueness_of(:position) }
      it { is_expected.to validate_numericality_of(:position).only_integer }
      it { is_expected.to validate_numericality_of(:position).is_greater_than 0 }
      it { is_expected.to validate_numericality_of(:position).is_less_than_or_equal_to 1000 }
    end

    describe '#aggregate' do
      it { is_expected.to validate_presence_of(:aggregate_id) }
      it { is_expected.to validate_presence_of(:aggregate) }
    end

    describe '#team_1' do
      context 'team_1_id is set' do
        before { allow(subject).to receive(:team_1_id).and_return(1) }
        it { expect(subject).to validate_presence_of(:team_1) }
      end

      context 'team_1_id is not set' do
        before { allow(subject).to receive(:team_1_id).and_return(nil) }
        it { expect(subject).not_to validate_presence_of(:team_1) }
      end
    end

    describe '#team_2' do
      context 'team_2_id is set' do
        before { allow(subject).to receive(:team_2_id).and_return(1) }
        it { expect(subject).to validate_presence_of(:team_2) }
      end

      context 'team_1_id is not set' do
        before { allow(subject).to receive(:team_2_id).and_return(nil) }
        it { expect(subject).not_to validate_presence_of(:team_2) }
      end
    end

    describe '#placeholder_team_1' do
      it { is_expected.to validate_length_of(:placeholder_team_1).is_at_least(3).is_at_most(64) }
      it { is_expected.not_to allow_value('Test%').for(:placeholder_team_1) }

      it 'should allow blank if team_1 is set' do
        expect(build(:match, placeholder_team_1: '')).to be_valid
      end

      it 'should not allow blank if team_1 is not set' do
        expect(build(:match, team_1_id: 0, placeholder_team_1: '')).not_to be_valid
      end
    end

    describe '#placeholder_team_2' do
      it { is_expected.to validate_length_of(:placeholder_team_2).is_at_least(3).is_at_most(64) }
      it { is_expected.not_to allow_value('Test%').for(:placeholder_team_2) }

      it 'should allow blank if team_2 is set' do
        expect(build(:match, placeholder_team_2: '')).to be_valid
      end

      it 'should not allow blank if team_2 is not set' do
        expect(build(:match, team_1_id: 0, placeholder_team_2: '')).not_to be_valid
      end
    end

    describe '#date' do
      it { is_expected.to validate_presence_of(:date) }
    end

    it 'should validate_dummy_team_1_not_equals_dummy_team_2_besides_nil_or_blank' do
      expect(build(:match, placeholder_team_1: 'dummy', placeholder_team_2: 'dummy')).not_to be_valid
      expect(build(:match, placeholder_team_1: nil, placeholder_team_2: nil)).to be_valid
      expect(build(:match, placeholder_team_1: '', placeholder_team_2: '')).to be_valid
    end

    it 'should validate_team_1_not_equal_team_2' do
      team = create(:team)
      expect(build(:match, team_1_id: team.id, team_2_id: team.id)).not_to be_valid
      expect(build(:match, team_1_id: team.id, team_2_id: create(:team).id)).to be_valid
    end
  end

  describe 'associations' do
    it { is_expected.to belong_to(:aggregate) }
    it { is_expected.to belong_to(:team_1).class_name('Team') }
    it { is_expected.to belong_to(:team_2).class_name('Team') }
    it { is_expected.to have_many(:tips).dependent(:destroy) }
    it { is_expected.to have_many(:ranking_items).dependent(:destroy) }
  end

  describe 'message_name' do
    subject { Match.new(position: 77) }

    it 'should return message name' do
      expect(subject.message_name).to eq "#{Match.model_name.human} 77"
    end
  end

  describe '#has_result?' do

    context 'if score_team_1 and score_team_2 present' do

      it 'should return true' do
        subject.score_team_1 = 0
        subject.score_team_2 = 1
        expect(subject.has_result?).to be_truthy
      end
    end

    context 'if only score_team_1 present' do

      it 'should return false' do
        subject.score_team_1 = 0
        subject.score_team_2 = nil
        expect(subject.has_result?).to be_falsey
      end
    end

    context 'if only score_team_2 present' do

      it 'should return false' do
        subject.score_team_2 = 0
        expect(subject.has_result?).to be_falsey
      end
    end

    context 'if score_team_1 and score_team_2 present' do

      it 'should return false' do
        expect(subject.has_result?).to be_falsey
      end
    end
  end

  describe '#started?' do

    context 'if date is in the past' do
      subject { Match.new date: 1.minute.ago }
      it 'should return true' do
        expect(subject).to be_started
      end
    end

    context 'if date is not in the past' do
      subject { Match.new date: 1.minute.from_now }
      it 'should return false' do
        expect(subject).not_to be_started
      end
    end
  end

  describe '#tippable?' do

    context 'if date is in the past' do
      subject { Match.new date: 1.minute.ago }
      it 'should return false' do
        expect(subject).not_to be_tippable
      end
    end

    context 'if date is not in the past' do
      subject { Match.new date: 1.minute.from_now }
      it 'should return true' do
        expect(subject).to be_tippable
      end
    end
  end

  describe '::ordered_match_ids' do

    let(:ordered_by_position_match_relation) { double('ordered_by_position_match_relation') }

    it 'should return all ordered_match ids' do
      expect(Match).to receive(:order_by_position_asc).and_return(ordered_by_position_match_relation)
      expect(ordered_by_position_match_relation).to receive(:pluck).with(:id)
      Match.ordered_match_ids
    end
  end

  describe 'winner_team' do

    let(:team_1) { Team.new }
    let(:team_2) { Team.new }
    subject { Match.new(team_1: team_1, team_2: team_2) }

    context 'when match has no result' do

      it 'should return nil' do
        expect(subject.winner_team).to be_nil
      end
    end

    context 'when match has result' do

      context 'when score values are equal' do

        it 'should return nil' do
          subject.assign_attributes(score_team_1: 1, score_team_2: 1)
          expect(subject.winner_team).to be_nil
        end
      end

      context 'when score values are not equal' do

        it 'should return winner Team' do
          subject.assign_attributes(score_team_1: 2, score_team_2: 1)
          expect(subject.winner_team).to be team_1
          subject.assign_attributes(score_team_1: 2, score_team_2: 3)
          expect(subject.winner_team).to be team_2
        end
      end
    end
  end

  describe '#phase' do

    let(:aggregate) { Aggregate.new }
    subject { Match.new(aggregate: aggregate) }

    context 'if match belongs to aggregate with no parent' do

      it 'should return its own aggregate' do
        expect(subject.phase).to be aggregate
      end
    end

    context 'if match belongs to aggregate with parent aggregate' do

      it 'should return it the parent aggregate' do
        parent_aggregate = Aggregate.new
        allow(aggregate).to receive(:parent).and_return(parent_aggregate)
        expect(subject.phase).to be parent_aggregate
      end
    end
  end
end