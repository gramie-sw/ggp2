class FindAllGroupsOfPhase

  def initialize phase_id
    @phase_id = phase_id
  end

  def run
    Aggregate.all_groups_by_phase_id(phase_id: phase_id, sort: :position)
  end

  private

  attr_reader :phase_id
end