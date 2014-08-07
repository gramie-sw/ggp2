describe GuestPermissions do

  subject { PermissionService.new(nil) }

  it 'should exactly allow controllers' do

    is_expected.to exactly_allow_actions(
               ['devise/sessions', [:new, :create]],
               ['devise/passwords', [:new, :create, :edit, :update]],
               ['adapted_devise/registrations', [:new, :create]]
           )
  end

  it 'should exactly allow attributes' do

    is_expected.to exactly_allow_attributes(
        [:user, [:email, :nickname, :first_name, :last_name, :password, :password_confirmation, :reset_password_token]]
           )

  end
end