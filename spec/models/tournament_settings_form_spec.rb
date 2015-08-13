describe TournamentSettingsForm do

  describe 'validations' do
    it { is_expected.to validate_presence_of(:tournament_title)}
    it { is_expected.to validate_length_of(:tournament_title).is_at_least(5).is_at_most(32) }
    it { is_expected.to validate_presence_of(:champion_title)}
    it { is_expected.to validate_length_of(:champion_title).is_at_least(5).is_at_most(32) }
  end

  describe '#tournament_title' do

    it 'returns cached tournament_title if already set' do
      subject.tournament_title = 'Great Tournament'
      expect(subject.tournament_title).to eq 'Great Tournament'
    end

    it 'returns fetched tournament_title from db and cache it if not already set' do
      expect(PropertyQueries).to respond_to(:find_value)
      expect(PropertyQueries).
          to receive(:find_value).with(Property::TOURNAMENT_TITLE_KEY).and_return('Great Tournament')
      expect(subject.tournament_title).to eq 'Great Tournament'
      expect(subject.tournament_title).to eq 'Great Tournament'
    end
  end

  describe '#champion_title' do

    it 'returns cached tournament_title if already set' do
      subject.tournament_title = 'Great Champion'
      expect(subject.tournament_title).to eq 'Great Champion'
    end

    it 'returns fetched tournament_title from db and cache it if not already set' do
      expect(PropertyQueries).to respond_to(:find_value)
      expect(PropertyQueries).
          to receive(:find_value).with(Property::TOURNAMENT_TITLE_KEY).and_return('Great Champion')
      expect(subject.tournament_title).to eq 'Great Champion'
      expect(subject.tournament_title).to eq 'Great Champion'
    end
  end

  describe '#persisted' do

    it 'returns true' do
      expect(subject.persisted?).to be true
    end
  end
end