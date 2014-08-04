module BadgeRepository
  extend self

  def find_by_indentifiers_sorted identifiers
    badges_sorted.select do |badge|
      identifiers.include? badge.identifier
    end
  end

  def identifiers_belong_to_group group, identifiers
    identifiers_by_group(group) & identifiers
  end

  def groups
    badges_grouped.keys
  end

  def by_group(group)
    badges_sorted_grouped[group]
  end

  def badges_sorted_grouped

    @badges_sorted_grouped ||= begin

      badges_sorted_grouped = {}

      groups.each do |key|
        badges_sorted_grouped[key] = badges_grouped[key].sort_by! { |badge| badge.position }
      end

      badges_sorted_grouped
    end
  end

  def badges_sorted

    badges_sorted_grouped.keys.map do |key|
      badges_sorted_grouped[key]
    end.flatten!
  end

  private

  def badges_grouped
    @badges_grouped ||= BadgesGroupedBuilder.new.build(file_read_badges_hash)
  end

  def identifiers_by_group group
    by_group(group).map(&:identifier)
  end

  def file_read_badges_hash
    BadgeFileReader.instance.read
  end
end