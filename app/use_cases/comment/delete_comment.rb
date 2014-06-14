class DeleteComment

  def initialize comment_id
    @comment_id = comment_id
  end

  def run
    comment = Comment.find(comment_id)
    comment.destroy
    comment
  end

  private

  attr_reader :comment_id
end