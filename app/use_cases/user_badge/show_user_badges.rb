class ShowUserBadges

  def run presenter
    presenter.user_badges= UserBadge.all_ordered_by_user_id(user_id: presenter.user.id)
  end
end