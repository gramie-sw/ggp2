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

  describe '::all_by_user_id' do

    it 'should return user_badges filtered by user_id' do

      user_badge_1 = create(:user_badge, user_id: 1)
      create(:user_badge, user_id: 2)
      user_badge_2 = create(:user_badge, user_id: 1)

      actual_user_badges = subject.all_by_user_id(1)
      expect(actual_user_badges.size).to eq 2
      expect(actual_user_badges).to include(user_badge_1, user_badge_2)
    end
  end

  describe '::order_by_position' do

    it 'should return ordered user_badges by position asc' do

      expected_user_badge_2 = create(:user_badge, position: 2)
      expected_user_badge_3 = create(:user_badge, position: 3)
      expected_user_badge_1 = create(:user_badge, position: 1)

      actual_user_badges = UserBadge.order_by_position

      expect(actual_user_badges[0]).to eq expected_user_badge_1
      expect(actual_user_badges[1]).to eq expected_user_badge_2
      expect(actual_user_badges[2]).to eq expected_user_badge_3
    end
  end

  describe '::destroy_and_create_multiple' do

    let(:group) { 'comment' }

    let(:user_badges) {
      [
          build(:user_badge, group: group),
          build(:user_badge, group: group)
      ]
    }

    it 'should delete all user badges by given group and save given user badges' do

      create(:user_badge, group: group)

      subject.destroy_and_create_multiple group, user_badges

      actual_user_badges = UserBadge.all_by_group(group)
      expect(actual_user_badges.size).to eq 2
      expect(actual_user_badges).to include(user_badges.first, user_badges.second)
    end

    it 'should delete and save user badges transactionally' do

      expected_user_badge = create(:user_badge, group: group)
      user_badges.stub(:map).with(any_args).and_return([false])

      subject.destroy_and_create_multiple group, user_badges

      actual_user_badges = UserBadge.all_by_group(group)
      expect(actual_user_badges.size).to eq 1
      expect(actual_user_badges).to include(expected_user_badge)
    end
  end
end