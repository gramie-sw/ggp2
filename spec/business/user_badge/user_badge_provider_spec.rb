describe UserBadgeProvider do

  describe '::provide_by_badge' do

    let(:group) { 'group' }

    let(:badge) do
      CommentCreatedBadge.new(
          position: 1,
          icon: 'icon',
          icon_color: '#123456',
          count: 3
      )
    end

    it 'should return user_badges for given badge' do

      badge.stub(:eligible_user_ids).and_return([1,3])

      actual_user_badges = subject.provide_by_badge(badge, group)

      expect(actual_user_badges.size).to eq 2

      actual_user_badge_1 = actual_user_badges[0]
      expect(actual_user_badge_1).to be_an_instance_of(UserBadge)
      expect(actual_user_badge_1.user_id).to eq 1
      expect(actual_user_badge_1.position).to eq 1
      expect(actual_user_badge_1.icon).to eq 'icon'
      expect(actual_user_badge_1.icon_color).to eq '#123456'
      expect(actual_user_badge_1.group).to eq group

      actual_user_badge_2 = actual_user_badges[1]
      expect(actual_user_badge_2).to be_an_instance_of(UserBadge)
      expect(actual_user_badge_2.user_id).to eq 3
      expect(actual_user_badge_2.position).to eq 1
      expect(actual_user_badge_2.icon).to eq 'icon'
      expect(actual_user_badge_2.icon_color).to eq '#123456'
      expect(actual_user_badge_2.group).to eq group
    end
  end
end