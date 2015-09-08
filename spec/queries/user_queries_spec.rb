describe UserQueries do

  subject { UserQueries }

  describe '::' do

    it 'returns player count' do
      User.create_unvalidated(email: 'mail1', admin: false)
      User.create_unvalidated(email: 'mail2', admin: true)
      User.create_unvalidated(email: 'mail3', admin: false)
      expect(subject.player_count).to be 2
    end
  end

  describe '::all_for_ranking_view' do

    let!(:users) do
      [
          create(:admin),
          create(:player),
          create(:player),
          create(:player)
      ]
    end

    it 'returns all users being players' do
      actual_users = subject.all_for_ranking_view
      expect(actual_users).to eq [users[1], users[2], users[3]]
    end

    it 'paginates result' do
      actual_users = subject.all_for_ranking_view(page: 1, per_page: 2)
      expect(actual_users).to eq [users[1], users[2]]
      expect(actual_users.count).to be 2
      expect(actual_users.current_page).to be 1
      expect(actual_users.total_count).to be 3
    end
  end
end