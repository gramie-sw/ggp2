class PlayerPermissions

  include Permissioner::Configurer

  def configure_permissions
    #actions
    allow_actions 'devise/sessions', [:new, :create, :destroy]
    allow_actions 'adapted_devise/registrations', [:edit, :update]
    allow_actions :award_ceremonies, [:show]
    allow_actions :champion_tips, [:edit, :update]
    allow_actions :comments, [:new, :create, :edit, :update]
    allow_actions :match_tips, [:show]
    allow_actions :user_tips, [:show]
    allow_actions :pin_boards, [:show]
    allow_actions :profiles, [:show]
    allow_actions :rankings, [:show]
    allow_actions :roots, [:show]
    allow_actions :tips, [:edit_multiple, :update_multiple]

    #attributes
    allow_attributes :user, [:email, :nickname, :first_name, :last_name, :current_password, :password, :password_confirmation, :remember_me]
    allow_attributes :champion_tip, [:team_id]
    allow_attributes :comment, [:user_id, :content]
  end
end