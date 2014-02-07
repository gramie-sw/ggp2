class MatchesController < ApplicationController

  def index
    @matches = Match.all
  end

  def new
    @match = Match.new
  end

  def edit
    @match = current_resource
  end

  def create
    @match = Match.new(match_params)

    if @match.save
      redirect_to matches_path, notice: t('model.messages.created', model: @match.message_name)
    else
      render :new
    end
  end

  def update
    @match = current_resource

    if @match.update_attributes(match_params)
      redirect_to matches_path, notice: t('model.messages.updated', model: @match.message_name)
    else
      render :edit
    end
  end

  def destroy
    @match = current_resource
    @match.destroy

    redirect_to matches_path, notice: t('model.messages.destroyed', model: @match.message_name)
  end

  private

  def current_resource
    @current_resource ||= Match.find(params[:id]) if params[:id]
  end

  def match_params
    params.require(:match).permit(:position, :team_1_id, :team_2_id, :score_team_1, :score_team_2, :placeholder_team_1, :placeholder_team_2,
                                  :venue_id, :date)
  end
end