class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  rescue_from Permissioner::NotAuthorized do
    render_403
  end

  rescue_from Ggp2::AuthorizationFailedError do
    render_403
  end

  before_filter :authenticate_user!
  before_filter :authorize

  helper_method :main_nav_links, :random_quotation

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

  def random_quotation
    ShowRandomQuotation.new.run
  end

  def main_nav_links
    MainNavLinksProvider.create(params[:controller], params[:action]).links(current_user, tournament)
  end

  protected

  def after_sign_out_path_for(resource_or_scope)
    new_user_session_path
  end

  def render_403
    render file: "#{Rails.root}/public/403", layout: false, status: :forbidden
  end
end
