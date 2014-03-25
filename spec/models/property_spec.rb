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

  describe '::save_last_result_match' do

    let(:property) { double('property')}
    let(:match_id) { 12 }

    it 'should save given match id on row with key LAST_RESULT_MATCH_ID' do
      Property.should_receive(:save_last_result_match_id).with(match_id).and_call_original
      Property.should_receive(:find_or_create_by).with(key: Property::LAST_RESULT_MATCH_ID).and_return(property)
      property.should_receive(:update_attribute).with(:value, match_id)

      Property.save_last_result_match_id match_id
    end
  end
end
