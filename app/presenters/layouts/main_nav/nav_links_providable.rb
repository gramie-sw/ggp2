module NavLinksProvidable

  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods

    def create *current_active_marker
      builder = NavLinkBuilder.new(section_registry, *current_active_marker)
      self.new(builder)
    end

    def section section
      SectionConfigurator.new(section, section_registry)
    end

    def section_registry
      @section_registry ||= SectionRegistry.new
    end
  end

  class SectionConfigurator < Struct.new(:section, :section_registry)

    def is_active_for *active_markers
      section_registry.register_section SectionConfiguration.new(section: section, active_markers: active_markers)
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