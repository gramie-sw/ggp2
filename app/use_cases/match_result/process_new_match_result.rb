class ProcessNewMatchResult

  #TODO check whether its better or not to inject the tournament
  def run match_id

    CalculateTipResults.new.run(match_id)
    tournament = Tournament.new

    if tournament.champion_team.present?
      CalculateChampionTipResults.new(tournament.champion_team).run
    end
    Rankings::Update.run(match_id: match_id)
  end
end