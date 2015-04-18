module AggregateRepository
  extend ActiveSupport::Concern

  included do
    scope :all_phases_ordered_by_position_asc, -> { phases.order_by_position_asc }
  end

  module ClassMethods

    def all_ordered_by_position_asc_recursive
      all_phases_ordered_by_position_asc.map do |phase|
        [phase, phase.children.order_by_position_asc]
      end.flatten
    end

    def all_groups_by_phase_id(phase_id:, sort:)
      where(ancestry: phase_id).order(sort)
    end
  end
end