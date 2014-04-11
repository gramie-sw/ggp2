describe UserRepository do

  subject { User }

  describe 'players_paginated' do

    it 'should return all users being players paginated' do
      create(:admin)
      expected_user_1 = create(:player)
      expected_user_2 = create(:player)
      create(:player)

      actual_users = subject.players_paginated(page: 1, per_page: 2)
      actual_users.count.should eq 2
      actual_users.should include expected_user_1, expected_user_2
    end
  end
end