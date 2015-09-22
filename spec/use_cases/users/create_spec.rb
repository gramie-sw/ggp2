describe Users::Create do
  
  subject { Users::Create }

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

  before :each do
    allow(Time).to receive(:current).and_return(current_time)
    allow(TokenFactory).to receive(:password_token).and_return(password_token)
    allow(TokenFactory).to receive(:reset_password_tokens).and_return(TokenFactory::ResetPasswordTokens.new(
                                             raw_reset_password_token, encrypted_reset_password_token))
  end

  describe '#run' do

    context 'when user creation was successful' do

      before :each do
        allow_any_instance_of(User).to receive(:valid?).and_return true
      end

      it 'returns ResultWithToken with created user and raw token' do

        expect_any_instance_of(TipFactory).to receive(:build_all).and_return(tips)
        expect_any_instance_of(User).to receive(:update).with({reset_password_token: encrypted_reset_password_token,
                                                              reset_password_sent_at: current_time}).and_return true

        result = subject.run(user_attributes: user_attributes)
        expect(result.user).to be_an_instance_of User
        expect(result.user).to be_persisted
        expect(result.user.nickname).to eq user_attributes[:nickname]
        expect(result.user.admin).to be false
        expect(result.user.active).to be true
        expect(result.user.password).to eq password_token
        expect(result.user.password_confirmation).to eq password_token
        expect(result.user.tips.size).to eq 1
        expect(result.user.champion_tip).to be_present
        expect(result.user.match_sort).to eq 'matches.position'
        expect(result.raw_token).to eq raw_reset_password_token
      end

      context 'when user_attributes contains admin = true' do

        it 'creates admin user' do
          result = subject.run(user_attributes: user_attributes.merge(admin: true))
          expect(result.user.admin).to be true
        end
      end
    end

    context 'when user creation failed' do

      before :each do
        expect_any_instance_of(User).to receive(:valid?).and_return false
      end

      it 'should return ResultWithToken with user and successful? with false set and raw token set' do
        result = subject.run(user_attributes: user_attributes)
        expect(result.user).to be_an_instance_of User
        expect(result.user.nickname).to eq user_attributes[:nickname]
        expect(result.raw_token).to eq raw_reset_password_token
      end
    end
  end
end