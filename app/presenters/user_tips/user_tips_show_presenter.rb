class UserTipsShowPresenter

  include MatchRepresentable

  delegate :champion_tip_deadline, to: :tournament

  attr_writer :tips, :current_aggregate

  attr_reader :user_is_current_user
  alias user_is_current_user? user_is_current_user

  def initialize(user:, tournament:, user_is_current_user:)
    @user = user
    @tournament = tournament
    @user_is_current_user = user_is_current_user
  end

  def title
    if user_is_current_user?
      I18n.t('tip.yours')
    else
      I18n.t('tip.all')
    end
  end

  def subtitle
    user_is_current_user? ? '' : I18n.t('general.of_subject', subject: user.nickname)
  end

  def show_as_form? aggregate
    user_is_current_user? ? aggregate.future_matches.exists? : false
  end

  def tip_presenter_for match
    @tip_presenters = [] unless @tip_presenters
    @tip_presenters[match.id] || begin
      Tip.where(user_id: user.id).includes(:match).each do |tip|
        @tip_presenters[tip.match_id] = TipPresenter.new(tip: tip, is_for_current_user: @user_is_current_user)
      end
      tip_presenter_for(match)
    end
  end

  def show_champion_tip?
    user_is_current_user || !tournament.champion_tippable?
  end

  def champion_tippable?
    user_is_current_user? && tournament.champion_tip_deadline.present? && tournament.champion_tippable?
  end

  def champion_tip_team
    user.champion_tip.try(:team)
  end

  def champion_tip_id
    user.champion_tip.try(:id)
  end

  private

  attr_reader :user
  attr_reader :tournament
end