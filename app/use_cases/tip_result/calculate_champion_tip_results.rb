class CalculateChampionTipResults

  def initialize tournament
    @tournament = tournament
  end

  def run

    champion_tip_result_setter = ChampionTipResultSetter.new tournament.champion_team

    ChampionTip.all.each do |champion_tip|
      champion_tip_result_setter.set_result(champion_tip)
      champion_tip.save
    end
  end

  attr_reader :tournament
end