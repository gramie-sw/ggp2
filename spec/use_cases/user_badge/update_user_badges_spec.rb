describe UpdateUserBadges do

  describe'#run' do

    it 'should update user badges by given group' do

      user_1 = create(:user)
      user_2 = create(:user)
      user_3 = create(:user)

      create(:user_badge, user_id: user_1.id, group: :comment)
      expected_user_badge = create(:user_badge, user_id: user_1.id, group: :tip)

      create(:comment, user: user_2)
      create(:comment, user: user_2)
      create(:comment, user: user_3)
      create(:comment, user: user_2)
      create(:comment, user: user_3)

      subject.run(:comment)

      expect(UserBadge.all_by_group(:comment).all_by_user_id(user_1.id).size).to eq 0
      actual_tip_user_badges = UserBadge.all_by_group(:tip).all_by_user_id(user_1.id)
      expect(actual_tip_user_badges.size).to eq 1
      expect(actual_tip_user_badges[0]).to eq expected_user_badge

      expect(UserBadge.all_by_group(:comment).size).to eq 3

      actual_user_badges = UserBadge.all_by_group(:comment).all_by_user_id(user_2.id).order_by_position
      expect(actual_user_badges.size).to eq 2
      expect(actual_user_badges[0].user_id).to eq user_2.id
      expect(actual_user_badges[0].position).to eq 1
      expect(actual_user_badges[0].icon).to eq 'special_icon'
      expect(actual_user_badges[1].user_id).to eq user_2.id
      expect(actual_user_badges[1].position).to eq 2
      expect(actual_user_badges[1].icon).to eq 'cool_icon'

      actual_user_badges = UserBadge.all_by_group(:comment).all_by_user_id(user_3.id).order_by_position
      expect(actual_user_badges.size).to eq 1
      expect(actual_user_badges[0].user_id).to eq user_3.id
      expect(actual_user_badges[0].position).to eq 2
      expect(actual_user_badges[0].icon).to eq 'cool_icon'
    end
  end
end