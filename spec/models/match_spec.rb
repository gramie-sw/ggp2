require 'spec_helper'

describe Match do

  it 'should have valid factory' do
    build(:match).should be_valid
  end

  describe 'validations' do
    describe '#position' do
      it { should validate_presence_of(:position) }
      it { should validate_uniqueness_of(:position) }
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

    describe '#placeholder_team_1' do
      it { should ensure_length_of(:placeholder_team_1).is_at_least(3).is_at_most(64) }
      it { should_not allow_value('Test%').for(:placeholder_team_1) }

      it 'should allow blank if team_1 is set' do
        build(:match, placeholder_team_1: '').should be_valid
      end

      it 'should not allow blank if team_1 is not set' do
        build(:match, team_1_id: 0, placeholder_team_1: '').should_not be_valid
      end
    end

    describe '#placeholder_team_2' do
      it { should ensure_length_of(:placeholder_team_2).is_at_least(3).is_at_most(64) }
      it { should_not allow_value('Test%').for(:placeholder_team_2) }

      it 'should allow blank if team_2 is set' do
        build(:match, placeholder_team_2: '').should be_valid
      end

      it 'should not allow blank if team_2 is not set' do
        build(:match, team_1_id: 0, placeholder_team_2: '').should_not be_valid
      end
    end

    describe '#date' do
      it { should validate_presence_of(:date) }
    end

    it 'should validate_dummy_team_1_not_equals_dummy_team_2_besides_nil_or_blank' do
      build(:match, placeholder_team_1: 'dummy', placeholder_team_2: 'dummy').should_not be_valid
      build(:match, placeholder_team_1: nil, placeholder_team_2: nil).should be_valid
      build(:match, placeholder_team_1: '', placeholder_team_2: '').should be_valid
    end

    it 'should validate_team_1_not_equal_team_2' do
      team = create(:team)
      build(:match, team_1_id: team.id, team_2_id: team.id).should_not be_valid
      build(:match, team_1_id: team.id, team_2_id: create(:team).id).should be_valid
    end
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

        create(:match, aggregate: aggregate, game_number: 2)
        game_2 = create(:match, aggregate: aggregate, game_number: 1)
        create(:match, aggregate: aggregate, game_number: 3)

        games = Match.order_by_position
        games.first.should eq game_2
      end
    end
  end

  describe '#team_1?' do
    it 'returns true when game has team_1' do
      team = build(:team)
      game = build(:match, team_1: team)
      game.team_1?.should be_true
    end

    it 'returns false when game has no team_1' do
      build(:match, team_1: nil).team_1?.should be_false
    end
  end

  describe '#team_2?' do
    it 'returns true when game has team_2' do
      team = build(:team)
      game = build(:match, team_2: team)
      game.team_2?.should be_true
    end

    it 'returns false when game has no team_2' do
      build(:match, team_2: nil).team_2?.should be_false
    end
  end
end