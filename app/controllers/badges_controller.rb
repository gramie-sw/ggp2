class BadgesController < ApplicationController

  def show
    @presenter = BadgesShowPresenter.new
    ShowBadges.new.run(@presenter)
  end
end