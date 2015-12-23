class CommentsController < ApplicationController

  def new
    @comment = Comment.new(user_id: current_user.id)
  end

  def create
    @comment = Comments::Create.run(user_id: current_user.id, comment_attributes: params[:comment])

    if @comment.errors.blank?

      # TODO @crimi move call uc to Comments::Create
      update_user_badges = UpdateUserBadges.run(group: :comment)

      redirect_to pin_boards_path, notice: t('model.messages.created', model: Comment.model_name.human)
    else
      render :new
    end
  end

  def edit
    @comment = current_resource
  end

  def update
    @comment = Comments::Update.run(id: params[:id], comment_attributes: params[:comment])

    if @comment.errors.blank?
      redirect_to pin_boards_path, notice: t('model.messages.updated', model: Comment.model_name.human)
    else
      render :edit
    end

  end

  def destroy
    Comments::Delete.run(id: params[:id])

    # TODO @crimi move call uc to Comments::Delete
    UpdateUserBadges.run(group: :comment)

    redirect_to pin_boards_path, notice: t('model.messages.destroyed', model: Comment.model_name.human)
  end

  private

  def current_resource
    @current_resource ||= Comment.find(params[:id]) if params[:id]
  end
end