class CalculateChampionTipResults

  def initialize champion_team
    @champion_team = champion_team
  end

  def run

    champion_tip_result_setter = ChampionTipResultSetter.new champion_team

    champion_tips = ChampionTip.all

    champion_tips.each do |champion_tip|
      champion_tip_result_setter.set_result(champion_tip)
    end

    ChampionTip.save_multiple champion_tips
  end

  attr_reader :champion_team
end