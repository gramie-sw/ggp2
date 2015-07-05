class CreateUser

  ResultWithToken = Struct.new(:user, :successful?, :raw_token)

  def initialize
    @tip_factory = TipFactory.new(Match)
  end

  def run user_attributes

    reset_password_tokens = TokenFactory.reset_password_tokens

    set_additional_user_attributes user_attributes, TokenFactory.password_token

    user = User.new(user_attributes)
    user.tips = tip_factory.build_all
    user.champion_tip = ChampionTip.new
    successful = user.save

    # we have to extra update reset_password_token and reset_password_sent_at, because Devise has a before_save filter
    # clearing reset_password_token and reset_password_sent_at when email or encrypted password changed
    # https://github.com/plataformatec/devise/blob/master/lib/devise/models/recoverable.rb#L12
    if successful
      successful = user.update(
          {reset_password_token: reset_password_tokens.encrypted_token, reset_password_sent_at: Time.current})
    end

    ResultWithToken.new(user, successful, reset_password_tokens.raw_token)
  end

  private

  attr_reader :tip_factory

  def set_additional_user_attributes user_attributes, password_token
    user_attributes.merge!(admin: false) unless user_attributes[:admin]
    user_attributes.merge!(active: true, password: password_token, password_confirmation: password_token)
  end
end