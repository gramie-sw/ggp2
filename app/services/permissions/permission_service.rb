class PermissionService

  include Permissioner::ServiceAdditions
  include CustomMethods

  def configure_permissions

    if current_user

      if current_user.admin?
        @allow_all = true
      else
        configure PlayerPermissions
      end
    else
      configure GuestPermissions
    end
  end
end