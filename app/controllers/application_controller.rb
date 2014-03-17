class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :authenticate_user!

  def after_sign_in_path_for(user)
    if user.admin?
      matches_path
    else
      user_tip_path(user)
    end
  end

  def permission_service
    @permission_service ||= PermissionService.new
  end

  def tournament
    @tournament ||= Tournament.new
  end
end
