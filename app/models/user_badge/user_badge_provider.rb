class UserBadgeProvider

  def provide user_ids, group_identifiers_grouped_badges

    user_badges = []

    group_identifiers_grouped_badges.each do |group_identifier_grouped_badges|

      eligible_user_ids = []

      group_identifier_grouped_badges.each_with_index do |badge, index|

        if group_identifier_grouped_badges.size == 1
          user_badges += create_user_badges(badge.eligible_user_ids(user_ids), badge.group_identifier, badge.identifier)
        else
          considered_user_ids = index == 0 ? user_ids : eligible_user_ids.last
          eligible_user_ids << badge.eligible_user_ids(considered_user_ids)

          if index > 0
            user_badges += create_user_badges(eligible_user_ids[-2] - eligible_user_ids.last,
                                              group_identifier_grouped_badges[index - 1].group_identifier,
                                              group_identifier_grouped_badges[index - 1].identifier)

            if index == group_identifier_grouped_badges.size - 1
              user_badges += create_user_badges(eligible_user_ids.last, badge.group_identifier, badge.identifier)
            end

            #we don't have to check badges, which are more difficult to get, because there are no users left
            break if eligible_user_ids.last.blank?
          end
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
end