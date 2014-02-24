class MatchResultsController < ApplicationController

  def edit
    @match_result = MatchResult.new params[:id]
  end

  def update
    @match_result = MatchResult.new params[:id]
    @match_result.score_team_1 = params[:match_result][:score_team_1].to_i
    @match_result.score_team_2 = params[:match_result][:score_team_2].to_i

    if @match_result.valid?
      match = Match.find(@match_result.match_id)
      match.score_team_1= @match_result.score_team_1
      match.score_team_2= @match_result.score_team_2
      match.save
      redirect_to matches_path, notice: t('model.messages.updated', model: match.message_name)
    else
      render :edit
    end
  end
end