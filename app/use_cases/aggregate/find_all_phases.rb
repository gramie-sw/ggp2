class FindAllPhases

  def run
    Aggregate.all_phased_ordered_by_position_asc
  end
end