module ControllerMacros

  def create_and_sign_in user_role
    user = create(user_role)
    sign_in user
    user
  end
end