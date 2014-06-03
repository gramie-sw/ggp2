class DeleteUser

  def initialize user_id
    @user_id = user_id
  end

  def run
    user = User.find(user_id)
    user.destroy
    user
  end

  private

  attr_reader :user_id
end