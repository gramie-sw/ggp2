module BadgeRepository
  extend self

  def badges_by_group(group:)

    load_badges[group].map do |load_badge|
      symbolize_load_badge_keys load_badge
      Object.const_get(load_badge[:class]).new(load_badge[:attributes])
    end
  end

  private

  def load_badges
    @load_badges ||= YAML.load_file(Ggp2.config.badges_file).symbolize_keys
  end

  def symbolize_load_badge_keys load_badge
    load_badge.symbolize_keys!
    load_badge[:attributes].symbolize_keys!
  end
end