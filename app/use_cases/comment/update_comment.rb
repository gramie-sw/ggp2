class UpdateComment

  def initialize(current_user:, comment_id:, attributes:)

    @current_user= current_user
    @comment_id= comment_id
    @attributes= attributes
  end

  def run_with_callback callback

    comment= Comment.find(comment_id)
    authorize!(comment.user_id)

    if comment.update(attributes.merge({ edited: true }))
      callback.update_succeeded(comment)
    else
      callback.update_failed(comment)
    end
  end

  private

  def authorize!(user_id)
    unless user_id == current_user.id && current_user.id.to_s == @attributes[:user_id]
      raise Ggp2::AuthorizationFailedError
    end
  end

  attr_reader :current_user, :comment_id, :attributes
end