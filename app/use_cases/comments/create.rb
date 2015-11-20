module Comments
  class Create < UseCase

    attribute :user_id, Integer
    attribute :comment_attributes

    def run
      Comment.create(comment_attributes.merge(user_id: user_id))
    end
  end
end