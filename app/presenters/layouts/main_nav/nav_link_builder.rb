class NavLinkBuilder

  def initialize section_registry, *current_active_markers
    @section_registry = section_registry
    @current_active_markers = current_active_markers
  end

  def build label, url, section
    NavLink.new(
        label: label,
        url: url,
        active: section_registry.is_active?(section, *current_active_markers)
    )
  end

  private

  attr_accessor :section_registry, :current_active_markers
end