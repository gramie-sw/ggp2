describe FindUserBadges do

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

  subject { FindUserBadges.new users.first.id }

  before :each do
    user_badges
  end

  describe '#run' do

    it 'should return ordered badges by given user_id' do

      actual_badges = subject.run

      expect(actual_badges.size).to eq 3
      expect(actual_badges.first.identifier).to eq user_badges.second.badge_identifier
      expect(actual_badges.second.identifier).to eq user_badges.first.badge_identifier
      expect(actual_badges.third.identifier).to eq user_badges.fourth.badge_identifier
    end
  end
end