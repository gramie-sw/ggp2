class RegistrationsController < Devise::RegistrationsController

  def after_update_path_for(user)
    profile_path(user, section: :user_data)
  end

end