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

    mail to: user.email
  end
end