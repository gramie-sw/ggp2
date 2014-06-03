class ShowUser

  def initialize user_id
    @user_id = user_id
  end

  def run_with_presentable presentable
    presentable.user = User.find(user_id)
  end

  private

  attr_reader :user_id
end