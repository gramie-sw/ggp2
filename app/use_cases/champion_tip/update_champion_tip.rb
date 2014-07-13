class UpdateChampionTip

  Result = Struct.new(:successful, :champion_tip)

  def run(current_user:, champion_tip_id:, attributes:)

    champion_tip = ChampionTip.find(champion_tip_id)

    result = Result.new
    result.champion_tip = champion_tip
    result.successful= true

    if current_user.player? && Tournament.new.started?

      champion_tip.errors.add :base, I18n.t('errors.messages.champion_tip_changeable_after_tournament_started')
      result.successful = false
    else
      result.successful = champion_tip.update(attributes)
    end

    result
  end
end