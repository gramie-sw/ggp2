module Users
  class Delete < UseCase

    attribute :id, Integer

    def run
      user = User.find(id)
      user.destroy
      user
    end
  end
end