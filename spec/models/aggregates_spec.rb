require 'spec_helper'

describe Aggregate do

  it 'should have a valid factory' do
    build(:aggregate).should be_valid
    build(:aggregate_with_parent).should be_valid
  end

  describe 'validations' do
    it { should validate_presence_of(:position) }
    it { should validate_uniqueness_of(:position).scoped_to(:ancestry) }
    it { should ensure_inclusion_of(:position).in_range(1..1000) }
    it { should validate_numericality_of(:position).only_integer }
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name).scoped_to(:ancestry) }
    it { should ensure_length_of(:name).is_at_least(3).is_at_most(32) }
    it { should_not allow_value('Name%').for(:name) }
  end

  describe 'associations' do
    it { should have_many(:games).dependent(:destroy) }
  end

  describe 'scope' do
    describe '#order_by_position' do
      it 'should order by position' do
        create(:aggregate, name: "Aggregate 1", position: 2)
        aggregate_2 = create(:aggregate, name: "Aggregate 2", position: 1)
        create(:aggregate, name: "Aggregate 3", position: 3)

        aggregates = Aggregate.order_by_position
        aggregates.first.should eq aggregate_2
      end
    end
  end

  describe '#is_group?' do
    it 'should returns true when aggregate has parent' do
      build(:aggregate_with_parent).is_group?.should be_true
    end

    it 'should returns false when aggregate has no parent' do
      build(:aggregate).is_group?.should be_false
    end
  end

  describe '#games_of_branch' do


  end
end
