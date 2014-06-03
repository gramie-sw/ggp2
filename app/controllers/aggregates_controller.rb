class AggregatesController < ApplicationController

  def index
    @aggregates = Aggregate.all_ordered_by_position_asc_recursive
  end

  def new
    @aggregate = Aggregate.new
  end

  def edit
    @aggregate = current_resource
  end

  def create
    @aggregate = Aggregate.new(params[:aggregate])

    if @aggregate.save
      redirect_to aggregates_path, notice: t('model.messages.created', model: @aggregate.message_name)
    else
      render :new
    end
  end

  def update
    @aggregate = current_resource

    if @aggregate.update_attributes(params[:aggregate])
      redirect_to aggregates_path, notice: t('model.messages.updated', model: @aggregate.message_name)
    else
      render :edit
    end
  end

  def destroy
    @aggregate = current_resource
    @aggregate.destroy

    redirect_to aggregates_path, notice: t('model.messages.destroyed', model: @aggregate.message_name)
  end

  private

  def current_resource
    @current_resource ||= Aggregate.find(params[:id]) if params[:id]
  end
end