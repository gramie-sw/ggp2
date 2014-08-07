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

      expect(result.successful?).to be_truthy
      expect(result.user).to be_an_instance_of User
      expect(result.user.nickname).to eq user_attributes[:nickname]
      expect(result.user.first_name).to eq user_attributes[:first_name]
      expect(result.user.last_name).to eq user_attributes[:last_name]
      expect(result.user.email).to eq user_attributes[:email]
      expect(result.user.admin).to be_falsey
      expect(result.user.active).to be_truthy
      expect(result.user.password).not_to be_nil
      expect(result.user.password_confirmation).not_to be_nil
      expect(result.user.reset_password_token).not_to be_nil
      expect(result.user.reset_password_sent_at).to be > (Time.current - 1.minute)
      expect(result.raw_token).not_to be_nil

      expect(result.user.tips.size).to eq 1
      expect(result.user.tips[0].match_id).to eq match.id
    end
  end
end