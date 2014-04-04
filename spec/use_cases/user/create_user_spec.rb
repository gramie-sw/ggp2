describe CreateUser do

  let(:tip_factory) { TipFactory }

  let(:user_attributes) do
    {
        nickname: 'Player',
        first_name: 'Hans',
        last_name: 'Mustermann',
        email: 'hans.mustermann@mail.com',
        admin: false
    }
  end

  let(:password_token) { 'password_token' }
  let(:raw_reset_password_token) { 'raw_reset_password_token'}
  let(:encrypted_reset_password_token) { 'encrypted_reset_password_token'}

  let(:tips) { [Tip.new] }
  let(:current_time) { Time.current }

  subject { CreateUser.new }

  before :each do
    Time.stub(:current).and_return(current_time)
    TokenFactory.stub(:password_token).and_return(password_token)
    TokenFactory.stub(:reset_password_tokens).and_return(TokenFactory::ResetPasswordTokens.new(
                                             raw_reset_password_token, encrypted_reset_password_token))
  end

  describe '#run' do

    context 'when user creation was successful' do

      it 'should return ResultWithToken with user and successful? with true and raw token set' do

        TipFactory.any_instance.should_receive(:build_all).and_return(tips)
        User.any_instance.should_receive(:save).and_return true

        result = subject.run user_attributes
        result.successful?.should be_true
        result.user.should be_an_instance_of User
        result.user.nickname.should eq user_attributes[:nickname]
        result.user.first_name.should eq user_attributes[:first_name]
        result.user.last_name.should eq user_attributes[:last_name]
        result.user.email.should eq user_attributes[:email]
        result.user.admin.should be_false
        result.user.active.should be_true
        result.user.password.should eq password_token
        result.user.password_confirmation.should eq password_token
        result.user.reset_password_token.should eq encrypted_reset_password_token
        result.user.reset_password_sent_at.should eq current_time
        result.user.tips.size.should eq 1
        result.user.champion_tip.should_not be_nil
        result.raw_token.should eq raw_reset_password_token
      end
    end

    context 'when user creation failed' do

      let(:user) { double 'User' }

      before :each do
        User.stub(:new).and_return(user)
        tip_factory.stub(:build_all)
        user.stub(:tips=)
        user.stub(:champion_tip=)
        user.stub(:save).and_return false
      end

      it 'should return ResultWithToken with user and successful? with false set and raw token set' do
        result = subject.run user_attributes
        result.successful?.should be_false
        result.user.should eq user
        result.raw_token.should eq raw_reset_password_token
      end
    end
  end
end