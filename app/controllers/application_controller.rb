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

  before_action :authenticate_user!
  before_action :authorize

  helper_method :champion_title, :colors, :main_navbar_presenter, :random_quotation, :tournament_title,

  def after_sign_in_path_for(user)
    if user.admin?
      match_schedules_path
    else
      user_tip_path(user)
    end
  end

  def tournament_title
    tournament.title
  end

  def champion_title
    tournament.champion_title
  end

  def tournament
    @tournament ||= Tournament.new
  end

  def is_user_current_user? user
    user == current_user
  end

  def random_quotation
    QuotationQueries.find_sample
  end

  def colors
    ColorCodeQueries.all
  end

  def main_navbar_presenter
    if current_user.admin?
      AdminMainNavbarPresenter.new(params: params)
    else
      UserMainNavbarPresenter.new(params: params, current_user: current_user, tournament: tournament)
    end
  end

  protected

  def after_sign_out_path_for(resource_or_scope)
    new_user_session_path
  end

  def render_403
    render file: "#{Rails.root}/public/403", layout: false, status: :forbidden
  end
end
