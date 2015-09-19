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
end