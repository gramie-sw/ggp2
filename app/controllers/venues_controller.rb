class VenuesController < ApplicationController

  def index
    @venues = Venue.all
  end

  def edit
    @venue = current_resource
  end

  def current_resource
    @current_resource ||= Venue.find(params[:id]) if params[:id]
  end
end