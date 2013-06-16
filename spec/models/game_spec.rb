require 'spec_helper'

describe Game do

  it 'should have valid factory' do
    build(:game).should be_valid
  end

  describe 'validations' do
    describe '#game_number' do
      it { should validate_presence_of(:game_number) }
      it { should validate_uniqueness_of(:game_number) }
      it { should validate_numericality_of(:game_number).only_integer }
      it { should ensure_inclusion_of(:game_number).in_range(1..1000) }
    end

    describe '#aggregate' do
      it { should validate_presence_of(:aggregate_id) }
      it { should validate_presence_of(:aggregate) }
    end

    describe '#team_1' do
      context 'team_1_id is set' do
        before { subject.stub(:team_1_id, 1).and_return(1) }
        it { subject.should validate_presence_of(:team_1) }
      end

      context 'team_1_id is not set' do
        before { subject.stub(:team_1_id, nil).and_return(nil) }
        it { subject.should_not validate_presence_of(:team_1) }
      end
    end

    describe '#team_2' do
      context 'team_2_id is set' do
        before { subject.stub(:team_2_id, 1).and_return(1) }
        it { subject.should validate_presence_of(:team_2) }
      end

      context 'team_1_id is not set' do
        before { subject.stub(:team_2_id, nil).and_return(nil) }
        it { subject.should_not validate_presence_of(:team_2) }
      end
    end

    describe '#score_team_1' do
      it { should validate_numericality_of(:score_team_1).only_integer }
      it { should ensure_inclusion_of(:score_team_1).in_range(0..1000).allow_nil }
    end

    describe '#score_team_2' do
      it { should validate_numericality_of(:score_team_2).only_integer }
      it { should ensure_inclusion_of(:score_team_2).in_range(0..1000).allow_nil }
    end

    #describe '#placeholder_team_1' do
    #  #it { should }
    #end

  end

  describe 'associations' do
    it { should belong_to(:aggregate) }
    it { should belong_to(:team_1).class_name('Team') }
    it { should belong_to(:team_2).class_name('Team') }
  end

  describe 'scopes' do
    describe '#order_by_game_number' do
      it 'should order by game number' do
        aggregate = create(:aggregate)

        create(:game, aggregate: aggregate, game_number: 2)
        game_2 = create(:game, aggregate: aggregate, game_number: 1)
        create(:game, aggregate: aggregate, game_number: 3)

        games = Game.order_by_game_number
        games.first.should eq game_2
      end
    end
  end

  #describe '#has_team_1' do
  #  it 'should return true if has_team_1' do
  #      build(:game, team_1: build(:team)).has_team_1? should be_true
  #  end
  #end
end
