class BadgesGroupedBuilder

  def build file_read_badges_hash

    grouped_badges = Hash.new

    file_read_badges_hash.keys.each do |group|
      grouped_badges[group] = badges_by_group(group: group, file_read_badges_hash: file_read_badges_hash)
    end

    grouped_badges
  end

  private

  def badges_by_group(group:, file_read_badges_hash:)
    file_read_badges_hash[group].map do |load_badge|
      Object.const_get(load_badge[:class]).new(load_badge[:attributes])
    end
  end
end