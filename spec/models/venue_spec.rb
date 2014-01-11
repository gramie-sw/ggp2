describe Venue do

  it 'should have valid factory' do
    build(:venue).should be_valid
  end

  describe 'validations' do
    describe 'city' do
      it { should validate_presence_of :city }
    end

    describe 'stadium' do
      it { should validate_presence_of :stadium }
    end

    describe 'capacity' do
      it { should validate_presence_of :capacity }
    end
  end
end
