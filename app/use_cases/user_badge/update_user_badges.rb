class UpdateUserBadges

  def run group
    badges =  Ggp2.config.badges_registry_instance.grouped_badges[group]
    new_user_badges = UserBadgeProvider.new.provide_by_group(badges, group)
    UserBadge.destroy_and_create_multiple(group, new_user_badges)
  end
end