describe CreateUser do

  let(:tip_factory) { TipFactory }

  let(:user_attributes) do
    {
        nickname: 'Player',
        first_name: 'Hans',
        last_name: 'Mustermann',
        email: 'hans.mustermann@mail.com'
    }
  end

  let(:password_token) { 'password_token' }
  let(:raw_reset_password_token) { 'raw_reset_password_token'}
  let(:encrypted_reset_password_token) { 'encrypted_reset_password_token'}

  let(:tips) { [Tip.new] }
  let(:current_time) { Time.current }

  subject { CreateUser.new }

  before :each do
    allow(Time).to receive(:current).and_return(current_time)
    allow(TokenFactory).to receive(:password_token).and_return(password_token)
    allow(TokenFactory).to receive(:reset_password_tokens).and_return(TokenFactory::ResetPasswordTokens.new(
                                             raw_reset_password_token, encrypted_reset_password_token))
  end

  describe '#run' do

    context 'when user creation was successful' do

      it 'should return ResultWithToken with user and successful? with true and raw token set' do

        expect_any_instance_of(TipFactory).to receive(:build_all).and_return(tips)
        expect_any_instance_of(User).to receive(:save).and_return true
        expect_any_instance_of(User).to receive(:update).with({reset_password_token: encrypted_reset_password_token,
                                                              reset_password_sent_at: current_time}).and_return true

        result = subject.run user_attributes
        expect(result.successful?).to be_truthy
        expect(result.user).to be_an_instance_of User
        expect(result.user.nickname).to eq user_attributes[:nickname]
        expect(result.user.first_name).to eq user_attributes[:first_name]
        expect(result.user.last_name).to eq user_attributes[:last_name]
        expect(result.user.email).to eq user_attributes[:email]
        expect(result.user.admin).to be_falsey
        expect(result.user.active).to be_truthy
        expect(result.user.password).to eq password_token
        expect(result.user.password_confirmation).to eq password_token
        expect(result.user.tips.size).to eq 1
        expect(result.user.champion_tip).not_to be_nil
        expect(result.raw_token).to eq raw_reset_password_token
      end
    end

    context 'when user creation failed' do

      let(:user) { double 'User' }

      before :each do
        allow(User).to receive(:new).and_return(user)
        allow(tip_factory).to receive(:build_all)
        allow(user).to receive(:tips=)
        allow(user).to receive(:champion_tip=)
        allow(user).to receive(:save).and_return false
      end

      it 'should return ResultWithToken with user and successful? with false set and raw token set' do
        result = subject.run user_attributes
        expect(result.successful?).to be_falsey
        expect(result.user).to eq user
        expect(result.raw_token).to eq raw_reset_password_token
      end
    end
  end
end