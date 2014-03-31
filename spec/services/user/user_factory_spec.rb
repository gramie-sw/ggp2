describe UserFactory do

  let(:user_attributes) do
    {
        nickname: 'Player',
        first_name: 'Hans',
        last_name: 'Mustermann',
        email: 'hans.mustermann@mail.com',
        password: '12345678',
        password_confirmation: '12345678',
        admin: false
    }
  end

  subject { UserFactory.new }

  describe'#build' do
    it 'should return user with set user_attributes' do
      actual_user = subject.build user_attributes
      actual_user.nickname.should eq 'Player'
      actual_user.first_name.should eq 'Hans'
      actual_user.last_name.should eq 'Mustermann'
      actual_user.email.should eq 'hans.mustermann@mail.com'
      actual_user.admin.should be_false
    end
  end
end