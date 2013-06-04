require 'spec_helper'

describe Aggregate do

  it 'should have a valid factory' do
    create(:aggregate_with_parent).should be_valid
  end
end
