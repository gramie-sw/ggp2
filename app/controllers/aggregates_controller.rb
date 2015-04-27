class AggregatesController < ApplicationController

  def new
    @presenter = AggregateFormPresenter.new(Aggregate.new(parent_id: params[:phase_id]))
  end

  def edit
    @presenter = AggregateFormPresenter.new(current_resource)
  end

  def create
    aggregate = Aggregate.create(params[:aggregate])

    if aggregate.errors.blank?
      notice = t('model.messages.created', model: aggregate.message_name)

      if params[:subsequent_aggregate].present?
        redirect_to new_aggregate_path(phase_id: aggregate.parent_id), notice: notice
      else
        redirect_to match_schedules_path(aggregate_id: aggregate.id), notice: notice
      end
    else
      @presenter = AggregateFormPresenter.new(aggregate)
      render :new
    end
  end

  def update
    aggregate = current_resource

    if aggregate.update_attributes(params[:aggregate])
      redirect_to match_schedules_path(aggregate_id: aggregate.parent_id),
                  notice: t('model.messages.updated', model: aggregate.message_name)
    else
      @presenter = AggregateFormPresenter.new(aggregate)
      render :edit
    end
  end

  def destroy
    aggregate = current_resource
    aggregate.destroy

    redirect_to match_schedules_path(aggregate_id: aggregate.parent_id),
                notice: t('model.messages.destroyed', model: aggregate.message_name)
  end

  private

  def current_resource
    @current_resource ||= Aggregate.find(params[:id]) if params[:id]
  end
end