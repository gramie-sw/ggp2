describe TeamsHelper, :type => :helper do

  describe '#team_collection_for_select' do

    it 'returns collections array with all teams for select' do
      team_1 = Team.new(id: 34, country: 'NL')
      team_2 = Team.new(id: 23, country: 'JP')

      expect(Team).to receive(:order_by_country_name_asc).and_return([team_1, team_2])
      expect(helper.team_collection_for_select).to eq [[team_1.name, team_1.id], [team_2.name, team_2.id]]
    end
  end
end