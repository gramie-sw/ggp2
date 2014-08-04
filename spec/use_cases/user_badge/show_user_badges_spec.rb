describe ShowUserBadges do

  let(:users) do
    [
        create(:player),
        create(:player)
    ]
  end

  let(:user_badges) do
    [
        create(:user_badge, user_id: users.first.id, badge_identifier: 'tip_missed_badge_gold'),
        create(:user_badge, user_id: users.first.id, badge_identifier: 'comment_consecutive_created_badge_bronze'),
        create(:user_badge, user_id: users.second.id, badge_identifier: 'comment_created_badge_gold'),
        create(:user_badge, user_id: users.first.id, badge_identifier: 'tip_consecutive_badge_correct_gold')
    ]
  end

  let(:presenter) { double('presenter') }

  before :each do
    user_badges
  end

  describe '#run' do

    it 'should set ordered badges by user on presenter' do

      expect(presenter).to receive(:user).and_return(users.first)

      expect(presenter).to receive(:badges=) do |badges|
        expect(badges.size).to eq 3
        expect(badges.first.identifier).to eq user_badges.second.badge_identifier
        expect(badges.second.identifier).to eq user_badges.first.badge_identifier
        expect(badges.third.identifier).to eq user_badges.fourth.badge_identifier
      end

      subject.run presenter
    end
  end
end