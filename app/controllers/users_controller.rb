class UsersController < ApplicationController

  USER_INDEX_REFERER_COOKIE_KEY = 'uir'

  before_filter :remember_user_index_referer, only: :index

  def index
    users = Users::FindAllByType.run(type: params[:type], page: params[:page])
    @presenter = UsersIndexPresenter.new(users, params[:type])
  end

  def new
    @user = User.new
  end

  def show
    @user = current_resource
  end

  def create
    result = Users::Create.run(user_attributes: params[:user])

    if result.user.errors.empty?
      redirect_to users_path
    else
      @user = result.user
      render :new
    end
  end

  def edit
    @user = current_resource
  end

  def update

    UpdateUser.
        new(current_user: current_user, user_id: params[:id], attributes: params[:user]).
        run_with_callback(self)
  end

  def update_succeeded(user)
    if request.referrer.match('/user_tips').present?
      redirect_to URI(request.referrer).path
    end
  end

  def update_failed(user)
    if request.referrer.match('/user_tips').present?
      render_403
    end
  end

  def destroy
    user = Users::Delete.run(id: params[:id])
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