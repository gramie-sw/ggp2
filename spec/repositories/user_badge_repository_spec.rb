describe UserBadgeRepository do

  subject { UserBadge }

  describe '::all_by_group' do

    it 'should return user_badges filtered by group' do
      user_badge_1 = create(:user_badge, group: 'comment')
      create(:user_badge, group: 'tip')
      user_badge_2 = create(:user_badge, group: 'comment')

      actual_user_badges = subject.all_by_group('comment')
      expect(actual_user_badges.size).to eq 2
      expect(actual_user_badges).to include(user_badge_1, user_badge_2)
    end
  end
end