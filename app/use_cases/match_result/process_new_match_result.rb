class ProcessNewMatchResult

  #TODO check whether its better or not to inject the tournament
  def run match_id

    Tips::SetResults.run(match_id: match_id)
    tournament = Tournament.new

    if tournament.champion_team.present?
      ChampionTips::SetResults.run(champion_team_id: tournament.champion_team.id)
    end
    RankingSets::Update.run(match_id: match_id)
  end
end