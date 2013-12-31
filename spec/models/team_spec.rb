require 'spec_helper'

describe Team do

  it 'should have valid factory' do
    build(:team).should be_valid
  end

  describe 'validations' do
    describe '#name' do
      it { should validate_presence_of(:name) }
      it { should validate_uniqueness_of(:name) }
    end

    describe '#abbreviation' do
      it { should validate_presence_of(:abbreviation) }
      it { should validate_uniqueness_of(:abbreviation) }
      it { should ensure_length_of(:abbreviation).is_equal_to(3) }
    end
  end

  describe 'associations' do
    it { should have_many(:team_1_games).class_name('Match') }
    it { should have_many(:team_2_games).class_name('Match') }
  end

  describe 'scopes' do
    describe '#order_by_name' do
      it 'should order by name' do
        create(:team, name: Country.new('US').translations['de'])
        team_1 = create(:team, name: Country.new('DE').translations['de'])
        create(:team, name: Country.new('FR').translations['de'])

        teams = Team.order_by_name
        teams[0].should eq team_1
      end
    end
  end

  describe 'callbacks' do
    describe '#before_destroy' do
      it 'should prevent deletion if team has associated matches' do
        team = create(:team)
        create(:match, team_1_id: team.id)
        team.destroy
        team.should_not be_destroyed
      end

      it 'should allow deletion if team has no associated matches' do
        team = create(:team)
        team.destroy
        team.should be_destroyed
      end
    end
  end
end