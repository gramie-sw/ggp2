class ShowUsers

  def run_with_presentable(presentable:, type:, page:, per_page:)

    admin = (type == User::USER_TYPE_ADMINS)
    presentable.admin= admin
    presentable.users= User.users_listing(admin: admin, page: page, per_page: per_page).order_by_nickname_asc
  end
end