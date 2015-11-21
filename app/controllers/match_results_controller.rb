class MatchResultsController < ApplicationController

  def edit
    match_result = MatchResult.new(match_id: params[:id])
    @presenter = MatchResultPresenter.new(match_result)
  end

  def update
    match_result = MatchResults::Update.run(match_id: params[:id],
                                            match_result_attributes: params[:match_result])

    if match_result.errors.blank?
      redirect_to match_schedules_path(aggregate_id: match_result.match.aggregate_id),
                  notice: t('model.messages.updated', model: match_result.message_name)
    else
      @presenter = MatchResultPresenter.new(match_result)
      render :edit
    end
  end

  def destroy
    MatchResults::Delete.run(match_id: params[:id])

    redirect_to match_schedules_path, notice: t('model.messages.destroyed', model: t('match.result'))
  end
end