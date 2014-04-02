class UserCreator

  Result = Struct.new(:user, :successful?)

  def initialize tip_factory
    @tip_factory = tip_factory
  end

  def create_with_reset_password_token user_attributes, password_token, reset_password_token

    set_additional_user_attributes user_attributes, password_token, reset_password_token, Time.current

    user = User.new(user_attributes)
    user.tips = tip_factory.build_all
    successful = user.save

    Result.new(user, successful)
  end

  private

  def set_additional_user_attributes user_attributes, password_token, reset_password_token, reset_password_sent_at
    user_attributes.merge!(active: true, password: password_token, password_confirmation: password_token,
                          reset_password_token: reset_password_token, reset_password_sent_at: reset_password_sent_at)
  end

  attr_reader :tip_factory
end