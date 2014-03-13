class ChampionTipsController < ApplicationController

  def edit
    @presenter = ChampionTipsEditPresenter.new champion_tip_id: params[:id]
  end

  def update
  end
end
