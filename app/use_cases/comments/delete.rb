module Comments
  class Delete < UseCase

    attribute :id, Integer

    def run
      comment = Comment.find(id)
      comment.destroy
      comment
    end
  end
end