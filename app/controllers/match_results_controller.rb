class MatchResultsController < ApplicationController

  def new
    @match_result = MatchResult.new match_id: params[:match_id]
  end

  def create
    @match_result = MatchResult.new params[:match_result]

    if @match_result.save
      redirect_to matches_path, notice: t('model.messages.updated', model: @match_result.message_name)
    else
      render :new
    end
  end
end