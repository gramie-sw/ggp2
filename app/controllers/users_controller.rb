class UsersController < ApplicationController

  before_filter :remember_user_index_referer, only: :index

  def index
    @users = params[:type] == USER_TYPE_ADMINS ? User.admins : User.players
  end

  def edit
    @user = current_resource
  end

  def update

  end


  def remember_user_index_referer
    cookies[USER_INDEX_PREFERER_COOKIE_KEY] = request.fullpath
  end

  private

  def current_resource
    @current_resource ||= User.find(params[:id]) if params[:id]
  end
end