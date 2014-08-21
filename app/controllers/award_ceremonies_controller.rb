class AwardCeremoniesController < ApplicationController

  def show
    @presenter = AwardCeremoniesShowPresenter.new tournament
    @presenter.places = FindWinnerRanking.new.run
  end
end