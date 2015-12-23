module BadgesBuilder

  def self.build badges_description
    cloned_badges_description = Marshal.load(Marshal.dump(badges_description))

    cloned_badges_description.map do |badge_description|
      attributes = badge_description[:attributes]
      levels = attributes.delete(:levels)

      levels.map do |level|
        Object.const_get(badge_description[:class]).new(attributes.merge(level))
      end
    end.flatten!
  end
end