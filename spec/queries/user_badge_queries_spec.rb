describe UserBadgeQueries do

  describe '::badge_group_identifiers_distinct' do

    it 'returns all distinct badge_group_identifiers' do

      create(:user_badge, badge_group_identifier: 'badge_group_identifier_1')
      create(:user_badge, badge_group_identifier: 'badge_group_identifier_2')
      create(:user_badge, badge_group_identifier: 'badge_group_identifier_3')
      create(:user_badge, badge_group_identifier: 'badge_group_identifier_3')

      badge_group_identifiers = UserBadgeQueries.badge_group_identifiers_distinct

      expect(badge_group_identifiers.count).to be 3
      expect(badge_group_identifiers).to include 'badge_group_identifier_1', 'badge_group_identifier_2',
                                                 'badge_group_identifier_3'
    end
  end

  describe '::all_by_badge_group_identifiers' do

    it 'returns user_badges by given badge_group_identifiers' do

      user_badge_1 = create(:user_badge, badge_group_identifier: 'badge_group_identifier_1')
      user_badge_2 = create(:user_badge, badge_group_identifier: 'badge_group_identifier_2')
      create(:user_badge, badge_group_identifier: 'badge_group_identifier_3')

      badge_group_identifiers = ['badge_group_identifier_1', 'badge_group_identifier_2']

      badges = UserBadgeQueries.all_by_badge_group_identifiers badge_group_identifiers

      expect(badges.count).to be 2
      expect(badges).to include user_badge_1, user_badge_2
    end
  end

  describe '::destroy_and_create_multiple' do

    let!(:user_badges) {
      [
          create(:user_badge, badge_group_identifier: 'tip_missed_badge', badge_identifier: 'tip_missed_badge#bronze'),
          create(:user_badge, badge_group_identifier: 'tip_badge#incorrect', badge_identifier: 'tip_badge#incorrect#bronze'),
          create(:user_badge, badge_group_identifier: 'tip_consecutive_missed_badge',
                 badge_identifier: 'tip_consecutive_missed_badge#bronze'),
          create(:user_badge, badge_group_identifier: 'comment_created_badge',
                 badge_identifier: 'comment_created_badge#bronze')
      ]
    }

    let(:new_user_badges) {
      [
          build(:user_badge, badge_group_identifier: 'tip_badge#incorrect',
                badge_identifier: 'tip_badge#incorrect#silver'),
          build(:user_badge, badge_group_identifier: 'tip_consecutive_missed_badge',
                badge_identifier: 'tip_consecutive_missed_badge#silver')
      ]
    }

    it 'destroys all user_badges by given group and inserts given user_badges' do

      UserBadgeQueries.destroy_and_create_multiple :tip, new_user_badges

      actual_user_badges = UserBadge.all

      expect(actual_user_badges.count).to be 3
      expect(actual_user_badges).to include new_user_badges.first, new_user_badges.second, user_badges.last
    end

    it 'destroys and creates user_badges in transaction' do
      allow(new_user_badges).to receive(:map).with(any_args).and_return([false])

      UserBadgeQueries.destroy_and_create_multiple :tip, new_user_badges

      actual_user_badges = UserBadge.all
      expect(actual_user_badges.size).to eq 4
      expect(actual_user_badges).to eq user_badges
    end
  end
end