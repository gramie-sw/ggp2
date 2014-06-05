class AdaptedDevise::RegistrationsController < Devise::RegistrationsController

  def new
    super
  end

  def create

    if verify_recaptcha

      result = CreateUser.new.run(params[:user])

      if result.successful?
        UserMailer.user_signed_up(result.user, result.raw_token).deliver
        redirect_to new_user_session_path, notice: t('devise.passwords.send_initial_instructions')
      else
        @user = result.user
        render :new
      end

    else
      @user = User.new(params[:user])
      @user.errors[:base] << I18n.t('recaptcha.wrong_input')
      render :new
    end
  end

  def after_update_path_for(user)
    profile_path(user, section: :user_data)
  end

  private
end