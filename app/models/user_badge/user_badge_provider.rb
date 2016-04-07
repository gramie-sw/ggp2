class UserBadgeProvider

  def provide user_ids, group_identifiers_grouped_badges

    user_badges = []

    #all badges grouped by group  identifiers
    group_identifiers_grouped_badges.each do |group_identifier_grouped_badges|

      eligible_user_ids = []

      #a group of badges having the same group identifier
      group_identifier_grouped_badges.each_with_index do |badge, badge_in_group_position|

        #special case if group has only one badge
        if group_identifier_grouped_badges.size == 1
          user_badges += create_user_badges(badge.eligible_user_ids(user_ids), badge.group_identifier, badge.identifier)

          #normal group has more than one badge
        else
          #considered user ids returns all  on lowest badge of group otherwise all eligible user ids of the lower
          #kind of this group
          considered_user_ids = badge_in_group_position == 0 ? user_ids : eligible_user_ids.last
          #sets all eligible user ids for this focused badge of this group
          eligible_user_ids << badge.eligible_user_ids(considered_user_ids)

          user_badges.concat(user_badges_for_badge(badge, eligible_user_ids, badge_in_group_position, group_identifier_grouped_badges))

          #we don't have to check badges, if even the lower badge of this group no one reached
          break if eligible_user_ids.last.blank?
        end
      end
    end

    user_badges
  end

  private

  def create_user_badges user_ids, badge_group_identifier, badge_identifier
    user_ids.map do |user_id|
      UserBadge.new(user_id: user_id, badge_group_identifier: badge_group_identifier, badge_identifier: badge_identifier)
    end
  end

  def user_badges_for_badge badge, eligible_user_ids, badge_in_group_position, group_identifier_grouped_badges
    user_badges = []

    #creates user badges of all eligible user ids
    if badge_in_group_position > 0
      #updated all user ids of the previous badge by subtracting all current user_ids (last in array) from
      #all eligible user_ids for this badge
      user_badges += create_user_badges(eligible_user_ids[-2] - eligible_user_ids.last,
                                        group_identifier_grouped_badges[badge_in_group_position - 1].group_identifier,
                                        group_identifier_grouped_badges[badge_in_group_position - 1].identifier)

      #if you have the highest badge of this group already
      if badge_in_group_position == group_identifier_grouped_badges.size - 1
        user_badges += create_user_badges(eligible_user_ids.last, badge.group_identifier, badge.identifier)
      end
    end

    user_badges
  end
end