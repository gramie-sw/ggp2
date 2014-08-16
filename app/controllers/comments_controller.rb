class CommentsController < ApplicationController

  def new
    @comment = Comment.new(user_id: current_user.id)
  end

  def create
    @comment = Comment.new(params[:comment])

    if @comment.save

      update_user_badges = UpdateUserBadges.new(:comment)
      update_user_badges.run

      redirect_to pin_boards_path, notice: t('model.messages.created', model: Comment.model_name.human)
    else
      render :new
    end
  end

  def edit
    @comment = current_resource
  end

  def update
    UpdateComment.
        new(current_user: current_user, comment_id: params[:id], attributes: params[:comment]).
        run_with_callback(self)
  end

  def update_succeeded comment
    redirect_to pin_boards_path, notice: t('model.messages.updated', model: Comment.model_name.human)
  end


  def update_failed comment
    @comment = comment
    render :edit
  end


  def destroy
    DeleteComment.new(params[:id]).run
    UpdateUserBadges.new(:comment).run
    redirect_to pin_boards_path, notice: t('model.messages.destroyed', model: Comment.model_name.human)
  end

  private

  def current_resource
    @current_resource ||= Comment.find(params[:id]) if params[:id]
  end
end