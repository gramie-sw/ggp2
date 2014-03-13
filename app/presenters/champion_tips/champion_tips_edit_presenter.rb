class ChampionTipsEditPresenter

  attr_accessor :champion_tip_id

  def initialize(champion_tip_id:)
    self.champion_tip_id = champion_tip_id
  end

  def teams
    Team.order_by_country_name
  end
end