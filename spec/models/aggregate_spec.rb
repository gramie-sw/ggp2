describe Aggregate do

  it 'should have a valid factory' do
    build(:aggregate).should be_valid
    build(:aggregate_with_parent).should be_valid
  end

  describe 'validations' do
    describe '#position' do
      it { should validate_presence_of(:position) }
      it { should validate_numericality_of(:position).only_integer }
      it { should validate_numericality_of(:position).is_greater_than 0 }
      it { should validate_numericality_of(:position).is_less_than_or_equal_to 1000 }
      it { should validate_uniqueness_of(:position).scoped_to(:ancestry) }
    end
    describe '#name' do
      it { should validate_presence_of(:name) }
      it { should validate_uniqueness_of(:name).scoped_to(:ancestry) }
      it { should ensure_length_of(:name).is_at_least(3).is_at_most(32) }
      it { should_not allow_value('Name%').for(:name) }
    end
  end

  describe 'associations' do
    it { should have_many(:matches).dependent(:destroy) }
  end

  describe 'scopes' do
    describe '#order_by_position' do
      it 'should order by position' do
        aggregate_3 = create(:aggregate, name: "Aggregate 1", position: 3)
        aggregate_1 = create(:aggregate, name: "Aggregate 2", position: 1)
        aggregate_2 = create(:aggregate, name: "Aggregate 3", position: 2)

        aggregates = Aggregate.order_by_position
        aggregates[0].position.should eq aggregate_1.position
        aggregates[1].position.should eq aggregate_2.position
        aggregates[2].position.should eq aggregate_3.position
      end
    end
  end

  describe '#group?' do
    it 'should returns true when aggregate has parent' do
      build(:aggregate_with_parent).group?.should be_true
    end

    it 'should returns false when aggregate has no parent' do
      build(:aggregate).group?.should be_false
    end
  end

  describe '#matches_including_of_children' do

    it 'should return all direct matches when aggregate is a group' do
      group = create(:aggregate_with_parent)
      match_1 = create(:match, aggregate: group)
      match_2 = create(:match, aggregate: group)

      create(:match)

      found_matches = group.matches_including_of_children
      found_matches.size.should == 2
      found_matches.first.id.should == match_1.id
      found_matches.last.id.should == match_2.id
    end

    it 'should return all direct matches when aggregate is a phase and has no groups' do
      phase = create(:aggregate)
      match_1 = create(:match, aggregate: phase)
      match_2 = create(:match, aggregate: phase)

      create(:match)

      found_matches = phase.matches_including_of_children
      found_matches.size.should == 2
      found_matches.first.id.should == match_1.id
      found_matches.last.id.should == match_2.id
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
      found_matches.size.should == 3
      found_matches[0].id.should == match_1.id
      found_matches[1].id.should == match_2.id
      found_matches[2].id.should == match_3.id
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
      actual_match.count.should eq 2
      actual_match.should include match_1, match_2
    end
  end

  describe '#has_future_matches?' do

    context 'when future_matches exists' do

      it 'should return true' do
        expect(subject).to receive(:future_matches).and_return([Match.new])
        expect(subject.has_future_matches?).to be_true
      end
    end

    context 'when future_matches does not exists' do

      it 'should return false' do
        expect(subject).to receive(:future_matches).and_return([])
        expect(subject.has_future_matches?).to be_false
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
      leaves.include?(group_1).should be_true
      leaves.include?(group_2).should be_true
      leaves.include?(phase_2).should be_true
    end
  end
end
