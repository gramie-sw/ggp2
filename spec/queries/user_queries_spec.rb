describe UserQueries do

  subject { UserQueries }

  describe 'all_players' do

    it 'should return all users who are not admins' do
      user_1 = create(:user)
      user_2 = create(:user)
      create(:admin)

      players = User.players
      expect(players.count).to be 2
      expect(players.include?(user_1)).to be_truthy
      expect(players.include?(user_2)).to be_truthy
    end
  end

  describe 'all_for_ranking' do

    it 'should return all users being players paginated' do
      create(:admin)
      expected_user_1 = create(:player)
      expected_user_2 = create(:player)
      create(:player)

      actual_users = subject.all_for_ranking(page: 1, per_page: 2)
      expect(actual_users.count).to eq 2
      expect(actual_users).to include expected_user_1, expected_user_2
    end
  end
end