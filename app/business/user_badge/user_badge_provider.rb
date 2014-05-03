module UserBadgeProvider
  extend self

  def provide badge, group

    badge.eligible_user_ids.map do |user_id|

      UserBadge.new(user_id: user_id,
                    badge_identifier: badge.identifier,
                    position: badge.position,
                    icon: badge.icon,
                    icon_color: badge.icon_color,
                    group: group)
    end
  end
end