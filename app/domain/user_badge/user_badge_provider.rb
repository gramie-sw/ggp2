class UserBadgeProvider

  def provide badges

    badges.map do |badge|
      badges_with_eligible_user badge
    end.flatten!
  end

  private

  def badges_with_eligible_user badge

    badge.eligible_user_ids.map! do |user_id|
      UserBadge.new(user_id: user_id, badge_identifier: badge.identifier)
    end
  end
end