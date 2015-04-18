class UserTipsShowPresenter

  include MatchPresentable

  delegate :champion_tip_deadline, to: :tournament

  attr_accessor :current_aggregate, :phases
  attr_writer :tips, :champion_tip

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

  def show_as_form?
    user_is_current_user? ? current_aggregate.has_future_matches? : false
  end

  def tip_presenters
    tips.map { |tip| TipPresenter.new(tip: tip, is_for_current_user: user_is_current_user) }
  end

  def champion_tip_presenter
    ChampionTipPresenter.new(tournament: tournament, champion_tip: champion_tip, user_is_current_user: user_is_current_user?)
  end

  private

  attr_reader :tips, :user, :tournament, :user_is_current_user, :champion_tip
  alias user_is_current_user? user_is_current_user

end