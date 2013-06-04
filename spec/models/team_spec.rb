require 'spec_helper'

describe Team do

  it 'should have valid factory' do
    create(:team).should be_valid
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
end

