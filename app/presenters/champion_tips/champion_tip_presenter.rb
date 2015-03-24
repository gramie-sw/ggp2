class ChampionTipPresenter

  include ActionView::Helpers::TranslationHelper

  delegate :id, to: :champion_tip

  attr_writer :champion_tip

  def initialize(champion_tip:, tournament:, user_is_current_user:)
    @champion_tip = champion_tip
    @tournament = tournament
    @user_is_current_user = user_is_current_user
  end

  def show?
    user_is_current_user? || !tournament.champion_tippable?
  end

  def tippable?
    user_is_current_user? && tournament.champion_tip_deadline.present? && tournament.champion_tippable?
  end

  def team_abbreviation
    champion_tip.team.try(:abbreviation)
  end

  def team_name_or_missing_message
    champion_tip.team.try(:name) || t('tip.not_present')
  end

  def deadline_message
    t('general.changeable_until', date: l(tournament.champion_tip_deadline))
  end

  private

  attr_reader  :champion_tip, :tournament, :user_is_current_user
  alias user_is_current_user? user_is_current_user
end