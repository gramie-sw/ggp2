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

  def edit
    @comment = current_resource
  end

  def update

    service = CommentService.new
    result = service.update_comment(current_resource, comment_params)

    if result.successful?
      redirect_to pin_boards_path, notice: t('model.messages.updated', model: Comment.model_name.human)
    else
      @comment = result.comment
      render :edit
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:user_id, :content)
  end

  def current_resource
    @current_resource ||= Comment.find(params[:id]) if params[:id]
  end
end