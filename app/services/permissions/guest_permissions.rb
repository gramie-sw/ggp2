class GuestPermissions

  include Permissioner::Configurer

  def configure_permissions
    #actions
    allow_actions 'devise/sessions', [:new, :create, :destroy]
    allow_actions 'devise/passwords', [:new, :create, :edit, :update]
    allow_actions 'adapted_devise/registrations', [:new, :create]

    allow_attributes :user, [:email, :nickname, :first_name, :last_name]
  end
end