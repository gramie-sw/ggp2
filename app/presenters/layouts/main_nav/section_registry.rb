class SectionRegistry

  def initialize
    @registry = {}
  end

  def register_section section_configuration
    return unless section_configuration.section && section_configuration.active_markers

    levels = Array(section_configuration.active_markers).map { |level| Array(level) }

    combine_all_levels(levels).each do |combined_level|
      registry[combined_level.to_s] = section_configuration.section.to_s
    end
  end

  def is_active? section, *active_markers
    is_active = false

    active_markers.inject('') do |higher_level_marker, current_marker|

      combined_marker = current_marker.to_s + higher_level_marker.to_s

      if registry[combined_marker] == section.to_s
        is_active = true
        break
      else
        combined_marker
      end
    end

    is_active
  end

  private

  def combine_all_levels levels

    levels[0, levels.count-1].reverse_each.inject(levels.last) do |current_combine_level, higher_level|
      combine_two_levels(current_combine_level, higher_level)
    end
  end

  def combine_two_levels lower_level, higher_level
    combined_level = []
    lower_level.each do |lower_level_entry|
      higher_level.each do |higher_level_entry|
        combined_level << lower_level_entry.to_s + higher_level_entry.to_s
      end
    end
    combined_level
  end

  private

  attr_reader :registry
end