require 'spec_helper'

describe Venue do

  it 'should have valid factory' do
    build(:venue).should be_valid
  end

end
