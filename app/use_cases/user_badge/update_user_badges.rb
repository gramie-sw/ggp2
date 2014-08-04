class UpdateUserBadges

  def run group
    badges =  BadgeRepository.by_group group
    new_user_badges = UserBadgeProvider.new.provide(badges)
    UserBadge.destroy_and_create_multiple(group, new_user_badges)
  end
end