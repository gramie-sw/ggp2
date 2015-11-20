module Comments
  class Update < UseCase

    attribute :id, Integer
    attribute :comment_attributes

    def run
      comment= Comment.find(id)
      comment.update(comment_attributes.merge(edited: true))
      comment
    end
  end
end