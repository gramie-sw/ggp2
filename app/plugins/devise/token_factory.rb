module TokenFactory
  extend self

  ResetPasswordTokens = Struct.new(:raw_token, :encrypted_token)

  def password_token
    Devise.friendly_token
  end

  def reset_password_tokens
    raw_token, encrypted_token = Devise.token_generator.generate(User, :reset_password_token)
    ResetPasswordTokens.new(raw_token, encrypted_token)
  end
end