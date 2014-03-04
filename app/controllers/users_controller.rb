class UsersController < ApplicationController

  USER_INDEX_REFERER_COOKIE_KEY =  'uir'

  before_filter :remember_user_index_referer, only: :index

  def index
    @users = params[:type] == User::USER_TYPE_ADMINS.to_s ? User.admins : User.players
  end

  def edit
    @user = current_resource
  end

  def update

  end

  private

  def remember_user_index_referer
    cookies[USER_INDEX_REFERER_COOKIE_KEY] = request.fullpath
  end

  def current_resource
    @current_resource ||= User.find(params[:id]) if params[:id]
  end
end