describe TokenFactory do

  describe '::password_token' do
    it 'should return token out of random values' do
      allow(Devise).to receive(:friendly_token).and_return('friendly_token_random_values')
      expect(subject.password_token).to eq ('friendly_token_random_values')
    end
  end

  describe '::reset_password_tokens' do

    let(:token_generator) { double 'TokenGenerator'}

    it 'should return ResetPasswordTokens with raw and encrypted tokens' do
      expect(Devise).to receive(:token_generator).and_return(token_generator)
      expect(token_generator).to receive(:generate).with(User, :reset_password_token).and_return([:raw_token, :encrypted_token])

      reset_password_tokens = subject.reset_password_tokens
      expect(reset_password_tokens).to be_a_kind_of Struct
      expect(reset_password_tokens.raw_token).to eq :raw_token
      expect(reset_password_tokens.encrypted_token).to eq :encrypted_token
    end
  end
end