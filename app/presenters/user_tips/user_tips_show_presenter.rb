class UserTipsShowPresenter

  include MatchRepresentable

  attr_reader :user
  attr_reader :user_is_current_user
  alias user_is_current_user? user_is_current_user

  def initialize(user:, user_is_current_user:)
    @user = user
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
    if user_is_current_user?
      ''
    else
      I18n.t('general.of_subject', subject: user.nickname)
    end
  end

  def show_as_form? aggregate
    if user_is_current_user?
      aggregate.future_matches.exists?
    else
      false
    end
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
end