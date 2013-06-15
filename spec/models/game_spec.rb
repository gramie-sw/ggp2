require 'spec_helper'

describe Game do

  it 'should have valid factory' do
    build(:game).should be_valid
  end

  describe 'validations' do

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
end
