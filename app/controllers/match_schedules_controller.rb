class MatchSchedulesController < ApplicationController

  def show
    current_aggregate = Aggregates::FindOrFindCurrentPhase.run(id: params[:aggregate_id])
    @presenter = MatchSchedulePresenter.new(current_aggregate: current_aggregate)
  end
end