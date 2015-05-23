class UserTipsPresenter < MatchSchedulePresenter

  attr_reader :user_is_current_user
  alias user_is_current_user? user_is_current_user

  def initialize(user:, current_aggregate:, tournament:, user_is_current_user:)
    @user = user
    @current_aggregate = current_aggregate
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

  def show_as_form?
    user_is_current_user? ? current_aggregate.has_future_matches? : false
  end

  def tip_presenters
    tips.map { |tip| TipPresenter.new(tip: tip, is_for_current_user: user_is_current_user) }
  end

  def champion_tip_presenter
    ChampionTipPresenter.new(tournament: tournament,
                             champion_tip: champion_tip,
                             user_is_current_user: user_is_current_user?)
  end

  private

  attr_reader :tips, :user, :tournament

  def tips
    Tip.all_eager_by_user_id_and_aggregate_id_ordered_by_position(user.id, current_aggregate.id)
  end

  def champion_tip
    ChampionTip.find_by_user_id(user.id)
  end


end