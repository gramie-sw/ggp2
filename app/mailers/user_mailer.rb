class UserMailer < ActionMailer::Base
  #default from: "from@example.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.user_created.subject
  #
  def user_signed_up(user, token)
    @user = user
    @token = token
    @tournament_title = PropertyQueries.find_value(Property::TOURNAMENT_TITLE_KEY)

    mail to: user.email, subject: I18n.t('user_mailer.user_signed_up.subject', tournament_title: @tournament_title)
  end
end