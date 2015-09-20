module Users
  class Update < UseCase

    attribute :user_id, Integer
    attribute :user_attributes
    attribute :current_user

    def run
      user = User.find(user_id)
      authorize!(user)
      user.update(user_attributes)
      user
    end

    private

    def authorize!(user)
      unless user == current_user || current_user.admin?
        raise Ggp2::AuthorizationFailedError
      end
    end

  end
end