describe PlayerPermissions do

  let(:current_user) { create(:user) }
  subject { PermissionService.new(current_user) }

  it 'should exactly allow controllers' do

    should exactly_allow_actions(
               ['devise/sessions', [:new, :create, :destroy]],
               ['adapted_devise/registrations', [:edit, :update]],
               [:award_ceremonies, [:show]],
               [:champion_tips, [:edit, :update]],
               [:comments, [:new, :create, :edit, :update]],
               [:match_tips, [:show]],
               [:match_results, [:new, :create]],
               [:pin_boards, [:show]],
               [:profiles, [:show]],
               [:rankings, [:show]],
               [:roots, [:show]],
               [:tips, [:edit_multiple, :update_multiple]],
               [:user_tips, [:show]]
           )
  end


  it 'should exactly allow attributes' do

    should exactly_allow_attributes(
               [:user, [:email, :nickname, :first_name, :last_name, :current_password, :password, :password_confirmation, :remember_me]],
               [:champion_tip, [:team_id]],
               [:comment, [:user_id, :content]]
           )
  end
end