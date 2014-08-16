class ChampionTipsController < ApplicationController

  def edit
    @presenter = ChampionTipsEditPresenter.new(current_resource)
  end

  def update

    result = UpdateChampionTip.new(current_user: current_user, champion_tip_id: params[:id],
                                       attributes: params[:champion_tip]).run

    if result.successful
      redirect_to user_tip_path(current_user), notice: t('model.messages.updated', model: ChampionTip.model_name.human)
    else
      @presenter = ChampionTipsEditPresenter.new(result.champion_tip)
      render :edit
    end
  end

  private

  def current_resource
    @current_resource ||= ChampionTip.find params[:id] if params[:id]
  end
end
