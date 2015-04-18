class MatchesController < ApplicationController

  def new
    @match = Match.new
  end

  def edit
    @match = current_resource
  end

  def create
    @match = Match.new(params[:match])

    if @match.save
      redirect_to match_schedules_path(aggregate_id: @match.aggregate_id),
                  notice: t('model.messages.added', model: @match.message_name)
    else
      render :new
    end
  end

  def update
    @match = current_resource

    if @match.update_attributes(params[:match])
      redirect_to match_schedules_path(aggregate_id: @match.aggregate_id), notice: t('model.messages.updated', model: @match.message_name)
    else
      render :edit
    end
  end

  def destroy
    @match = current_resource
    @match.destroy

    redirect_to matches_path, notice: t('model.messages.destroyed', model: @match.message_name)
  end

  private

  def current_resource
    @current_resource ||= Match.find(params[:id]) if params[:id]
  end
end