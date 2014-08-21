class AwardCeremoniesShowPresenter

  attr_accessor :places

  def initialize tournament
    @tournament = tournament
  end

  def description_one
    I18n.t('award_ceremony.description_one', champion_team: tournament.champion_team.try(:name))
  end

  private

  attr_reader :tournament
end