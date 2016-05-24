class MatchSchedulesController < ApplicationController

  def show
    current_aggregate = Aggregates::FindOrFindCurrentPhase.run(id: params[:aggregate_id])
    @presenter = MatchSchedulePresenter.new(current_aggregate: current_aggregate)
    session[Ggp2::MATCH_SCHEDULE_LAST_SHOWN_AGGREGATE_ID_KEY] = params[:aggregate_id]
  end
end