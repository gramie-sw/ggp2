class UserCreateService

  Result = Struct.new(:user, :successful?)

  def initialize(user_factory:, tip_factory:)
    @user_factory = user_factory
    @tip_factory = tip_factory
  end

  def create_with_reset_password_token user_attributes, password_token, reset_password_token
    set_additional_user_attributes user_attributes, password_token, reset_password_token, Time.zone.now
    user = user_factory.build user_attributes
    user.tips = tip_factory.build_all
    user.save ? successful = true : successful = false
    Result.new(user, successful)
  end

  def set_additional_user_attributes user_attributes, password_token, reset_password_token, reset_password_sent_at
    user_attributes[:active] = true
    user_attributes[:password] = password_token
    user_attributes[:password_confirmation] = password_token
    user_attributes[:reset_password_token] = reset_password_token
    user_attributes[:reset_password_sent_at] = reset_password_sent_at
  end

  private
  attr_reader :user_factory, :tip_factory
end