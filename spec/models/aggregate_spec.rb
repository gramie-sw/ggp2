require 'spec_helper'

describe Aggregate do

  it 'should have a valid factory' do
    build(:aggregate).should be_valid
    build(:aggregate_with_parent).should be_valid
  end

  describe 'validations' do
    describe '#position' do
      it { should validate_presence_of(:position) }
      it { should validate_uniqueness_of(:position).scoped_to(:ancestry) }
      it { should ensure_inclusion_of(:position).in_range(1..1000) }
      it { should validate_numericality_of(:position).only_integer }
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

    it 'should return all direct matches when aggregate is a group' do
      group = create(:aggregate_with_parent)
      game_1 = create(:match, aggregate: group)
      game_2 = create(:match, aggregate: group)

      create(:match)

      found_games = group.games_of_branch
      found_games.size.should == 2
      found_games.first.id.should == game_1.id
      found_games.last.id.should == game_2.id
    end

    it 'should return all direct matches when aggregate is a phase and has no groups' do
      phase = create(:aggregate)
      game_1 = create(:match, aggregate: phase)
      game_2 = create(:match, aggregate: phase)

      create(:match)

      found_games = phase.games_of_branch
      found_games.size.should == 2
      found_games.first.id.should == game_1.id
      found_games.last.id.should == game_2.id
    end

    it 'should return all matches from belonging groups when aggregate is phase and has groups' do
      phase = create(:aggregate)
      group_1 = create(:aggregate, ancestry: phase.id)
      group_2 = create(:aggregate, ancestry: phase.id)
      game_1 = create(:match, aggregate: group_1)
      game_2 = create(:match, aggregate: group_1)
      game_3 = create(:match, aggregate: group_2)

      group_3 = create(:aggregate_with_parent)
      create(:match, aggregate: group_3)

      found_games = phase.games_of_branch
      found_games.size.should == 3
      found_games.first.id.should == game_1.id
      found_games[1].id.should == game_2.id
      found_games.last.id.should == game_3.id
    end
  end
end
