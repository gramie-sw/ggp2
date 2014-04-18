class GuestPermissions

  include Permissioner::Configurer

  def configure_permissions
    #actions
    allow_actions 'devise/sessions', [:new, :create]
    allow_actions 'devise/passwords', [:new, :create, :edit, :update]
    allow_actions 'adapted_devise/registrations', [:new, :create]

    allow_attributes :user, [:email, :nickname, :first_name, :last_name, :password, :password_confirmation, :reset_password_token]
  end
end