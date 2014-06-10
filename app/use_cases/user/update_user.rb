class UpdateUser

  def initialize(current_user:, user_id:, attributes:)
    @current_user = current_user
    @user_id = user_id
    @attributes = attributes
  end

  def run_with_callback callback
    user = User.find(user_id)
    authorize!(user)
    if user.update(attributes)
      callback.update_succeeded(user)
    else
      callback.update_failed(user)
    end
  end

  private

  def authorize!(user)
    unless user == current_user || current_user.admin?
      raise Ggp2::AuthorizationFailedError
    end
  end

  attr_reader :current_user, :user_id, :attributes
end