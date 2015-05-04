describe Aggregate, :type => :model do

  it 'should have a valid factory' do
    expect(build(:aggregate)).to be_valid
    expect(build(:aggregate_with_parent)).to be_valid
  end

  describe 'validations' do
    describe '#position' do
      it { is_expected.to validate_presence_of(:position) }
      it { is_expected.to validate_numericality_of(:position).only_integer }
      it { is_expected.to validate_numericality_of(:position).is_greater_than 0 }
      it { is_expected.to validate_numericality_of(:position).is_less_than_or_equal_to 1000 }
      it { is_expected.to validate_uniqueness_of(:position).scoped_to(:ancestry) }
    end
    describe '#name' do
      it { is_expected.to validate_presence_of(:name) }
      it { is_expected.to validate_uniqueness_of(:name).scoped_to(:ancestry) }
      it { is_expected.to validate_length_of(:name).is_at_least(3).is_at_most(32) }
      it { is_expected.not_to allow_value('Name%').for(:name) }
    end
  end

  describe 'associations' do
    it { is_expected.to have_many(:matches).dependent(:destroy) }
  end

  describe 'scopes' do
    describe '#order_by_position_asc' do
      it 'should order by position' do
        aggregate_3 = create(:aggregate, name: "Aggregate 1", position: 3)
        aggregate_1 = create(:aggregate, name: "Aggregate 2", position: 1)
        aggregate_2 = create(:aggregate, name: "Aggregate 3", position: 2)

        aggregates = Aggregate.order_by_position_asc
        expect(aggregates[0].position).to eq aggregate_1.position
        expect(aggregates[1].position).to eq aggregate_2.position
        expect(aggregates[2].position).to eq aggregate_3.position
      end
    end
  end

  describe '#group?' do
    it 'should returns true when aggregate has parent' do
      expect(build(:aggregate_with_parent).group?).to be_truthy
    end

    it 'should returns false when aggregate has no parent' do
      expect(build(:aggregate).group?).to be_falsey
    end
  end

  describe '#matches_including_of_children' do

    it 'should return all direct matches when aggregate is a group' do
      group = create(:aggregate_with_parent)
      match_1 = create(:match, aggregate: group)
      match_2 = create(:match, aggregate: group)

      create(:match)

      found_matches = group.matches_including_of_children
      expect(found_matches.size).to eq(2)
      expect(found_matches.first.id).to eq(match_1.id)
      expect(found_matches.last.id).to eq(match_2.id)
    end

    it 'should return all direct matches when aggregate is a phase and has no groups' do
      phase = create(:aggregate)
      match_1 = create(:match, aggregate: phase)
      match_2 = create(:match, aggregate: phase)

      create(:match)

      found_matches = phase.matches_including_of_children
      expect(found_matches.size).to eq(2)
      expect(found_matches.first.id).to eq(match_1.id)
      expect(found_matches.last.id).to eq(match_2.id)
    end

    it 'should return all matches from belonging groups when aggregate is phase and has groups' do
      phase = create(:aggregate)
      group_1 = create(:aggregate, ancestry: phase.id)
      group_2 = create(:aggregate, ancestry: phase.id)
      match_1 = create(:match, aggregate: group_1)
      match_2 = create(:match, aggregate: group_1)
      match_3 = create(:match, aggregate: group_2)

      group_3 = create(:aggregate_with_parent)
      create(:match, aggregate: group_3)

      found_matches = phase.matches_including_of_children
      expect(found_matches.size).to eq(3)
      expect(found_matches[0].id).to eq(match_1.id)
      expect(found_matches[1].id).to eq(match_2.id)
      expect(found_matches[2].id).to eq(match_3.id)
    end
  end

  describe '#future_matches' do

    subject { create(:aggregate) }

    it 'should return future_matches' do
      match_1 = create(:match, date: 1.minutes.from_now, aggregate: subject)
      match_2 = create(:match, date: 2.minutes.from_now, aggregate: subject)
      create(:match, date: 2.minutes.from_now)
      create(:match, date: 2.minutes.ago, aggregate: subject)

      actual_match = subject.future_matches
      expect(actual_match.count).to eq 2
      expect(actual_match).to include match_1, match_2
    end
  end

  describe '#has_future_matches?' do

    context 'when future_matches exists' do

      it 'should return true' do
        expect(subject).to receive(:future_matches).and_return([Match.new])
        expect(subject.has_future_matches?).to be_truthy
      end
    end

    context 'when future_matches does not exists' do

      it 'should return false' do
        expect(subject).to receive(:future_matches).and_return([])
        expect(subject.has_future_matches?).to be_falsey
      end
    end
  end

  describe '::leaves' do

    it 'should return all groups and all roots if they have no groups' do
      phase_1 = create(:aggregate)
      group_1 = create(:aggregate, ancestry: phase_1.id)
      group_2 = create(:aggregate, ancestry: phase_1.id)
      phase_2 = create(:aggregate)

      leaves = Aggregate.groupless_aggregates
      expect(leaves.include?(group_1)).to be_truthy
      expect(leaves.include?(group_2)).to be_truthy
      expect(leaves.include?(phase_2)).to be_truthy
    end
  end

  describe '#message_name' do

    let(:name) {'Aggregate 1'}

    before :each do
      subject.name = name
    end

    it 'returns message name for group if aggregate is a group' do
      expect(subject).to receive(:phase?).and_return(false)
      expect(subject.message_name).to eq "#{t('general.group.one')} \"#{name}\""
    end

    it 'returns message name for group if aggregate is a group' do
      expect(subject).to receive(:phase?).and_return(true)
      expect(subject.message_name).to eq "#{t('general.phase.one')} \"#{name}\""
    end
  end
end
