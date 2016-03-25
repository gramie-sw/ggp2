module AggregateQueries

  class << self

    def all_groups_by_phase_id(phase_id:, sort:)
      Aggregate.where(ancestry: phase_id).order(sort)
    end

    def all_phases_ordered_by_position_asc
      Aggregate.phases.order('position ASC')
    end
  end
end