class VenuesController < ApplicationController

  def index
    @venues = Venue.all
  end

  def edit
    @venue = current_resource
  end

  def update
    @venue = current_resource

    if @venue.update_attributes(venue_params)
      redirect_to venues_path
    else
      render action: :edit
    end
  end

  private

  def current_resource
    @current_resource ||= Venue.find(params[:id]) if params[:id]
  end

  def venue_params
    params.require(:venue).permit(:city, :stadium, :capacity)
  end
end