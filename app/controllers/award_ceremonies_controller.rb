class AwardCeremoniesController < ApplicationController

  def show
    @presenter = AwardCeremoniesShowPresenter.new tournament
    @presenter.places = Ranking::FindWinners.new.run
  end
end