class UsersController < ApplicationController

  USER_INDEX_REFERER_COOKIE_KEY = 'uir'

  skip_before_filter :authenticate_user!, only: :new
  before_filter :remember_user_index_referer, only: :index

  def index
    @presenter = UsersIndexPresenter.new
    ShowUsers.new.run_with_presentable(presentable: @presenter, type: params[:type], page: params[:page],
                                       per_page: Ggp2.config.user_page_count)
  end

  def new
    @user = User.new
  end

  def show
    @user = current_resource
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