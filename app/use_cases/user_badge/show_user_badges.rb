class ShowUserBadges

  def run presenter
    presenter.badges= UserBadge.badges_by_user_id(presenter.user.id)
  end
end