describe UserBadgeProvider do

  let(:group_identifiers_grouped_badges) do
    BadgeRepository.group_identifiers_grouped_badges :tip
  end

  describe '::provide' do

    it 'returns user_badges for given user_ids and group_identifiers_grouped_badges' do

      user_ids = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

      allow(group_identifiers_grouped_badges.first.first).to receive(:eligible_user_ids).with(user_ids).and_return([])

      allow(group_identifiers_grouped_badges.second.first).to receive(:eligible_user_ids).with(user_ids).
          and_return([1, 3, 4, 5, 7, 9, 10])
      allow(group_identifiers_grouped_badges.second.second).to receive(:eligible_user_ids).with([1, 3, 4, 5, 7, 9, 10]).
          and_return([3, 7, 9, 10])
      allow(group_identifiers_grouped_badges.second.third).to receive(:eligible_user_ids).with([3, 7, 9, 10]).
          and_return([7, 10])
      allow(group_identifiers_grouped_badges.second.third).to receive(:eligible_user_ids).with([3, 7, 9, 10]).
          and_return([7, 10])
      allow(group_identifiers_grouped_badges.third.first).to receive(:eligible_user_ids).with(user_ids).and_return([5])
      allow(group_identifiers_grouped_badges.third.second).to receive(:eligible_user_ids).with([5]).and_return([])
      allow(group_identifiers_grouped_badges.fourth.first).to receive(:eligible_user_ids).with(user_ids).and_return([])
      allow(group_identifiers_grouped_badges.fifth.first).to receive(:eligible_user_ids).with(user_ids).and_return([1,10])

      actual_user_badges = UserBadgeProvider.new.provide(user_ids, group_identifiers_grouped_badges)

      expect(actual_user_badges.size).to be 10

      expect(actual_user_badges[0].user_id).to eq 1
      expect(actual_user_badges[0].badge_group_identifier).to eq 'tip_badge#incorrect'
      expect(actual_user_badges[0].badge_identifier).to eq 'tip_badge#incorrect#bronze'

      expect(actual_user_badges[1].user_id).to eq 4
      expect(actual_user_badges[1].badge_group_identifier).to eq 'tip_badge#incorrect'
      expect(actual_user_badges[1].badge_identifier).to eq 'tip_badge#incorrect#bronze'

      expect(actual_user_badges[2].user_id).to eq 5
      expect(actual_user_badges[2].badge_group_identifier).to eq 'tip_badge#incorrect'
      expect(actual_user_badges[2].badge_identifier).to eq 'tip_badge#incorrect#bronze'

      expect(actual_user_badges[3].user_id).to eq 3
      expect(actual_user_badges[3].badge_group_identifier).to eq 'tip_badge#incorrect'
      expect(actual_user_badges[3].badge_identifier).to eq 'tip_badge#incorrect#silver'

      expect(actual_user_badges[4].user_id).to eq 9
      expect(actual_user_badges[4].badge_group_identifier).to eq 'tip_badge#incorrect'
      expect(actual_user_badges[4].badge_identifier).to eq 'tip_badge#incorrect#silver'

      expect(actual_user_badges[5].user_id).to eq 7
      expect(actual_user_badges[5].badge_group_identifier).to eq 'tip_badge#incorrect'
      expect(actual_user_badges[5].badge_identifier).to eq 'tip_badge#incorrect#gold'

      expect(actual_user_badges[6].user_id).to eq 10
      expect(actual_user_badges[6].badge_group_identifier).to eq 'tip_badge#incorrect'
      expect(actual_user_badges[6].badge_identifier).to eq 'tip_badge#incorrect#gold'

      expect(actual_user_badges[7].user_id).to eq 5
      expect(actual_user_badges[7].badge_group_identifier).to eq 'tip_consecutive_badge#correct'
      expect(actual_user_badges[7].badge_identifier).to eq 'tip_consecutive_badge#correct#bronze'

      expect(actual_user_badges[8].user_id).to eq 1
      expect(actual_user_badges[8].badge_group_identifier).to eq 'tip_champion_missed_badge'
      expect(actual_user_badges[8].badge_identifier).to eq 'tip_champion_missed_badge#platinum'

      expect(actual_user_badges[9].user_id).to eq 10
      expect(actual_user_badges[9].badge_group_identifier).to eq 'tip_champion_missed_badge'
      expect(actual_user_badges[9].badge_identifier).to eq 'tip_champion_missed_badge#platinum'
    end
  end
end