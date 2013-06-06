require 'spec_helper'

describe Aggregate do

  it 'should have a valid factory' do
    create(:aggregate_with_parent).should be_valid
  end

  describe 'validations' do
    it { should validate_presence_of(:position) }
    it { should validate_uniqueness_of(:position).scoped_to(:ancestry) }
    it { should ensure_inclusion_of(:position).in_range(1..1000) }
    it { should validate_numericality_of(:position).only_integer }
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name).scoped_to(:ancestry) }
    it { should ensure_length_of(:name).is_at_least(3).is_at_most(32) }
  end

  describe 'associations' do
    it { should have_many(:games).dependent(:destroy) }
  end

  it 'should order by position as default' do
    aggregates = []
    aggregates << create(:aggregate, name: "Aggregate 1", position: 2)
    aggregates << create(:aggregate, name: "Aggregate 2", position: 3)
    aggregates << create(:aggregate, name: "Aggregate 3", position: 1)

    sorted_aggregates = Aggregate.all
    sorted_aggregates.first.id.should eq aggregates[2].id
    sorted_aggregates.last.id.should eq aggregates[1].id
  end
end
