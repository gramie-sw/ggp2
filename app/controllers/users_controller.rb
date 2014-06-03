class UsersController < ApplicationController

  USER_INDEX_REFERER_COOKIE_KEY = 'uir'

  skip_before_filter :authenticate_user!, only: :new
  before_filter :remember_user_index_referer, only: :index

  def index
    @users = params[:type] == User::USER_TYPE_ADMINS ? User.admins : User.players
  end

  def new
    @user = User.new
  end

  def show
    @presenter = UserShowPresenter.new
    ShowUser.new(params[:id]).run_with_presentable(@presenter)
  end

  def create
    result = CreateUser.new.run(params[:user])

    if result.successful?

    else
      @user = result.user
      render :new

    end
  end


  def edit
    @user = current_resource
  end

  def update

  end

  def destroy
    user = DeleteUser.new(params[:id]).run
    redirect_to users_path, notice: t('model.messages.destroyed', model: user.nickname)
  end

  private

  def remember_user_index_referer
    cookies[USER_INDEX_REFERER_COOKIE_KEY] = request.fullpath
  end

  def current_resource
    @current_resource ||= User.find(params[:id]) if params[:id]
  end
end