describe PropertyRepository do

  subject { Property }

  describe '::save_value' do

    context 'when no property if given key exists' do

      it 'should create new Property with given key and value' do
        subject.save_value('key_1', 'value_1')

        actual_property = subject.find_by_key('key_1')
        actual_property.key.should eq 'key_1'
        actual_property.value.should eq 'value_1'
      end
    end

    context 'when no property if given key exists' do

      it 'should update Property of given key with given value' do
        Property.create(key: 'key_1', value: 'value_1')

        subject.save_value('key_1', 'value_2')

        actual_property = subject.find_by_key('key_1')
        actual_property.key.should eq 'key_1'
        actual_property.value.should eq 'value_2'
      end
    end
  end

  describe '::find_value' do

    context 'when Property with given key exists' do

      it 'should return value' do
        Property.create(key: 'key_1', value: 'value_1')
        subject.find_value('key_1').should eq 'value_1'
      end
    end

    context 'when no Property with given key exists' do

      it 'should return null' do
        subject.find_value('key_1').should be_nil
      end
    end
  end

end