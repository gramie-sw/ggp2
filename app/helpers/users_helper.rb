module UsersHelper

  def user_index_path
    cookies[UsersController::USER_INDEX_REFERER_COOKIE_KEY] || users_path
  end
end