describe GuestPermissions do

  subject { PermissionService.new(nil) }

  it 'should exactly allow controllers' do

    should exactly_allow_actions(
               ['devise/sessions', [:new, :create, :destroy]],
               ['devise/passwords', [:new, :create, :edit, :update]],
               ['adapted_devise/registrations', [:new, :create]]
           )
  end

  it 'should exactly allow attributes' do

    should exactly_allow_attributes(
        [:user, [:email, :nickname, :first_name, :last_name]]
           )

  end
end