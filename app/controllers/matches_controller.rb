class MatchesController < ApplicationController

  def index
    @presenter = MatchesIndexPresenter.new
  end
end