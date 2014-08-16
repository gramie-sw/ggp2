describe UpdateUserBadges do

  subject { UpdateUserBadges.new(:comment)}

  describe'#run' do

    it 'should update user badges by given group' do

      user_1 = create(:user)
      user_2 = create(:user)
      user_3 = create(:user)

      create(:user_badge, user_id: user_1.id, badge_identifier: 'comment_consecutive_created_badge_bronze' )
      expected_user_badge = create(:user_badge, user_id: user_1.id, badge_identifier: 'tip_consecutive_badge_correct_gold')

      create(:comment, user: user_2)
      create(:comment, user: user_2)
      create(:comment, user: user_3)
      create(:comment, user: user_2)
      create(:comment, user: user_3)

      subject.run

      expect(UserBadge.all.size).to eq 4

      user_badges_for_user_1 = UserBadge.all_by_user_id(user_1.id)
      expect(user_badges_for_user_1.size).to eq 1
      expect(user_badges_for_user_1.first).to eq expected_user_badge

      user_badges_for_user_2 = UserBadge.all_by_user_id(user_2.id)
      expect(user_badges_for_user_2.size).to eq 2
      expect(user_badges_for_user_2.first.badge_identifier).to eq 'comment_created_badge_gold'
      expect(user_badges_for_user_2.second.badge_identifier).to eq 'comment_consecutive_created_badge_bronze'

      user_badges_for_user_3 = UserBadge.all_by_user_id(user_3.id)
      expect(user_badges_for_user_3.size).to eq 1
      expect(user_badges_for_user_3.first.badge_identifier).to eq 'comment_created_badge_gold'
    end
  end
end