class MatchResultsController < ApplicationController

  def new
    @match_result_presenter = MatchResultPresenter.new(MatchResult.new(match_id: params[:match_id]))
  end

  def create
    @match_result = MatchResult.new params[:match_result]

    if @match_result.save

      process_new_match_result = ProcessNewMatchResult.new
      process_new_match_result.run(@match_result.match_id.to_i)
      update_user_badges = UpdateUserBadges.new(:tip)
      update_user_badges.run

      redirect_to match_schedules_path(aggregate_id: @match_result.match.aggregate_id),
                  notice: t('model.messages.updated', model: @match_result.message_name)
    else
      @match_result_presenter = MatchResultPresenter.new(@match_result)
      render :new
    end
  end
end