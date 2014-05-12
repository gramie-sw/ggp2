module BadgeRepository
  extend self

  def groups
    grouped_badges.keys
  end

  def grouped_badges

    @load_grouped_badges ||= begin
      grouped_badges = YAML.load_file(Ggp2.config.badges_file).symbolize_keys
      symbolize(grouped_badges)
      grouped_badges
    end
  end

  private

  def symbolize grouped_badges
    grouped_badges.keys.each do |key|
      symbolize_load_badges_keys grouped_badges[key]
    end
  end

  def symbolize_load_badges_keys load_badges
    load_badges.each do |load_badge|
      symbolize_load_badge_keys load_badge
    end
  end

  def symbolize_load_badge_keys load_badge
    load_badge.symbolize_keys!
    load_badge[:attributes].symbolize_keys!
  end
end