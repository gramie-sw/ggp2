describe UserCreateService do

  let(:user_factory) { UserFactory }
  let(:tip_factory) { TipFactory }
  subject { UserCreateService.new user_factory: user_factory, tip_factory: tip_factory }

  let(:user_attributes) {{}}
  let(:password_token) { 'password_token'}
  let(:reset_password_token) { 'reset_password_token'}

  let(:user) { User.new }
  let(:tips) { [Tip.new] }

  describe '#create_with_reset_password_token' do
    context 'when user creation was successful' do
      it 'should return Result with user and successful? with true set' do

        Time.zone.stub(:now).and_return('current_time')
        subject.should_receive(:set_additional_user_attributes).with(user_attributes, password_token, reset_password_token, 'current_time')
        user_factory.should_receive(:build).with(user_attributes).and_return(user)
        tip_factory.should_receive(:build_all).and_return(tips)
        user.should_receive(:tips=).with(tips)
        user.should_receive(:save).and_return user

        result = subject.create_with_reset_password_token user_attributes, password_token, reset_password_token
        result.successful?.should be_true
        result.user.should eq user
      end
    end

    context 'when user creation failed' do

      before :each do
        user_factory.stub(:build).with(user_attributes).and_return(user)
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

  describe '#set_additional_user_attributes' do

    let(:current_time) { Time.zone.now }

    it 'should set additional values on user_attributes' do
      user_attributes = {}
      subject.set_additional_user_attributes user_attributes, password_token, reset_password_token, current_time

      user_attributes[:active].should be_true
      user_attributes[:password].should eq password_token
      user_attributes[:password_confirmation].should eq password_token
      user_attributes[:reset_password_token].should eq reset_password_token
      user_attributes[:reset_password_sent_at].should eq current_time
    end
  end
end