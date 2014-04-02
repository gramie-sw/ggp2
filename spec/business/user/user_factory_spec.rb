describe UserFactory do

  let(:current_time) { Time.zone.now }

  let(:user_attributes) do
    {
        nickname: 'Player',
        first_name: 'Hans',
        last_name: 'Mustermann',
        email: 'hans.mustermann@mail.com',
        password: '12345678',
        password_confirmation: '12345678',
        active: true,
        reset_password_token: '987654321',
        reset_password_sent_at: current_time,
        admin: false
    }
  end

  describe'#build' do
    it 'should return user with set user_attributes' do
      actual_user = subject.build user_attributes
      actual_user.nickname.should eq 'Player'
      actual_user.first_name.should eq 'Hans'
      actual_user.last_name.should eq 'Mustermann'
      actual_user.email.should eq 'hans.mustermann@mail.com'
      actual_user.password.should eq '12345678'
      actual_user.password_confirmation.should eq '12345678'
      actual_user.active.should be_true
      actual_user.reset_password_token.should eq '987654321'
      actual_user.reset_password_sent_at.should eq current_time
      actual_user.admin.should be_false
    end
  end
end