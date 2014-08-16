class BadgesController < ApplicationController

  def show
    result = FindBadges.new.run
    @presenter = BadgesShowPresenter.new
    @presenter.groups = result.groups
    @presenter.grouped_badges = result.grouped_badges
  end
end