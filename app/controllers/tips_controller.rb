class TipsController < ApplicationController

  def edit_multiple
    @presenter = TipsEditMultiplePresenter.new(tip_ids: params[:tip_ids])
  end

  def update_multiple
    result = Tip.update_multiple(params[:tips])

    notice = t('model.messages.count.updated',
               count: result.succeeded_records.count,
               models: Tip.model_name.human(count: result.succeeded_records.count))

    if result.no_errors?
      redirect_to user_tip_path(current_user), notice: notice
    else
      @presenter = TipsEditMultiplePresenter.new(tips: result.failed_records)
      unless result.succeeded_records.empty?
        flash.now[:notice] = notice
      end
      render :edit_multiple
    end
  end
end
