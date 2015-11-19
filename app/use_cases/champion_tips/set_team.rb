module ChampionTips
  class SetTeam < UseCase

    attribute :id, Integer
    attribute :team_id, Integer

    def run
      champion_tip = ChampionTip.find(id)

      if Tournament.new.started?
        champion_tip.errors.add :base, I18n.t('errors.messages.champion_tip_changeable_after_tournament_started')
      else
        champion_tip.update(team_id: team_id)
      end

      champion_tip
    end
  end
end