class AdaptedDevise::RegistrationsController < Devise::RegistrationsController

  def new
    super
  end

  def create
    result = CreateUser.new.run(user_params)

    if result.successful?
      UserMailer.user_signed_up(result.user, result.raw_token).deliver
      redirect_to new_user_session_path, notice: t('devise.passwords.send_initial_instructions')
    else
      @user = result.user
      render :new
    end
  end

  def after_update_path_for(user)
    profile_path(user, section: :user_data)
  end

  private

  def user_params
    params.require(:user).permit(:email, :nickname, :first_name, :last_name)
  end
end