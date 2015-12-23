describe FindBadges do

  describe '#run' do

    it 'returns struct with groups and grouped_badges' do

      result = FindBadges.run

      actual_groups = result.groups
      expect(actual_groups.size).to eq 2
      expect(actual_groups.first).to eq :tip
      expect(actual_groups.second).to eq :comment

      actual_grouped_badges = result.grouped_badges

      expect(actual_grouped_badges.keys.size).to eq 2

      actual_tip_badges = actual_grouped_badges[:tip]
      expect(actual_tip_badges.size).to eq 17

      actual_tip_badges.each do |tip_badge|
        expect(tip_badge.identifier).to match('tip')
      end

      actual_commment_badges = actual_grouped_badges[:comment]
      expect(actual_commment_badges.size).to eq 6

      actual_commment_badges.each do |comment_badge|
        expect(comment_badge.identifier).to match('comment')
      end
    end
  end
end