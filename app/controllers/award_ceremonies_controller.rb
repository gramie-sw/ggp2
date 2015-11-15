class AwardCeremoniesController < ApplicationController

  def show
    @presenter = AwardCeremoniesShowPresenter.new tournament
    @presenter.places = RankingItems::FindWinners.new.run
  end
end