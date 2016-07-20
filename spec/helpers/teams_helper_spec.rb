describe TeamsHelper, :type => :helper do

  describe '#tournament_teams_collection_for_select' do

    it 'returns collections array with all teams for select' do
      team_1 = Team.new(id: 34, team_code: 'NL')
      team_2 = Team.new(id: 23, team_code: 'JP')

      expect(Team).to receive(:order_by_team_name_asc).and_return([team_1, team_2])
      expect(helper.tournament_teams_collection_for_select).to eq [[team_1.name, team_1.id], [team_2.name, team_2.id]]
    end
  end

  describe '#team_type_select_options' do

    it 'returns team_type select options' do
      expect(helper.team_type_select_options).
          to eq [[t('team.type.countries'), 'countries'], [t('team.type.clubs'), 'clubs']]
    end
  end
end