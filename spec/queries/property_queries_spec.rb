describe PropertyQueries do

  subject { PropertyQueries }

  describe '::save_value' do

    context 'when no property if given key exists' do

      it 'should create new Property with given key and value' do
        subject.save_value('key_1', 'value_1')

        actual_property = Property.find_by_key('key_1')
        expect(actual_property.key).to eq 'key_1'
        expect(actual_property.value).to eq 'value_1'
      end
    end

    context 'when no property if given key exists' do

      it 'should update Property of given key with given value' do
        Property.create(key: 'key_1', value: 'value_1')

        subject.save_value('key_1', 'value_2')

        actual_property = Property.find_by_key('key_1')
        expect(actual_property.key).to eq 'key_1'
        expect(actual_property.value).to eq 'value_2'
      end
    end
  end

  describe '::find_value' do

    context 'when Property with given key exists' do

      it 'should return value' do
        Property.create(key: 'key_1', value: 'value_1')
        expect(subject.find_value('key_1')).to eq 'value_1'
      end
    end

    context 'when no Property with given key exists' do

      it 'should return null' do
        expect(subject.find_value('key_1')).to be_nil
      end
    end
  end

end