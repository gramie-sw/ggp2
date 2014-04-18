class SectionConfiguration

  attr_accessor :section
  attr_accessor :active_markers

  def initialize(section: nil, active_markers: nil)
    @section = section
    @active_markers = active_markers
  end

end