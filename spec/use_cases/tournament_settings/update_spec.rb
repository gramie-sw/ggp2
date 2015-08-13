describe TournamentSettings::Update do

  subject { TournamentSettings::Update }

  let(:tournament_settings_attributes) do
    {
        tournament_title: 'Great Tournament',
        champion_title: 'Great Winner'
    }
  end

  context 'if all given attributes are valid' do

    it 'returns TournamentSettingsForm with no errors' do
      tournament_settings_form = subject.run(tournament_settings_attributes: tournament_settings_attributes)
      expect(tournament_settings_form).to be_instance_of TournamentSettingsForm
      expect(tournament_settings_form.errors).to be_empty
    end

    context 'if no attributes in DB exists' do

      it 'creates given tournament_settings_attributes in DB' do
        subject.run(tournament_settings_attributes: tournament_settings_attributes)
        expect(PropertyQueries.find_value(Property::TOURNAMENT_TITLE_KEY)).
            to eq tournament_settings_attributes[:tournament_title]
        expect(PropertyQueries.find_value(Property::CHAMPION_TITLE_KEY)).
            to eq tournament_settings_attributes[:champion_title]
      end
    end

    context 'if attributes in DB exists' do

      it 'updates given tournament_settings_attributes in DB' do
        PropertyQueries.save_value(Property::TOURNAMENT_TITLE_KEY, 'Old Title')
        PropertyQueries.save_value(Property::CHAMPION_TITLE_KEY, 'Old Title')

        subject.run(tournament_settings_attributes: tournament_settings_attributes)
        expect(PropertyQueries.find_value(Property::TOURNAMENT_TITLE_KEY)).
            to eq tournament_settings_attributes[:tournament_title]
        expect(PropertyQueries.find_value(Property::CHAMPION_TITLE_KEY)).
            to eq tournament_settings_attributes[:champion_title]
      end
    end
  end

  context 'if given attributes are invalid' do

    before :each do
      tournament_settings_attributes[:tournament_title] = ''
    end

    it 'returns TournamentSettingsForm with errors' do
      tournament_settings_form = subject.run(tournament_settings_attributes: tournament_settings_attributes)
      expect(tournament_settings_form).to be_instance_of TournamentSettingsForm
      expect(tournament_settings_form.errors).not_to be_empty
    end

    it 'does not save tournament_settings_attributes in DB' do
      subject.run(tournament_settings_attributes: tournament_settings_attributes)
      expect(PropertyQueries.find_value(Property::TOURNAMENT_TITLE_KEY)).to be_nil
      expect(PropertyQueries.find_value(Property::CHAMPION_TITLE_KEY)).to be_nil
    end
  end
end