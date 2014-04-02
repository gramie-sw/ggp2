module CreateUser
  extend self

  ResultWithToken = Struct.new(:user, :successful?, :raw_token)

  def create_with_password_token user_attributes
    tip_factory = TipFactory.new(match_repository: Match)
    user_creator = UserCreator.new(tip_factory)
    reset_password_tokens = TokenFactory.reset_password_tokens
    result = user_creator.create_with_reset_password_token(
        user_attributes, TokenFactory.password_token, reset_password_tokens.encrypted_token)

    ResultWithToken.new(result.user, result.successful?, reset_password_tokens.raw_token)
  end
end