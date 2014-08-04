describe UserBadgeRepository do

  subject { UserBadge }

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

  describe '::all_by_badge_identifiers' do

    let(:user_badges) {
      [
          create(:user_badge, badge_identifier: 'identifier_1'),
          create(:user_badge, badge_identifier: 'identifier_2'),
          create(:user_badge, badge_identifier: 'identifier_3'),
          create(:user_badge, badge_identifier: 'identifier_3')
      ]
    }

    before :each do
      user_badges
    end

    it 'should return user_badges filtered by given badge_identifiers' do

      actual_user_badges = subject.all_by_badge_identifiers([user_badges.first.badge_identifier,
                                                             user_badges.third.badge_identifier])

      expect(actual_user_badges.size).to eq 3
      expect(actual_user_badges.first).to eq user_badges.first
      expect(actual_user_badges.second).to eq user_badges.third
      expect(actual_user_badges.third).to eq user_badges.fourth
    end
  end

  describe '::badges_by_user_id' do

    let(:user) { create(:user) }

    let(:user_badges) {
      [
          create(:user_badge, user: user, badge_identifier: 'tip_consecutive_badge_correct_gold'),
          create(:user_badge, badge_identifier: 'comment_created_badge_gold'),
          create(:user_badge, user: user, badge_identifier: 'comment_consecutive_created_badge_bronze')
      ]
    }

    before :each do
      user_badges
    end

    it 'should return all badges by given user_id' do

      actual_badges = subject.badges_by_user_id user.id
      expect(actual_badges.size).to eq 2
      expect(actual_badges.first.identifier).to eq 'comment_consecutive_created_badge_bronze'
      expect(actual_badges.second.identifier).to eq 'tip_consecutive_badge_correct_gold'
    end
  end

  describe '::destroy_and_create_multiple' do

    let(:user_badges) {
      [
          create(:user_badge, badge_identifier: 'tip_consecutive_badge_correct_gold'),
          create(:user_badge, badge_identifier: 'comment_created_badge_gold')
      ]
    }

    let(:new_user_badges) {
      [
          build(:user_badge, badge_identifier: 'tip_champion_missed_badge' ),
          build(:user_badge, badge_identifier: 'tip_missed_badge_gold')
      ]
    }

    before :each do
      user_badges
    end

    it 'should destroy all user badges by given group and save given new user badges' do

      subject.destroy_and_create_multiple :tip, new_user_badges

      actual_user_badges = UserBadge.all
      expect(actual_user_badges.size).to eq 3
      expect(actual_user_badges).to include(user_badges.second, new_user_badges.first, new_user_badges.second)
    end

    it 'should destroy and save user badges transactionally' do

      user_badges.stub(:map).with(any_args).and_return([false])

      subject.destroy_and_create_multiple :tip, user_badges

      actual_user_badges = UserBadge.all
      expect(actual_user_badges.size).to eq 2
      expect(actual_user_badges).to include(user_badges.first, user_badges.second)
    end
  end
end