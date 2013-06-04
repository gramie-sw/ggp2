require 'spec_helper'

describe Game do

  it 'should have valid factory' do
    create(:game).should be_valid
  end

  describe 'associations' do
    it { should belong_to(:team_1).class_name('Team')}
    it { should belong_to(:team_2).class_name('Team')}
  end
end
