class GroupedUserBadgesProvider

  def provide(user_id:, user_badge_repo:)

    groups = user_badge_repo.groups_by_user_id(user_id: user_id)
    groups.map! { |group| group.to_sym }

    grouped_user_badges = Hash.new

    groups.each do |group|
      grouped_user_badges[group] = user_badge_repo.all_ordered_by_group_and_user_id(group: group, user_id: user_id)
    end

    grouped_user_badges
  end
end