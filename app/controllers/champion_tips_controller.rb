class ChampionTipsController < ApplicationController

  def edit
    @presenter = ChampionTipsEditPresenter.new(current_resource)
  end

  def update
    champion_tip = current_resource
    if champion_tip.update(champion_tip_params)
      redirect_to user_tip_path(current_user), notice: t('model.messages.updated', model: ChampionTip.model_name.human)
    else
      @presenter = ChampionTipsEditPresenter.new(current_resource)
      render :edit
    end
  end

  private

  def current_resource
    @current_resource ||= ChampionTip.find params[:id]
  end

  def champion_tip_params
    params.require(:champion_tip).permit(:team_id)
  end
end
