class ShowAllGroupsOfPhase

  def initialize phase_id
    @phase_id = phase_id
  end

  def run_with_presentable presentable
    presentable.groups = Aggregate.all_groups_by_phase_id(phase_id: phase_id, sort: :position)
  end

  private

  attr_reader :phase_id
end