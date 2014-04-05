class ChampionTipResultSetter

  def initialize champion_team
    @champion_team = champion_team
  end


  def set_result champion_tip
    if champion_tip.team_id == champion_team.id
      champion_tip.result = ChampionTip::RESULTS[:correct]
    else
      champion_tip.result = ChampionTip::RESULTS[:incorrect]
    end
  end

  private

  attr_reader :champion_team
end