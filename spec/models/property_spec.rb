describe Property do

  it 'should have valid factory' do
    expect(build(:property)).to be_valid
  end

  describe 'validation' do

    describe 'key' do
      it { is_expected.to validate_presence_of :key }
      it { is_expected.to validate_uniqueness_of :key }
      it { is_expected.to validate_length_of(:key).is_at_most 64 }
    end

    describe 'value' do
      it { is_expected.to validate_presence_of :value }
      it { is_expected.to validate_length_of(:value).is_at_most 128 }
    end
  end

  describe '::set_last_tip_ranking_set_match_id_to' do

    it 'should save given match_id with key LAST_TIP_RANKING_SET_MATCH_ID_KEY' do
      expect(PropertyQueries).to receive(:save_value).with(Property::LAST_TIP_RANKING_SET_MATCH_ID_KEY, 5)
      Property.set_last_tip_ranking_set_match_id_to 5
    end
  end

  describe '::last_tip_ranking_set_match_id' do

    context 'when property with CHAMPION_TIP_RANKING_SET_EXISTS_KEY exists' do

      it 'should return value of CHAMPION_TIP_RANKING_SET_EXISTS_KEY casted to integer' do
        expect(PropertyQueries).to receive(:find_value).with(Property::LAST_TIP_RANKING_SET_MATCH_ID_KEY).and_return('5')
        expect(Property.last_tip_ranking_set_match_id).to eq 5
      end
    end

    context 'when property with CHAMPION_TIP_RANKING_SET_EXISTS_KEY not exists' do

      it 'should return nil' do
        expect(PropertyQueries).
            to receive(:find_value).with(Property::LAST_TIP_RANKING_SET_MATCH_ID_KEY).and_return(nil)
        expect(Property.last_tip_ranking_set_match_id).to be_nil
      end
    end

    context 'when property with CHAMPION_TIP_RANKING_SET_EXISTS_KEY is not a number' do

      it 'should return nil' do
        expect(PropertyQueries).
            to receive(:find_value).with(Property::LAST_TIP_RANKING_SET_MATCH_ID_KEY).and_return('nil')
        expect(Property.last_tip_ranking_set_match_id).to be_nil
      end
    end
  end

  describe '::set_champion_tip_ranking_set_exists_to' do

    it 'should save given boolean with key CHAMPION_TIP_RANKING_SET_EXISTS_KEY' do
      expect(PropertyQueries).to receive(:save_value).with(Property::CHAMPION_TIP_RANKING_SET_EXISTS_KEY, true)
      Property.set_champion_tip_ranking_set_exists_to true
    end
  end

  describe '::champion_tip_ranking-set_exits?' do

    context 'when property with CHAMPION_TIP_RANKING_SET_EXISTS_KEY not exists' do

      it 'should should return false' do
        expect(PropertyQueries).
            to receive(:find_value).with(Property::CHAMPION_TIP_RANKING_SET_EXISTS_KEY).and_return(nil)
        Property.champion_tip_ranking_set_exists?
      end
    end

    context 'when property with CHAMPION_TIP_RANKING_SET_EXISTS_KEY is 0' do

      it 'should should return false casted to boolean' do
        expect(PropertyQueries).
            to receive(:find_value).with(Property::CHAMPION_TIP_RANKING_SET_EXISTS_KEY).and_return('0')
        expect(Property.champion_tip_ranking_set_exists?).to be_falsey
      end
    end

    context 'when property with CHAMPION_TIP_RANKING_SET_EXISTS_KEY is true' do

      it 'should should return true casted to boolean' do
        expect(PropertyQueries).
            to receive(:find_value).with(Property::CHAMPION_TIP_RANKING_SET_EXISTS_KEY).and_return('1')
        expect(Property.champion_tip_ranking_set_exists?).to be_truthy
      end
    end
  end

  describe '::team_type' do

    it 'returns team_type' do
      expect(PropertyQueries).to receive(:find_value).with(Property::TEAM_TYPE_KEY).and_return('countries')
      expect(Property.team_type).to eq 'countries'
    end
  end
end