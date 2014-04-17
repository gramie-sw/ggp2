class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  rescue_from Permissioner::NotAuthorized do
    render file: "#{Rails.root}/public/403", layout: false, status: :forbidden
  end

  # before_action :configure_permitted_parameters, if: :devise_controller?
  before_filter :authenticate_user!
  before_filter :authorize

  def after_sign_in_path_for(user)
    if user.admin?
      matches_path
    else
      user_tip_path(user)
    end
  end

  def tournament
    @tournament ||= Tournament.new
  end

  def is_user_current_user? user
    user == current_user
  end

  protected

  def after_sign_out_path_for(resource_or_scope)
    new_user_session_path
  end

  # def configure_permitted_parameters
  #   devise_parameter_sanitizer.for(:sign_up) << :nickname << :first_name << :last_name
  # end
end
