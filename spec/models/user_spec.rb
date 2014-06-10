describe User do

  it 'should have valid factory' do
    create(:user).should be_valid
  end

  describe 'validations' do

    describe '#nickname' do
      it { should validate_presence_of(:nickname) }
      it { should validate_uniqueness_of(:nickname) }
      it { should ensure_length_of(:nickname).is_at_least(3).is_at_most(32) }
    end

    describe '#first_name' do
      it { should validate_presence_of(:first_name) }
      it { should ensure_length_of(:first_name).is_at_most(32) }
    end

    describe '#last_name' do
      it { should validate_presence_of(:last_name) }
      it { should ensure_length_of(:last_name).is_at_most(32) }
    end

    describe '#admin' do
      it { should allow_value(true, false).for(:admin) }
      it { should_not allow_value(nil).for(:admin) }
    end

    describe '#match_sort' do
      it { should ensure_inclusion_of(:match_sort).in_array(['matches.position', 'matches.date']).allow_nil }
    end
  end

  describe 'associations' do
    it { should have_many(:tips).dependent(:destroy) }
    it { should have_many(:ranking_items).dependent(:destroy) }
    it { should have_many(:comments).dependent(:destroy) }
    it { should have_one(:champion_tip).dependent(:destroy) }
    it { should have_many(:user_badges).dependent(:destroy) }

    it 'tips should get user' do
      tip = Tip.new
      subject.tips << tip
      tip.user.should be subject
    end

    it 'ranking_items should get user' do
      ranking_item = RankingItem.new
      subject.ranking_items << ranking_item
      ranking_item.user.should be subject
    end

    it 'champion_tip should get user' do
      champion_tip = ChampionTip.new
      subject.champion_tip = champion_tip
      champion_tip.user.should be subject
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

  describe '::find_player' do

    context 'if given id belongs to a player' do

      it 'should return player' do
        player = create(:player)
        User.find_player(player.id).should eq player
      end
    end

    context 'if given id belongs to a admin' do

      it 'should return nil' do
        admin = create(:admin)
        User.find_player(admin.id).should be_nil
      end
    end
  end

  describe '#player?' do

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

  describe '#full_name' do
    subject { build(:user, first_name: 'Moby', last_name: 'Dick') }

    it 'should return first and last name' do
      subject.full_name.should eq 'Moby Dick'
    end
  end

  describe '#badges_count' do

    it 'should return badges count' do
      relation = double('UserBadgesRelation', count: 5)
      expect(subject).to receive(:user_badges).and_return(relation)
      expect(subject.badges_count).to eq 5
    end
  end
end
