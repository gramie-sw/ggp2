class CommentService

  UpdateResult = Struct.new(:comment, :successful?)

  def update_comment comment, attributes

    if comment.update(attributes.merge({edited: true}))
      successful = true
    else
      successful = false
    end
    UpdateResult.new(comment, successful)
  end
end