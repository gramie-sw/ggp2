describe FindBadges do

  describe '::run' do

    it 'should result with groups and grouped_badges set' do

      result = subject.run

      actual_groups = result.groups
      expect(actual_groups.size).to eq 2
      expect(actual_groups.first).to eq :comment
      expect(actual_groups.second).to eq :tip

      actual_grouped_badges = result.grouped_badges
      expect(actual_grouped_badges.keys.size).to eq 2
      expect(actual_grouped_badges.keys).to include(:comment, :tip)

      actual_comment_badges = actual_grouped_badges[:comment]
      expect(actual_comment_badges.size).to eq 2
      expect(actual_comment_badges.first.identifier).to eq 'comment_created_badge_gold'
      expect(actual_comment_badges.second.identifier).to eq 'comment_consecutive_created_badge_bronze'

      actual_tip_badges = actual_grouped_badges[:tip]
      expect(actual_tip_badges.size).to eq 5
      expect(actual_tip_badges.first.identifier).to eq 'tip_missed_badge_gold'
      expect(actual_tip_badges.second.identifier).to eq 'tip_badge_incorrect_platinum'
      expect(actual_tip_badges.third.identifier).to eq 'tip_consecutive_badge_correct_gold'
      expect(actual_tip_badges.fourth.identifier).to eq 'tip_consecutive_missed_badge_platinum'
      expect(actual_tip_badges[4].identifier).to eq 'tip_champion_missed_badge'
    end
  end
end