class UpdateChampionTip

  Result = Struct.new(:successful, :champion_tip)

  def initialize(current_user:, champion_tip_id:, attributes:)
    @current_user = current_user
    @champion_tip_id = champion_tip_id
    @attributes = attributes
  end

  def run

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

  private

  attr_reader :current_user, :champion_tip_id, :attributes

end