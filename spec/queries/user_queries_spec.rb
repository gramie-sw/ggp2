describe UserQueries do

  subject { UserQueries }

  describe '::players_ordered_by_nickname_asc_for_a_match_paginated' do

    let(:match) { create(:match)}

    let!(:players) do
      [
          create(:player, nickname: 'Bob', tips: [create(:tip, match_id: match.id)]),
          create(:player, nickname: 'Cesar', tips: [create(:tip, match_id: match.id)]),
          create(:player, nickname: 'Anton', tips: [create(:tip, match_id: match.id)])
      ]
    end

    it 'returns players ordered by nickname asc with given match paginated' do
      actual_users = UserQueries.players_ordered_by_nickname_asc_for_a_match_paginated(match_id: match.id,
      page: 2, per_page: 2)

      expect(actual_users.size).to be 1
      expect(actual_users.first.nickname).to eq 'Cesar'
    end
  end

  describe '::paginated_by_type' do

    let!(:users) do
      [
          User.create_unvalidated(email: 'mail3', admin: false),
          User.create_unvalidated(email: 'mail2', admin: true),
          User.create_unvalidated(email: 'mail1', admin: false),
          User.create_unvalidated(email: 'mail4', admin: true),
          User.create_unvalidated(email: 'mail5', admin: false)
      ]
    end

    it 'returns all players if no type given' do
      expect(subject.paginated_by_type).to eq [users[0], users[2], users[4]]
    end

    it 'returns all players if type player is given' do
      expect(subject.paginated_by_type(type: User::TYPES[:player])).to eq [users[0], users[2], users[4]]
    end

    it 'returns all admins if type admin is given' do
      expect(subject.paginated_by_type(type: User::TYPES[:admin])).to eq [users[1], users[3]]
    end

    it 'sorts player by order value if order parameter is given' do
      expect(subject.paginated_by_type(type: User::TYPES[:player], order: :email)).
          to eq [users[2], users[0], users[4]]
    end

    it 'paginates result if pagination parameters are given' do
      actual_users = subject.paginated_by_type(type: User::TYPES[:player], page: 2, per_page: 2)
      expect(actual_users).to eq [users[4]]
      expect(actual_users.count).to be 1
      expect(actual_users.current_page).to be 2
      expect(actual_users.total_count).to be 3
    end
  end


  describe '::paginated_for_ranking_view' do

    let!(:users) do
      [
          create(:admin),
          create(:player),
          create(:player),
          create(:player)
      ]
    end

    it 'returns all users being players' do
      actual_users = subject.paginated_for_ranking_view
      expect(actual_users).to eq [users[1], users[2], users[3]]
    end

    it 'paginates result' do
      actual_users = subject.paginated_for_ranking_view(page: 1, per_page: 2)
      expect(actual_users).to eq [users[1], users[2]]
      expect(actual_users.count).to be 2
      expect(actual_users.current_page).to be 1
      expect(actual_users.total_count).to be 3
    end
  end

  describe '::player_count' do

    it 'returns player count' do
      User.create_unvalidated(email: 'mail1', admin: false)
      User.create_unvalidated(email: 'mail2', admin: true)
      User.create_unvalidated(email: 'mail3', admin: false)
      expect(subject.player_count).to be 2
    end
  end

  describe '::all_player_ids' do

    let!(:users) do
      [
          create(:admin),
          create(:player),
          create(:player),
          create(:player)
      ]
    end

    it 'returns all player ids' do

      player_ids = subject.all_player_ids

      expect(player_ids.count).to be 3
      expect(player_ids).to include users.second.id, users.third.id, users.fourth.id
    end
  end
end