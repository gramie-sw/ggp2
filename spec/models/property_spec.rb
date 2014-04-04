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

  describe '::set_last_tip_ranking_set_match_id_to' do

    it 'should save given match_id with key LAST_TIP_RANKING_SET_MATCH_ID_KEY' do
      Property.should_receive(:save_value).with(Property::LAST_TIP_RANKING_SET_MATCH_ID_KEY, 5)
      Property.set_last_tip_ranking_set_match_id_to 5
    end
  end

  describe '::last_tip_ranking_set_match_id' do

    context 'when property with CHAMPION_TIP_RANKING_SET_EXISTS_KEY exists' do

      it 'should return value of CHAMPION_TIP_RANKING_SET_EXISTS_KEY casted to integer' do
        Property.should_receive(:find_value).with(Property::LAST_TIP_RANKING_SET_MATCH_ID_KEY).and_return('5')
        Property.last_tip_ranking_set_match_id.should eq 5
      end
    end

    context 'when property with CHAMPION_TIP_RANKING_SET_EXISTS_KEY not exists' do

      it 'should return nil' do
        Property.should_receive(:find_value).with(Property::LAST_TIP_RANKING_SET_MATCH_ID_KEY).and_return(nil)
        Property.last_tip_ranking_set_match_id.should be_nil
      end
    end
  end

  describe '::set_champion_tip_ranking_set_exists_to' do

    it 'should save given boolean with key CHAMPION_TIP_RANKING_SET_EXISTS_KEY' do
      Property.should_receive(:save_value).with(Property::CHAMPION_TIP_RANKING_SET_EXISTS_KEY, true)
      Property.set_champion_tip_ranking_set_exists_to true
    end
  end

  describe '::champion_tip_ranking-set_exits?' do

    context 'when property with CHAMPION_TIP_RANKING_SET_EXISTS_KEY not exists' do

      it 'should should return false' do
        Property.should_receive(:find_value).with(Property::CHAMPION_TIP_RANKING_SET_EXISTS_KEY).and_return(nil)
        Property.champion_tip_ranking_set_exists?
      end
    end

    context 'when property with CHAMPION_TIP_RANKING_SET_EXISTS_KEY is 0' do

      it 'should should return false casted to boolean' do
        Property.should_receive(:find_value).with(Property::CHAMPION_TIP_RANKING_SET_EXISTS_KEY).and_return('0')
        Property.champion_tip_ranking_set_exists?.should be_false
      end
    end

    context 'when property with CHAMPION_TIP_RANKING_SET_EXISTS_KEY is true' do

      it 'should should return true casted to boolean' do
        Property.should_receive(:find_value).with(Property::CHAMPION_TIP_RANKING_SET_EXISTS_KEY).and_return('1')
        Property.champion_tip_ranking_set_exists?.should be_true
      end
    end
  end

end