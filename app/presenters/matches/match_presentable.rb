module MatchPresentable

  def phases
    @phases ||= Aggregate.all_phases_ordered_by_position_asc
  end

  def match_presenters_of(aggregate)
    @match_presenters = [] unless @match_presenters
    @match_presenters[aggregate.id] ||= begin
      aggregate.
          matches_including_of_children.
          order_by_position_asc.
          includes(:team_1, :team_2).
          collect { |m| MatchPresenter.new m }
    end
  end
end