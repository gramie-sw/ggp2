class UsersIndexPresenter

  attr_reader :users

  def initialize(users, type=User::TYPES[:player])
    @users = users
    @type = type
  end

  def showing_admins?
    @type == User::TYPES[:admin]
  end

end