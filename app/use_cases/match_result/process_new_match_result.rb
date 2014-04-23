class ProcessNewMatchResult

  #TODO check whether its better or not to inject the tournament
  def run match_id
    LegacyTipResultService.new(match_id: match_id).update_tips_with_result
    tournament = Tournament.new
    if tournament.champion_team.present?
      CalculateChampionTipResults.new.run(tournament)
    end
    UpdateRanking.new.run(match_id)
  end
end