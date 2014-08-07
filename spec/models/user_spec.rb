describe User, :type => :model do

  it 'should have valid factory' do
    expect(create(:user)).to be_valid
  end

  describe 'validations' do

    describe '#nickname' do
      it { is_expected.to validate_presence_of(:nickname) }
      it { is_expected.to validate_uniqueness_of(:nickname) }
      it { is_expected.to ensure_length_of(:nickname).is_at_least(3).is_at_most(32) }
    end

    describe '#first_name' do
      it { is_expected.to validate_presence_of(:first_name) }
      it { is_expected.to ensure_length_of(:first_name).is_at_most(32) }
    end

    describe '#last_name' do
      it { is_expected.to validate_presence_of(:last_name) }
      it { is_expected.to ensure_length_of(:last_name).is_at_most(32) }
    end

    describe '#admin' do
      it { is_expected.to allow_value(true, false).for(:admin) }
      it { is_expected.not_to allow_value(nil).for(:admin) }
    end

    describe '#match_sort' do
      it { is_expected.to ensure_inclusion_of(:match_sort).in_array(['matches.position', 'matches.date']).allow_nil }
    end
  end

  describe 'associations' do
    it { is_expected.to have_many(:tips).dependent(:destroy) }
    it { is_expected.to have_many(:ranking_items).dependent(:destroy) }
    it { is_expected.to have_many(:comments).dependent(:destroy) }
    it { is_expected.to have_one(:champion_tip).dependent(:destroy) }
    it { is_expected.to have_many(:user_badges).dependent(:destroy) }

    it 'tips should get user' do
      tip = Tip.new
      subject.tips << tip
      expect(tip.user).to be subject
    end

    it 'ranking_items should get user' do
      ranking_item = RankingItem.new
      subject.ranking_items << ranking_item
      expect(ranking_item.user).to be subject
    end

    it 'champion_tip should get user' do
      champion_tip = ChampionTip.new
      subject.champion_tip = champion_tip
      expect(champion_tip.user).to be subject
    end
  end

  describe 'scopes' do
    describe '#players' do
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

    describe '#admins' do
      it 'should return all admins' do
        admin_1 = create(:admin)
        admin_2 = create(:admin)
        create(:user)

        admins = User.admins
        expect(admins.count).to be 2
        expect(admins.include?(admin_1)).to be_truthy
        expect(admins.include?(admin_2)).to be_truthy
      end
    end
  end

  describe '::find_player' do

    context 'if given id belongs to a player' do

      it 'should return player' do
        player = create(:player)
        expect(User.find_player(player.id)).to eq player
      end
    end

    context 'if given id belongs to a admin' do

      it 'should return nil' do
        admin = create(:admin)
        expect(User.find_player(admin.id)).to be_nil
      end
    end
  end

  describe '#player?' do

    context 'if user is not an admin' do

      it 'should return true' do
        expect(build(:user)).to be_player
      end
    end

    context 'if user is an admin' do

      it 'should return false' do
        expect(build(:admin)).not_to be_player
      end
    end
  end

  describe '#full_name' do
    subject { build(:user, first_name: 'Moby', last_name: 'Dick') }

    it 'should return first and last name' do
      expect(subject.full_name).to eq 'Moby Dick'
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
