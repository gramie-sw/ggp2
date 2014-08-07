describe Venue, :type => :model do

  it 'should have valid factory' do
    expect(build(:venue)).to be_valid
  end

  describe 'validations' do
    describe 'city' do
      it { is_expected.to validate_presence_of :city }
    end

    describe 'stadium' do
      it { is_expected.to validate_presence_of :stadium }
    end

    describe 'capacity' do
      it { is_expected.to validate_presence_of :capacity }
    end
  end
end
