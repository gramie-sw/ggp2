class CalculateChampionTipResults

  def initialize champion_team
    @champion_team = champion_team
  end

  def run

    champion_tips = ChampionTip.all

    champion_tips.each do |champion_tip|
      champion_tip.set_result(champion_team)

      # We save the result unvalidated because if no team has been set
      # a validation error occurs
      champion_tip.save(validate: false)
    end
  end

  attr_reader :champion_team
end