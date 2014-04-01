describe CreateUser do

  let(:user_attributes) { {} }

  describe '#create_with_password_token' do

    before :each do
      TokenFactory.stub(:reset_password_tokens).and_return(
          TokenFactory::ResetPasswordTokens.new('raw_token', 'encrypted_token'))

      TokenFactory.stub(:password_token).and_return('password_token')
    end

    let(:tip_factory) { double 'TipFactory' }
    let(:user_create_service) { double 'UserCreateService' }
    let(:result_with_token) { double 'ResultWithToken', user: User.new, successful?: false, raw_token: 'raw_token' }

    it 'should create UserCreateService with UserFactory and TipFactory and call create_with_reset_password_token on it' do

      TipFactory.should_receive(:new).with(match_repository: Match).and_return(tip_factory)

      UserCreateService.should_receive(:new).with(
          user_factory: UserFactory, tip_factory: tip_factory).and_return(user_create_service)

      user_create_service.should_receive(:create_with_reset_password_token).with(
          user_attributes, 'password_token', 'encrypted_token').and_return(result_with_token)

      subject.create_with_password_token user_attributes
    end

    it 'should return ResultWithToken' do
      result_with_token = subject.create_with_password_token user_attributes
      result_with_token.user.should be_an_instance_of User
      result_with_token.successful?.should be_false
      result_with_token.raw_token.should eq 'raw_token'
    end
  end
end