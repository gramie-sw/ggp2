module BadgeRegistry
  extend self

  def grouped_badges

    @grouped_badges ||= begin
      grouped_badges = Hash.new
      BadgeRepository.load_grouped_badges.keys.each do |group|
        grouped_badges[group] = badges_by_group(group: group)
      end
      grouped_badges
    end
  end

  private

  def badges_by_group(group:)
    BadgeRepository.load_grouped_badges[group].map do |load_badge|
      Object.const_get(load_badge[:class]).new(load_badge[:attributes])
    end
  end
end