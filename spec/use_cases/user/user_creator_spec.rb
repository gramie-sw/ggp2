describe UserCreator do

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
  let(:reset_password_token) { 'reset_password_token' }
  let(:tips) { [Tip.new] }
  let(:current_time) { Time.current }

  subject { UserCreator.new tip_factory }

  before :each do
    Time.stub(:current).and_return(current_time)
  end

  describe '#create_with_reset_password_token' do

    context 'when user creation was successful' do

      it 'should return Result with user and successful? with true set' do

        tip_factory.should_receive(:build_all).and_return(tips)
        User.any_instance.should_receive(:save).and_return true

        result = subject.create_with_reset_password_token user_attributes, password_token, reset_password_token
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
        result.user.reset_password_token.should eq reset_password_token
        result.user.reset_password_sent_at.should eq current_time
      end
    end

    context 'when user creation failed' do

      let(:user) { double 'User' }

      before :each do
        User.stub(:new).and_return(user)
        tip_factory.stub(:build_all)
        user.stub(:tips=)
        user.stub(:save).and_return false
      end

      it 'should return Result with user and successful? with false set' do
        result = subject.create_with_reset_password_token user_attributes, password_token, reset_password_token
        result.successful?.should be_false
        result.user.should eq user
      end
    end
  end
end