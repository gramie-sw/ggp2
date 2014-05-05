class BadgesController < ApplicationController

  def show
    @presenter = BadgesShowPresenter.new
  end
end