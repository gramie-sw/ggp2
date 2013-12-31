class TeamsController < ApplicationController

  def index
    @presenter = TeamsIndexPresenter.new
  end

  def create
    @team = Team.new(team_params)

    if @team.save
      redirect_to teams_path, notice: t('model.messages.created', model: @team.message_country_name)
    else
      @presenter = TeamsIndexPresenter.new(@team)
      render :index
    end
  end

  def destroy
    @team = current_resource
    @team.destroy

    redirect_to teams_path, notice: t('model.messages.destroyed', model: @team.message_country_name)
  end

  private

  def current_resource
    @current_resource ||= Team.find(params[:id]) if params[:id]
  end

  def team_params
    params.require(:team).permit(:country)
  end
end