class TeamsController < ApplicationController

  def index
    @presenter = TeamsIndexPresenter.new
  end

  def create
    @team = Team.new(params[:team])

    if @team.save
      redirect_to teams_path, notice: t('model.messages.created', model: @team.message_team_name)
    else
      @presenter = TeamsIndexPresenter.new(@team)
      render :index
    end
  end

  def destroy
    @team = current_resource
    @team.destroy

    redirect_to teams_path, notice: t('model.messages.destroyed', model: @team.message_team_name)
  end

  private

  def current_resource
    @current_resource ||= Team.find(params[:id]) if params[:id]
  end
end