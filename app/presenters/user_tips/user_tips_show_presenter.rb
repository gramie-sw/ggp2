class UserTipsShowPresenter

  attr_reader :user
  attr_reader :user_is_current_user
  alias user_is_current_user? user_is_current_user

  def initialize(user:, user_is_current_user:)
    @user = user
    @user_is_current_user = user_is_current_user
    @match_presenters= []
  end

  def title
    if user_is_current_user?
      I18n.t('general.your_tip.other')
    else
      I18n.t('general.tips_of', name: user.nickname)
    end
  end

  def phases
    @phases ||= Aggregate.phases.order_by_position
  end

  def match_presenters_of(phase)
    @match_presenters[phase.id] ||= begin
      phase.
          matches_including_of_children.
          order_by_position.
          includes(:team_1, :team_2).
          collect { |m| MatchPresenter.new m }
    end
  end
end