describe TokenFactory do

  describe '::password_token' do
    it 'should return token out of random values' do
      Devise.stub(:friendly_token).and_return('friendly_token_random_values')
      subject.password_token.should eq ('friendly_token_random_values')
    end
  end

  describe '::reset_password_tokens' do

    let(:token_generator) { double 'TokenGenerator'}

    it 'should return ResetPasswordTokens with raw and encrypted tokens' do
      Devise.should_receive(:token_generator).and_return(token_generator)
      token_generator.should_receive(:generate).with(User, :reset_password_token).and_return([:raw_token, :encrypted_token])

      reset_password_tokens = subject.reset_password_tokens
      reset_password_tokens.should be_a_kind_of Struct
      reset_password_tokens.raw_token.should eq :raw_token
      reset_password_tokens.encrypted_token.should eq :encrypted_token
    end
  end
end