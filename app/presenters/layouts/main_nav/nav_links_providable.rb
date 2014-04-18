module NavLinksProvidable

  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods

    def create *current_active_marker
      builder = NavLinkBuilder.new(SectionRegistry.new, current_active_marker)
      self.new(builder)
    end

    def section section
      SectionConfigurationBuilder.new(section)
    end
  end

  class SectionConfigurationBuilder < Struct.new(:section)

    def is_active_for *active_markers
        SectionConfiguration.new(section: section, active_markers: active_markers)
    end
  end

  def initialize nav_link_builder
    @nav_link_builder = nav_link_builder
  end

  def nav_link_builder
    @nav_link_builder
  end

  def build_link *args
    nav_link_builder.build(*args)
  end
end