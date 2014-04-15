class PlayerPermissions

  include Permissioner::Configurer

  def configure_permissions
    #actions
    allow_actions 'devise/sessions', [:new, :create, :destroy]
    allow_actions 'devise/passwords', [:new, :create, :edit, :update]
    allow_actions 'adapted_devise/registrations', [:new, :create, :edit, :update]

    allow_actions :award_ceremonies, [:show]
    allow_actions :champion_tips, [:edit, :update]
    allow_actions :comments, [:new, :create, :edit, :update]
    allow_actions :match_results, [:new, :create]
    allow_actions :match_tips, [:show]
    allow_actions :user_tips, [:show]
    allow_actions :pin_boards, [:show]
    allow_actions :profiles, [:show]
    allow_actions :rankings, [:show]
    allow_actions :tips, [:edit_multiple, :update_multiple]

    #attributes
    allow_attributes :champion_tip, [:team_id]

  end
end