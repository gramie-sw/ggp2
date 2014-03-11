describe Property do

  it 'should have valid factory' do
    build(:property).should be_valid
  end

  describe 'validation' do

    describe 'key' do
      it { should validate_presence_of :key }
      it { should validate_uniqueness_of :key }
      it { should ensure_length_of(:key).is_at_most 64 }
    end

    describe 'value' do
      it { should validate_presence_of :value }
      it { should ensure_length_of(:value).is_at_most 128 }
    end
  end
end
