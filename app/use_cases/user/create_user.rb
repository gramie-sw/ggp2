class CreateUser

  ResultWithToken = Struct.new(:user, :successful?, :raw_token)

  def initialize
    @tip_factory = TipFactory.new(Match)
  end

  def run user_attributes

    reset_password_tokens = TokenFactory.reset_password_tokens
    set_additional_user_attributes user_attributes, TokenFactory.password_token, reset_password_tokens.encrypted_token, Time.current

    user = User.new(user_attributes)
    user.tips = tip_factory.build_all
    user.champion_tip = ChampionTip.new
    successful = user.save

    ResultWithToken.new(user, successful, reset_password_tokens.raw_token)
  end

  private

  attr_reader :tip_factory

  def set_additional_user_attributes user_attributes, password_token, reset_password_token, reset_password_sent_at
    user_attributes.merge!(active: true, password: password_token, password_confirmation: password_token,
                           reset_password_token: reset_password_token, reset_password_sent_at: reset_password_sent_at)
  end
end