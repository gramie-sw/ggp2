describe UserQueries do

  subject { UserQueries }


  describe '::all_by_type_ordered' do

    let!(:users) do
      [
          User.create_unvalidated(email: 'mail3', admin: false),
          User.create_unvalidated(email: 'mail2', admin: true),
          User.create_unvalidated(email: 'mail1', admin: false),
          User.create_unvalidated(email: 'mail4', admin: true),
          User.create_unvalidated(email: 'mail5', admin: false)
      ]
    end

    describe 'if no type given' do

      it 'returns all players' do
        expect(subject.all_by_type_ordered).to eq [users[0], users[2], users[4]]
      end
    end

    describe 'if type player is given' do

      it 'returns all players' do
        expect(subject.all_by_type_ordered(type: User::TYPES[:player])).to eq [users[0], users[2], users[4]]
      end
    end

    describe 'if type admin is given' do

      it 'returns all admins' do
        expect(subject.all_by_type_ordered(type: User::TYPES[:admin])).to eq [users[1], users[3]]
      end
    end

    describe 'if order parameter is given' do

      it 'sorts player by order value' do
        expect(subject.all_by_type_ordered(type: User::TYPES[:player], order: :email)).
            to eq [users[2], users[0], users[4]]
      end
    end

    describe 'if pagination parameters are given' do

      it 'paginates result' do
        actual_users = subject.all_by_type_ordered(type: User::TYPES[:player], page: 2, per_page: 2)
        expect(actual_users).to eq [users[4]]
        expect(actual_users.count).to be 1
        expect(actual_users.current_page).to be 2
        expect(actual_users.total_count).to be 3
      end
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

  describe '::player_count' do

    it 'returns player count' do
      User.create_unvalidated(email: 'mail1', admin: false)
      User.create_unvalidated(email: 'mail2', admin: true)
      User.create_unvalidated(email: 'mail3', admin: false)
      expect(subject.player_count).to be 2
    end
  end
end