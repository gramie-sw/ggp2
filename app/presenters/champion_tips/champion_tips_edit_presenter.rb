class ChampionTipsEditPresenter

  attr_reader :champion_tip

  def initialize champion_tip
    @champion_tip = champion_tip
  end

  def teams
    Team.order_by_team_name_asc
  end
end