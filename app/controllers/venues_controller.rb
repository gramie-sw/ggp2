class VenuesController < ApplicationController

  def index
    @venues = Venue.all
  end

  def new
    @venue = Venue.new
  end

  def edit
    @venue = current_resource
  end

  def create
    @venue = Venue.new(params[:venue])

    if @venue.save
      redirect_to venues_path, notice: t('model.messages.created', model: @venue.message_name)
    else
      render :new
    end
  end

  def update
    @venue = current_resource

    if @venue.update_attributes(params[:venue])
      redirect_to venues_path, notice: t('model.messages.updated', model: @venue.message_name)
    else
      render action: :edit
    end
  end

  def destroy
    @venue = current_resource
    @venue.destroy

    redirect_to venues_path, notice: t('model.messages.destroyed', model: @venue.message_name)
  end

  private

  def current_resource
    @current_resource ||= Venue.find(params[:id]) if params[:id]
  end
end