class AwardCeremoniesController < ApplicationController

  def show
    @presenter = AwardCeremoniesShowPresenter.new tournament
    @presenter.places = Rankings::FindWinners.new.run
  end
end