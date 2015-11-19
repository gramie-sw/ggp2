class ChampionTipsController < ApplicationController

  def edit
    @presenter = ChampionTipsEditPresenter.new(current_resource)
  end

  def update

    champion_tip = ChampionTips::SetTeam.run(id: params[:id], team_id: params[:champion_tip][:team_id])

    if champion_tip.errors.blank?
      redirect_to user_tip_path(current_user), notice: t('model.messages.updated',
                            model: t('general.champion_tip.one', champion_title: champion_title))
    else
      @presenter = ChampionTipsEditPresenter.new(champion_tip)
      render :edit
    end
  end

  private

  def current_resource
    @current_resource ||= ChampionTip.find params[:id] if params[:id]
  end
end
