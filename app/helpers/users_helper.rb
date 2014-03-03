module UsersHelper

  def user_index_path
    cookies[USER_INDEX_PREFERER_COOKIE_KEY] || users_path
  end
end