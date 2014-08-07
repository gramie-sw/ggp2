describe UserRepository do

  subject { User }

  describe 'order_by_nickname_asc' do

    it 'should return users ordered by nickname asc' do

      expected_user_2 = create(:player, nickname: 'Bob')
      expected_user_3 = create(:player, nickname: 'Cesar')
      expected_user_1 = create(:player, nickname: 'Anton')

      actual_users = subject.order_by_nickname_asc

      expect(actual_users.first).to eq expected_user_1
      expect(actual_users.second).to eq expected_user_2
      expect(actual_users.third).to eq expected_user_3
    end
  end

  describe 'players_for_ranking_listing' do

    it 'should return all users being players paginated' do

      create(:admin)
      expected_user_1 = create(:player)
      expected_user_2 = create(:player)
      create(:player)

      actual_users = subject.players_for_ranking_listing(page: 1, per_page: 2)
      expect(actual_users.count).to eq 2
      expect(actual_users).to include expected_user_1, expected_user_2
    end

    it 'should includes champion_tip and team' do

      relation = double('UserRelation')
      relation.as_null_object

      expect(subject).to receive(:players).and_return(relation)
      expect(relation).to receive(:includes).with(champion_tip: :team)

      subject.players_for_ranking_listing(page: nil, per_page: nil)
    end
  end

  describe 'users_listing' do

    context 'when admins' do

      it 'should return all users being admins paginated' do

        create(:admin)
        expected_user_1 = create(:player)
        expected_user_2 = create(:player)
        create(:player)

        actual_users = subject.users_listing(admin: false, page: 1, per_page: 2)
        expect(actual_users.count).to eq 2
        expect(actual_users).to include expected_user_1, expected_user_2
      end
    end

    context 'when players' do

      it 'should return all users being players paginated' do

        create(:player)
        expected_user_1 = create(:admin)
        expected_user_2 = create(:admin)
        create(:admin)

        actual_users = subject.users_listing(admin: true, page: 1, per_page: 2)
        expect(actual_users.count).to eq 2
        expect(actual_users).to include expected_user_1, expected_user_2
      end
    end
  end
end