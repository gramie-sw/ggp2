describe UserBadgeProvider do

  let(:group) { 'group'}


  let(:badges) do
    [
      CommentCreatedBadge.new(
          position: 1,
          icon: 'icon',
          icon_color: '#123456',
          count: 3
      ),

      CommentCreatedBadge.new(
          position: 1,
          icon: 'icon',
          icon_color: '#123456',
          count: 5
      )
    ]
  end

  before :each do
    badges[0].stub(:eligible_user_ids).and_return([1,3])
    badges[1].stub(:eligible_user_ids).and_return([3])
  end


  describe '::provide_by_group' do

    it 'should return user_badges for given badges and group' do

      actual_user_badges = subject.provide_by_group badges, group

      expect(actual_user_badges.size).to eq 3

      actual_user_badge_1 = actual_user_badges[0]
      expect(actual_user_badge_1).to be_an_instance_of(UserBadge)
      expect(actual_user_badge_1.user_id).to eq 1
      expect(actual_user_badge_1.badge_identifier).to eq badges[0].identifier
      expect(actual_user_badge_1.position).to eq 1
      expect(actual_user_badge_1.icon).to eq 'icon'
      expect(actual_user_badge_1.icon_color).to eq '#123456'
      expect(actual_user_badge_1.group).to eq group

      actual_user_badge_2 = actual_user_badges[1]
      expect(actual_user_badge_2).to be_an_instance_of(UserBadge)
      expect(actual_user_badge_2.user_id).to eq 3
      expect(actual_user_badge_2.badge_identifier).to eq badges[0].identifier
      expect(actual_user_badge_2.position).to eq 1
      expect(actual_user_badge_2.icon).to eq 'icon'
      expect(actual_user_badge_2.icon_color).to eq '#123456'
      expect(actual_user_badge_2.group).to eq group

      actual_user_badge_3 = actual_user_badges[2]
      expect(actual_user_badge_3).to be_an_instance_of(UserBadge)
      expect(actual_user_badge_3.user_id).to eq 3
      expect(actual_user_badge_3.badge_identifier).to eq badges[1].identifier
      expect(actual_user_badge_3.position).to eq 1
      expect(actual_user_badge_3.icon).to eq 'icon'
      expect(actual_user_badge_3.icon_color).to eq '#123456'
      expect(actual_user_badge_3.group).to eq group
    end
  end

  describe '::provide_by_badge' do

    it 'should return user_badges for given badge and group ' do

      actual_user_badges = subject.provide_by_badge badges[0], group

      expect(actual_user_badges.size).to eq 2

      actual_user_badge_1 = actual_user_badges[0]
      expect(actual_user_badge_1).to be_an_instance_of(UserBadge)
      expect(actual_user_badge_1.user_id).to eq 1
      expect(actual_user_badge_1.badge_identifier).to eq badges[0].identifier
      expect(actual_user_badge_1.position).to eq 1
      expect(actual_user_badge_1.icon).to eq 'icon'
      expect(actual_user_badge_1.icon_color).to eq '#123456'
      expect(actual_user_badge_1.group).to eq group

      actual_user_badge_2 = actual_user_badges[1]
      expect(actual_user_badge_2).to be_an_instance_of(UserBadge)
      expect(actual_user_badge_2.user_id).to eq 3
      expect(actual_user_badge_1.badge_identifier).to eq badges[0].identifier
      expect(actual_user_badge_2.position).to eq 1
      expect(actual_user_badge_2.icon).to eq 'icon'
      expect(actual_user_badge_2.icon_color).to eq '#123456'
      expect(actual_user_badge_2.group).to eq group
    end
  end
end