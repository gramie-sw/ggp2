class CommentsController < ApplicationController

  def new
    @comment = Comment.new(user_id: current_user.id)
  end

  def create
    @comment = Comment.new(:params[:comment])

    if @comment.save
      
    else
      render :new
    end
  end

end