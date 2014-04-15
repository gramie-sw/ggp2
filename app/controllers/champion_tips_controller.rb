class ChampionTipsController < ApplicationController

  def edit
    @presenter = ChampionTipsEditPresenter.new(current_resource)
  end

  def update
    champion_tip = current_resource
    if champion_tip.update(params[:champion_tip])
      redirect_to user_tip_path(current_user), notice: t('model.messages.updated', model: ChampionTip.model_name.human)
    else
      @presenter = ChampionTipsEditPresenter.new(current_resource)
      render :edit
    end
  end

  private

  def current_resource
    @current_resource ||= ChampionTip.find params[:id] if params[:id]
  end
end
