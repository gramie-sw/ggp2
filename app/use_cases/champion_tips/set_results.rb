module ChampionTips
  class SetResults < UseCase

    attribute :champion_team_id, Integer

    def run

      champion_tips = ChampionTip.all

      champion_tips.each do |champion_tip|
        champion_tip.set_result(champion_team_id)

        # We save the result unvalidated because if no team has been set
        # a validation error occurs
        champion_tip.save(validate: false)
      end
    end
  end
end