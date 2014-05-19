class ShowAllPhases

  def run_with_presentable presentable
    presentable.phases = Aggregate.all_phased_ordered_by_position_asc
  end
end