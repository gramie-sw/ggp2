describe PlayerPermissions do

  let(:current_user) { create(:user) }
  subject { PermissionService.new(current_user) }
  # let(:permission_service) { subject }

  it 'should exactly allow controllers' do

    should exactly_allow_actions(
               ['devise/sessions', [:new, :create, :destroy]],
               ['devise/passwords', [:new, :create, :edit, :update]],
               ['adapted_devise/registrations', [:new, :create, :edit, :update]],
               [:award_ceremonies, [:show]], 
               [:champion_tips, [:edit, :update]],
               [:comments, [:new, :create, :edit, :update]],
               [:match_tips, [:show]],
               [:match_results, [:new, :create]],
               [:pin_boards, [:show]],
               [:profiles, [:show]],
               [:rankings, [:show]],
               [:tips, [:edit_multiple, :update_multiple]],
               [:user_tips, [:show]]
           )
  end

  # it 'should exactly allow attributes' do
  #
  #   should exactly_allow_attributes(
  #              [:champion_tip, [:team_id]]
  #          )
  # end

end