class UserTipsShowPresenter

  include MatchRepresentable

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
end