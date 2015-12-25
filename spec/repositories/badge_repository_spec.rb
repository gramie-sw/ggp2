describe BadgeRepository do

  describe '::badges_hash' do

    it 'returns hash with badge_identifier as keys and badges as values' do

      badges_hash = BadgeRepository.badges_hash

      expect(badges_hash.keys.size).to be 23

      badges_hash.keys.each do |badge_identifier|
        expect(badges_hash[badge_identifier].identifier).to eq badge_identifier
      end
    end
  end

  describe '::badges' do

    it 'returns badges' do

      badges = BadgeRepository.badges

      expect(badges.size).to be 23

      badges.each do |badge|
        expect(badge).to be_a_kind_of Badge
      end
    end
  end

  describe '::badges_by_user_id' do

    let(:users) do
      [
          create(:player),
          create(:player)
      ]
    end

    let(:badges) { BadgeRepository.badges }

    let!(:user_badges) do
      [
          create(:user_badge,
                 user: users.first,
                 badge_group_identifier: badges.first.group_identifier,
                 badge_identifier: badges.first.identifier),

          create(:user_badge,
                 user: users.second,
                 badge_group_identifier: badges.second.group_identifier,
                 badge_identifier: badges.second.identifier
          ),

          create(:user_badge,
                 user: users.first,
                 badge_group_identifier: badges.last.group_identifier,
                 badge_identifier: badges.last.identifier)
      ]
    end


    it 'returns badges by given user_id desc sorted by badge score as default' do

      actual_badges = BadgeRepository.badges_by_user_id users.first

      expect(actual_badges.size).to be 2
      expect(actual_badges.first).to eq badges.first
      expect(actual_badges.second).to eq badges.last
    end

    it 'returns badges sorted by given sort direction and user_id' do

      actual_badges = BadgeRepository.badges_by_user_id users.first, :desc

      expect(actual_badges.size).to be 2
      expect(actual_badges.first).to eq badges.last
      expect(actual_badges.second).to eq badges.first
    end
  end

  describe '::groups' do

    it 'returns all groups' do

      actual_groups = BadgeRepository.groups
      expect(actual_groups.size).to eq 2
      expect(actual_groups).to include(:comment, :tip)
    end
  end

  describe '::grouped_badges' do

    it 'returns grouped badges' do

      actual_grouped_badges = BadgeRepository.grouped_badges
      expect(actual_grouped_badges.size).to be 2

      actual_tip_badges = actual_grouped_badges[:tip]
      expect(actual_tip_badges.size).to be 17

      actual_tip_badges.each do |tip_badge|
        expect(tip_badge.identifier).to match('tip')
      end

      actual_comment_badges = actual_grouped_badges[:comment]
      expect(actual_comment_badges.size).to be 6

      actual_comment_badges.each do |comment_badge|
        expect(comment_badge.identifier).to match('comment')
      end
    end
  end

  describe '::group_identifiers' do

    it 'returns group_identifiers by given group' do
      group_identifiers = BadgeRepository.group_identifiers :comment

      expect(group_identifiers.count).to be 2
      expect(group_identifiers).to include 'comment_created_badge', 'comment_consecutive_created_badge'
    end
  end

  describe '::group_identifiers_belong_to_group' do

    it 'returns group_identifiers which belong to given group and are included in given ' do
      group_identifiers = BadgeRepository.group_identifiers_belong_to_group(
          :comment, ['tip_badge#correct', 'comment_created_badge'])

      expect(group_identifiers.count).to be 1
      expect(group_identifiers.first).to eq 'comment_created_badge'
    end
  end

  describe '::grouped_group_identifiers_badges' do

    it 'returns grouped group_identifiers badges' do

      actual_grouped_group_identifiers_badges = BadgeRepository.grouped_group_identifiers_badges

      expect(actual_grouped_group_identifiers_badges.size).to eq 2

      actual_tip_group_identifiers_badges = actual_grouped_group_identifiers_badges[:tip]
      expect(actual_tip_group_identifiers_badges.size).to eq 5

      actual_tip_group_identifiers_badges.values.each do |identifier_grouped_badges|
        identifier_grouped_badges.each do |badge|
          expect(badge.identifier).to match('tip')
        end
      end

      actual_comment_group_identifiers_badges = actual_grouped_group_identifiers_badges[:comment]
      expect(actual_comment_group_identifiers_badges.size).to eq 2

      actual_comment_group_identifiers_badges.values.each do |identifier_grouped_badges|
        identifier_grouped_badges.each do |badge|
          expect(badge.identifier).to match('comment')
        end
      end
    end

    it 'grouped group_identifiers badges are cached' do
      expect(BadgeRepository.grouped_group_identifiers_badges).to eq BadgeRepository.grouped_group_identifiers_badges
    end
  end

  describe '::group_identifiers_grouped_badges' do

    it 'returns arrays of group_identifier grouped badges by given group' do

      grouped_badges = BadgeRepository.group_identifiers_grouped_badges :tip

      expect(grouped_badges.size).to eq 5

      tip_missed_badges = grouped_badges[0]

      expect(tip_missed_badges.size).to eq 4
      expect(tip_missed_badges.first.identifier).to eq 'tip_missed_badge#bronze'
      expect(tip_missed_badges.second.identifier).to eq 'tip_missed_badge#silver'
      expect(tip_missed_badges.third.identifier).to eq 'tip_missed_badge#gold'
      expect(tip_missed_badges.fourth.identifier).to eq 'tip_missed_badge#platinum'
    end
  end

  describe '::sum_badge_scores_by_user_id' do

    let(:users) do
      [
          create(:player),
          create(:player)
      ]
    end

    let(:badges) { BadgeRepository.badges }

    let!(:user_badges) do
      [
          create(:user_badge,
                 user: users.first,
                 badge_group_identifier: badges.first.group_identifier,
                 badge_identifier: badges.first.identifier),

          create(:user_badge,
                 user: users.second,
                 badge_group_identifier: badges.second.group_identifier,
                 badge_identifier: badges.second.identifier
          ),

          create(:user_badge,
                 user: users.first,
                 badge_group_identifier: badges.last.group_identifier,
                 badge_identifier: badges.last.identifier)
      ]
    end

    it 'returns sum of of badge scors by given user_id' do

      badge_score_sum = BadgeRepository.sum_badge_scores_by_user_id users.first.id
      expect(badge_score_sum).to eq 810
    end
  end
end