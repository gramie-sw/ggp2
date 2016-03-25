class MatchSchedulePresenter

  attr_reader :current_aggregate

  def initialize(current_aggregate:)
    @current_aggregate = current_aggregate
  end

  def current_phase
    @current_phase ||= begin
      current_aggregate.phase? ? current_aggregate : current_aggregate.parent
    end
  end

  def current_group
    current_aggregate.group? ? current_aggregate : nil
  end

  def all_phases
    @phases ||= AggregateQueries.all_phases_ordered_by_position_asc
  end

  def all_groups
    AggregateQueries.all_groups_by_phase_id(phase_id: current_phase.id, sort: :position)
  end

  def match_presenters
    @match_presenters ||= begin
      matches = MatchQueries.all_by_aggregate_id(current_aggregate.id, order: :position, includes: [:team_1, :team_2])
      matches.collect { |m| MatchPresenter.new m }
    end
  end

end