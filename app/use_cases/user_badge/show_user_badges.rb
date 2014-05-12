class ShowUserBadges

  def run presenter
    presenter.grouped_user_badges= GroupedUserBadgesProvider.new.provide(
        user_id: presenter.user.id, user_badge_repo: UserBadge)
  end
end