class CommentsController < ApplicationController

  def new
    @comment = Comment.new(user_id: current_user.id)
  end

  def create
    @comment = Comment.new(comment_params)

    if @comment.save
      redirect_to pin_boards_path, notice: t('model.messages.created', model: Comment.model_name.human)
    else
      render :new
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:user_id, :content)
  end

end