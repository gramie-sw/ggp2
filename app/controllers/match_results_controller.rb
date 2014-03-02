class MatchResultsController < ApplicationController

  def new
    @match_result_presenter = MatchResultPresenter.new(MatchResult.new(match_id: params[:match_id]))
  end

  def create
    @match_result = MatchResult.new params[:match_result]

    if @match_result.save
      redirect_to matches_path, notice: t('model.messages.updated', model: @match_result.message_name)
    else
      @match_result_presenter = MatchResultPresenter.new(@match_result)
      render :new
    end
  end
end