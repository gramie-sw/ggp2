describe FindUserBadges do

  let(:users) do
    [
        create(:player),
        create(:player)
    ]
  end

  let!(:user_badges) do
    [
        create(:user_badge, user_id: users.first.id, badge_group_identifier: 'tip_missed_badge',
               badge_identifier: 'tip_missed_badge#gold'),
        create(:user_badge, user_id: users.second.id, badge_group_identifier: 'comment_created_badge',
               badge_identifier: 'comment_created_badge#gold'),
        create(:user_badge, user_id: users.first.id, badge_group_identifier: 'tip_consecutive_badge#correct',
               badge_identifier: 'tip_consecutive_badge#correct#gold')
    ]
  end


  describe '#run' do

    it 'returns user badges by given user_id' do
      all_badges_hash = BadgeRepository.badges_hash

      actual_badges = FindUserBadges.run(user_id: users.first.id)
      expect(actual_badges.size).to eq 2
      expect(actual_badges.first).to eq all_badges_hash[user_badges.third.badge_identifier]
      expect(actual_badges.second).to eq all_badges_hash[user_badges.first.badge_identifier]
    end
  end
end