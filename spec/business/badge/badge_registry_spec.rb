describe BadgeRegistry do

  describe '::grouped_badges' do

    it 'should return hash with badges grouped' do

      grouped_badges = subject.grouped_badges
      expect(grouped_badges.keys.size).to eq 2
      expect(grouped_badges.keys).to include(:comment, :tip)
      actual_comment_badges = grouped_badges[:comment]

      expect(actual_comment_badges.size).to eq 2
      expect(actual_comment_badges[0]).to be_an_instance_of(CommentConsecutiveCreatedBadge)
      expect(actual_comment_badges[0].count).to eq 2
      expect(actual_comment_badges[0].position).to eq 1
      expect(actual_comment_badges[0].icon).to eq 'special_icon'
      expect(actual_comment_badges[0].icon_color).to eq '#123456'
      expect(actual_comment_badges[0].identifier).to eq 'comment_consecutive_created_badge_bronze'
      expect(actual_comment_badges[1]).to be_an_instance_of(CommentCreatedBadge)
      expect(actual_comment_badges[1].count).to eq 1
      expect(actual_comment_badges[1].position).to eq 2
      expect(actual_comment_badges[1].icon).to eq 'cool_icon'
      expect(actual_comment_badges[1].icon_color).to eq '#123456'
      expect(actual_comment_badges[1].identifier).to eq 'comment_created_badge_gold'

      actual_tip_badges = grouped_badges[:tip]

      expect(actual_tip_badges.size).to eq 5
      expect(actual_tip_badges[0]).to be_an_instance_of(TipConsecutiveBadge)
      expect(actual_tip_badges[0].count).to eq 3
      expect(actual_tip_badges[0].result).to eq 'correct'
      expect(actual_tip_badges[0].position).to eq 3
      expect(actual_tip_badges[0].icon).to eq 'icon'
      expect(actual_tip_badges[0].icon_color).to eq '#123456'
      expect(actual_tip_badges[0].identifier).to eq 'tip_consecutive_badge_correct_gold'
      expect(actual_tip_badges[1]).to be_an_instance_of(TipBadge)
      expect(actual_tip_badges[1].count).to eq 4
      expect(actual_tip_badges[1].result).to eq 'incorrect'
      expect(actual_tip_badges[1].position).to eq 4
      expect(actual_tip_badges[1].icon).to eq 'icon'
      expect(actual_tip_badges[1].icon_color).to eq '#123456'
      expect(actual_tip_badges[1].identifier).to eq 'tip_badge_incorrect_platinum'
      expect(actual_tip_badges[2]).to be_an_instance_of(TipMissedBadge)
      expect(actual_tip_badges[2].count).to eq 2
      expect(actual_tip_badges[2].position).to eq 5
      expect(actual_tip_badges[2].icon).to eq 'icon'
      expect(actual_tip_badges[2].icon_color).to eq '#123456'
      expect(actual_tip_badges[2].identifier).to eq 'tip_missed_badge_gold'
      expect(actual_tip_badges[3]).to be_an_instance_of(TipConsecutiveMissedBadge)
      expect(actual_tip_badges[3].position).to eq 6
      expect(actual_tip_badges[3].icon).to eq 'icon'
      expect(actual_tip_badges[3].icon_color).to eq '#123456'
      expect(actual_tip_badges[3].count).to eq 2
      expect(actual_tip_badges[3].identifier).to eq 'tip_consecutive_missed_badge_platinum'
      expect(actual_tip_badges[4]).to be_an_instance_of(TipChampionMissedBadge)
      expect(actual_tip_badges[4].position).to eq 7
      expect(actual_tip_badges[4].icon).to eq 'icon'
      expect(actual_tip_badges[4].icon_color).to eq '#123456'
      expect(actual_tip_badges[4].identifier).to eq 'tip_champion_missed_badge'
    end

    it 'should be cached' do
      expect(subject.grouped_badges).to be subject.grouped_badges
    end
  end
end