describe ShowUsers do

  subject { ShowUsers.new }
  let(:presentable) { UsersIndexPresenter.new }

  let(:users) {
    [
      create(:admin, nickname: 'Admin 3'),
      create(:player, nickname: 'Player 3'),
      create(:admin, nickname: 'Admin 1'),
      create(:player, nickname: 'Player 1'),
      create(:admin, nickname: 'Admin 2'),
      create(:player, nickname: 'Player 2')
    ]
  }

  before(:each) do
    users
  end

  describe '#run_with_representable' do

    context 'when admin' do

      it 'should set on presentable users all admins and admin true' do

        subject.run_with_presentable(presentable: presentable, type: User::USER_TYPE_ADMINS, page: 1, per_page: 2)
        expect(presentable.admin).to be_truthy
        actual_users = presentable.users
        expect(actual_users.size).to eq 2
        expect(actual_users.first).to eq users[2]
        expect(actual_users.second).to eq users[4]
      end
    end

    context 'when not admin' do

      it 'should set on presentable users all players and admin false' do

        subject.run_with_presentable(presentable: presentable, type: User::USER_TYPE_PLAYERS, page: 1, per_page: 2)
        expect(presentable.admin).to be_falsey
        actual_users = presentable.users
        expect(actual_users.size).to eq 2
        expect(actual_users.first).to eq users[3]
        expect(actual_users.second).to eq users[5]
      end
    end
  end
end