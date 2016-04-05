module BadgeRepository

  extend self

  def badge_by_identifier badge_identifier
    badges_hash[badge_identifier]
  end

  def badges
    badges_hash.values
  end

  def badges_by_user_id user_id, sort = :asc
    all_badges_hash = BadgeRepository.badges_hash
    user_badges = UserBadgeQueries.all_by_user_id user_id

    badges = user_badges.map do |user_badge|
      all_badges_hash[user_badge.badge_identifier]
    end

    badges.sort_by! { |badge| badge.score }
    badges.reverse! if sort == :desc
    badges
  end

  def badges_hash

    badges_hash = {}

    grouped_group_identifiers_badges.values.each do |group_identifiers|
      group_identifiers.values.each do |badges|
        badges.each do |badge|
          badges_hash[badge.identifier] = badge
        end
      end
    end

    badges_hash
  end

  def groups
    grouped_group_identifiers_badges.keys
  end

  def grouped_badges

    grouped_badges = {}

    grouped_group_identifiers_badges.each do |group, group_grouped_identifiers_badges|
      grouped_badges[group] = group_grouped_identifiers_badges.values.flatten
    end

    grouped_badges
  end

  def grouped_group_identifiers_badges
    @grouped_group_identifiers_badges ||= GroupedBadgesBuilder.build(BadgeDescriptionFileReader.read)
  end

  def group_identifiers group
    grouped_group_identifiers_badges[group].keys
  end

  def group_identifiers_belong_to_group group, group_identifiers
    group_identifiers(group) & group_identifiers
  end

  def group_identifiers_grouped_badges group
    group_identifiers_grouped_badges = []

    grouped_group_identifiers_badges[group].values.each do |group_identifier_grouped_badges|
      group_identifiers_grouped_badges << group_identifier_grouped_badges
    end

    group_identifiers_grouped_badges
  end

  def most_valuable_badge user_id
    badges = badges_by_user_id user_id
    badges.max_by { |badge| badge.score }
  end

  def sum_badge_scores user_id
    badges = badges_by_user_id user_id
    badges.map(&:score).inject(0, :+)
  end
end