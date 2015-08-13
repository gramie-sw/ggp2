describe TournamentSettings::CreateForm do

  subject { TournamentSettings::CreateForm }

  it 'returns filled TournamentSettingsForm' do
    expected_tournament_title = 'Great Tournament'
    expected_champion_title = 'Great Winner'
    PropertyQueries.save_value(Property::TOURNAMENT_TITLE_KEY, expected_tournament_title)
    PropertyQueries.save_value(Property::CHAMPION_TITLE_KEY, expected_champion_title)

    tournament_settings_form = subject.run
    
    expect(tournament_settings_form).to be_instance_of(TournamentSettingsForm)
    expect(tournament_settings_form.tournament_title).to eq expected_tournament_title
    expect(tournament_settings_form.champion_title).to eq expected_champion_title
  end
end