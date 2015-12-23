class UpdateUserBadges < UseCase

  attribute :group

  def run
    group_identifiers_grouped_badges = BadgeRepository.group_identifiers_grouped_badges group
    user_ids = UserQueries.all_player_ids
    new_user_badges = UserBadgeProvider.new.provide(user_ids, group_identifiers_grouped_badges)
    UserBadgeQueries.destroy_and_create_multiple(group, new_user_badges)
  end
end