require 'spec_helper'

describe Team do

  it 'should have valid factory' do
    create(:team).should be_valid
  end

  #describe 'validation' do
  #  it { should validate_presence_of(:project) }
  #  it { should validate_uniqueness_of(:role_id).scoped_to(:project_id) }
  #  it { should validate_presence_of(:role) }
  #end
  #
  #describe 'associations' do
  #  it { should belong_to(:role) }
  #  it { should belong_to(:project) }
  #end
end

