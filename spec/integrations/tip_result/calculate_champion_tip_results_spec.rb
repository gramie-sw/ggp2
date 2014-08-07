describe CalculateChampionTipResults do

  it 'should calculate the result for all champion Tips' do
    user_1 = create(:player)
    user_2 = create(:player)

    team_1 = create(:team)
    team_2 = create(:team)

    champion_tip_1 = create(:champion_tip, user: user_1, team: team_1)
    champion_tip_2 = create(:champion_tip, user: user_2, team: team_2)

    create(:match, position: 1)
    create(:match, position: 2, team_1: team_1, team_2: team_2, score_team_1: 1, score_team_2: 3)

    subject.run(Tournament.new)

    champion_tip_1.reload
    expect(champion_tip_1).not_to be_correct
    champion_tip_2.reload
    expect(champion_tip_2).to be_correct
  end
end