module MatchRepresentable

  def phases
    @phases ||= Aggregate.phases.order_by_position
  end

  def match_presenters_of(aggregate)
    @match_presenters[aggregate.id] ||= begin
      aggregate.
          matches_including_of_children.
          order_by_position.
          includes(:team_1, :team_2).
          collect { |m| MatchPresenter.new m }
    end
  end
end