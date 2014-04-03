describe CreateUser do

  let(:user_attributes) do
    {
        nickname: 'Player',
        first_name: 'Hans',
        last_name: 'Mustermann',
        email: 'hans.mustermann@mail.com',
        admin: false
    }
  end

  describe '#run' do

    it 'should return ResultWithToken with user and successful? with true and raw token set' do
      match = create(:match)

      result = subject.run user_attributes

      result.successful?.should be_true
      result.user.should be_an_instance_of User
      result.user.nickname.should eq user_attributes[:nickname]
      result.user.first_name.should eq user_attributes[:first_name]
      result.user.last_name.should eq user_attributes[:last_name]
      result.user.email.should eq user_attributes[:email]
      result.user.admin.should be_false
      result.user.active.should be_true
      result.user.password.should_not be_nil
      result.user.password_confirmation.should_not be_nil
      result.user.reset_password_token.should_not be_nil
      result.user.reset_password_sent_at.should be > (Time.current - 1.minute)
      result.raw_token.should_not be_nil

      result.user.tips.size.should eq 1
      result.user.tips[0].match_id.should eq match.id
    end
  end
end