class TeamsController < ApplicationController

  def index
    @presenter = TeamsIndexPresenter.new
  end

  def create
    @team = Team.new(team_params)

    if @team.save
      #render text: params[:team].inspect
      redirect_to teams_path, notice: t('model.messages.created', model: @team.message_country_name)
    else
      @presenter = TeamsIndexPresenter.new(@team)
      render :index
    end
  end

  private

  def team_params
    params.require(:team).permit(:country)
  end
end