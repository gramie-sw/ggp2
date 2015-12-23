describe UpdateUserBadges do

  describe '#run' do

    let(:users) {
      [
        create(:player),
        create(:player),
        create(:player),
        create(:admin)
      ]
    }

    it 'updates user badges by given group' do

      create(:user_badge,
             user_id: users.first.id,
             badge_group_identifier: 'comment_consecutive_created_badge',
             badge_identifier: 'comment_consecutive_created_badge#bronze')

      untouched_user_badge = create(:user_badge,
                                    user_id: users.first.id,
                                    badge_group_identifier: 'tip_consecutive_badge#correct',
                                    badge_identifier: 'tip_consecutive_badge#correct#bronze')

      3.times { create(:comment, user: users.second) }
      create(:comment, user: users.third)
      create(:comment, user: users.second)
      create(:comment, user: users.third)

      UpdateUserBadges.run(group: :comment)

      expect(UserBadge.all.size).to eq 4

      
      user_badges_for_user_1 = UserBadgeQueries.all_by_user_id(users.first.id)
      expect(user_badges_for_user_1.size).to eq 1
      expect(user_badges_for_user_1.first).to eq untouched_user_badge

      user_badges_for_user_2 = UserBadgeQueries.all_by_user_id(users.second.id)
      expect(user_badges_for_user_2.size).to eq 2
      expect(user_badges_for_user_2.first.badge_identifier).to eq 'comment_created_badge#silver'
      expect(user_badges_for_user_2.second.badge_identifier).to eq 'comment_consecutive_created_badge#bronze'

      user_badges_for_user_3 = UserBadgeQueries.all_by_user_id(users.third.id)
      expect(user_badges_for_user_3.size).to eq 1
      expect(user_badges_for_user_3.first.badge_identifier).to eq 'comment_created_badge#bronze'
    end
  end
end