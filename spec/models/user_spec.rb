describe User do

  it 'should have valid factory' do
    create(:user).should be_valid
  end

  describe 'associations' do
    it { should have_many(:tips).dependent(:destroy) }

    it 'tips should get user' do
      tip = Tip.new
      subject.tips << tip
      tip.user.should be subject
    end
  end

  describe 'scopes' do
    describe '#players' do
      it 'should return all users who are not admins' do
        user_1 = create(:user)
        user_2 = create(:user)
        create(:admin)

        players = User.players
        players.count.should be 2
        players.include?(user_1).should be_true
        players.include?(user_2).should be_true
      end
    end

    describe '#admins' do
      it 'should return all admins' do
        admin_1 = create(:admin)
        admin_2 = create(:admin)
        create(:user)

        admins = User.admins
        admins.count.should be 2
        admins.include?(admin_1).should be_true
        admins.include?(admin_2).should be_true
      end
    end

    describe 'order_by_nickname_asc' do

      it 'should order users by nickname' do
        user_3 = create(:user, nickname: 'user 3')
        user_1 = create(:user, nickname: 'user 1')
        user_2 = create(:user, nickname: 'user 2')

        actual_users = User.order_by_nickname_asc
        actual_users.first.should eq user_1
        actual_users.second.should eq user_2
        actual_users.third.should eq user_3
      end
    end
  end

  describe 'player?' do

    context 'if user is not an admin' do

      it 'should return true' do
        build(:user).should be_player
      end
    end

    context 'if user is an admin' do

      it 'should return false' do
        build(:admin).should_not be_player
      end
    end
  end

end
