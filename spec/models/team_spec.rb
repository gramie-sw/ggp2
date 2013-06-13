require 'spec_helper'

describe Team do

  it 'should have valid factory' do
    build(:team).should be_valid
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:abbreviation) }
    it { should validate_uniqueness_of(:name) }
    it { should validate_uniqueness_of(:abbreviation) }
  end

  describe 'associations' do
    it { should have_many(:team_1_games).class_name('Game') }
    it { should have_many(:team_2_games).class_name('Game') }
  end

  describe 'scope' do
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
end