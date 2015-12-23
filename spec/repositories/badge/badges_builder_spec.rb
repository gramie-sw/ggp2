describe BadgesBuilder do

  let(:tip_badges_description) do
    grouped_badges_description = BadgeDescriptionFileReader.read
    grouped_badges_description[:tip]
  end

  let(:comment_badges_description) do
    grouped_badges_description = BadgeDescriptionFileReader.read
    grouped_badges_description[:comment]
  end

  describe '::build' do

    it 'returns badges build with given (tip) badges_descriptions' do

      actual_tip_badges = BadgesBuilder.build tip_badges_description

      expect(actual_tip_badges.size).to eq 17

      actual_badge = actual_tip_badges[0]
      expect(actual_badge.class).to eq TipMissedBadge
      expect(actual_badge.icon).to eq 'fa-globe'
      expect(actual_badge.achievement).to eq 1
      expect(actual_badge.color).to eq 'bronze'
      expect(actual_badge.score).to eq 100

      actual_badge = actual_tip_badges[1]
      expect(actual_badge.class).to eq TipMissedBadge
      expect(actual_badge.icon).to eq 'fa-globe'
      expect(actual_badge.achievement).to eq 5
      expect(actual_badge.color).to eq 'silver'
      expect(actual_badge.score).to eq 200

      actual_badge = actual_tip_badges[2]
      expect(actual_badge.class).to eq TipMissedBadge
      expect(actual_badge.icon).to eq 'fa-globe'
      expect(actual_badge.achievement).to eq 15
      expect(actual_badge.color).to eq 'platinum'
      expect(actual_badge.score).to eq 400

      actual_badge = actual_tip_badges[3]
      expect(actual_badge.class).to eq TipMissedBadge
      expect(actual_badge.icon).to eq 'fa-globe'
      expect(actual_badge.achievement).to eq 10
      expect(actual_badge.color).to eq 'gold'
      expect(actual_badge.score).to eq 300

      actual_badge = actual_tip_badges[4]
      expect(actual_badge.class).to eq TipBadge
      expect(actual_badge.result).to eq 'incorrect'
      expect(actual_badge.icon).to eq 'fa-bullseye'
      expect(actual_badge.achievement).to eq 2
      expect(actual_badge.color).to eq 'bronze'
      expect(actual_badge.score).to eq 110

      actual_badge = actual_tip_badges[5]
      expect(actual_badge.class).to eq TipBadge
      expect(actual_badge.result).to eq 'incorrect'
      expect(actual_badge.icon).to eq 'fa-bullseye'
      expect(actual_badge.achievement).to eq 3
      expect(actual_badge.color).to eq 'silver'
      expect(actual_badge.score).to eq 210

      actual_badge = actual_tip_badges[6]
      expect(actual_badge.class).to eq TipBadge
      expect(actual_badge.result).to eq 'incorrect'
      expect(actual_badge.icon).to eq 'fa-bullseye'
      expect(actual_badge.achievement).to eq 4
      expect(actual_badge.color).to eq 'gold'
      expect(actual_badge.score).to eq 310

      actual_badge = actual_tip_badges[7]
      expect(actual_badge.class).to eq TipBadge
      expect(actual_badge.result).to eq 'incorrect'
      expect(actual_badge.icon).to eq 'fa-bullseye'
      expect(actual_badge.achievement).to eq 5
      expect(actual_badge.color).to eq 'platinum'
      expect(actual_badge.score).to eq 410

      actual_badge = actual_tip_badges[8]
      expect(actual_badge.class).to eq TipConsecutiveBadge
      expect(actual_badge.result).to eq 'correct'
      expect(actual_badge.icon).to eq 'fa-rocket'
      expect(actual_badge.achievement).to eq 2
      expect(actual_badge.color).to eq 'bronze'
      expect(actual_badge.score).to eq 120

      actual_badge = actual_tip_badges[9]
      expect(actual_badge.class).to eq TipConsecutiveBadge
      expect(actual_badge.result).to eq 'correct'
      expect(actual_badge.icon).to eq 'fa-rocket'
      expect(actual_badge.achievement).to eq 3
      expect(actual_badge.color).to eq 'silver'
      expect(actual_badge.score).to eq 220

      actual_badge = actual_tip_badges[10]
      expect(actual_badge.class).to eq TipConsecutiveBadge
      expect(actual_badge.result).to eq 'correct'
      expect(actual_badge.icon).to eq 'fa-rocket'
      expect(actual_badge.achievement).to eq 4
      expect(actual_badge.color).to eq 'gold'
      expect(actual_badge.score).to eq 320

      actual_badge = actual_tip_badges[11]
      expect(actual_badge.class).to eq TipConsecutiveBadge
      expect(actual_badge.result).to eq 'correct'
      expect(actual_badge.icon).to eq 'fa-rocket'
      expect(actual_badge.achievement).to eq 5
      expect(actual_badge.color).to eq 'platinum'
      expect(actual_badge.score).to eq 420

      actual_badge = actual_tip_badges[12]
      expect(actual_badge.class).to eq TipConsecutiveMissedBadge
      expect(actual_badge.icon).to eq 'fa-ambulance'
      expect(actual_badge.achievement).to eq 2
      expect(actual_badge.color).to eq 'bronze'
      expect(actual_badge.score).to eq 130

      actual_badge = actual_tip_badges[13]
      expect(actual_badge.class).to eq TipConsecutiveMissedBadge
      expect(actual_badge.icon).to eq 'fa-ambulance'
      expect(actual_badge.achievement).to eq 3
      expect(actual_badge.color).to eq 'silver'
      expect(actual_badge.score).to eq 230

      actual_badge = actual_tip_badges[14]
      expect(actual_badge.class).to eq TipConsecutiveMissedBadge
      expect(actual_badge.icon).to eq 'fa-ambulance'
      expect(actual_badge.achievement).to eq 4
      expect(actual_badge.color).to eq 'gold'
      expect(actual_badge.score).to eq 330

      actual_badge = actual_tip_badges[15]
      expect(actual_badge.class).to eq TipConsecutiveMissedBadge
      expect(actual_badge.icon).to eq 'fa-ambulance'
      expect(actual_badge.achievement).to eq 5
      expect(actual_badge.color).to eq 'platinum'
      expect(actual_badge.score).to eq 430

      actual_badge = actual_tip_badges[16]
      expect(actual_badge.class).to eq TipChampionMissedBadge
      expect(actual_badge.icon).to eq 'fa-eye-slash'
      expect(actual_badge.achievement).to eq 0
      expect(actual_badge.color).to eq 'platinum'
      expect(actual_badge.score).to eq 0
    end

    it 'returns badges build with given (comment) badges_descriptions' do


      actual_comment_badges = BadgesBuilder.build comment_badges_description

      expect(actual_comment_badges.size).to eq 6

      actual_badge = actual_comment_badges[0]
      expect(actual_badge.class).to eq CommentCreatedBadge
      expect(actual_badge.icon).to eq 'fa-comments-o'
      expect(actual_badge.achievement).to eq 1
      expect(actual_badge.color).to eq 'bronze'
      expect(actual_badge.score).to eq 500

      actual_badge = actual_comment_badges[1]
      expect(actual_badge.class).to eq CommentCreatedBadge
      expect(actual_badge.icon).to eq 'fa-comments-o'
      expect(actual_badge.achievement).to eq 4
      expect(actual_badge.color).to eq 'silver'
      expect(actual_badge.score).to eq 600

      actual_badge = actual_comment_badges[2]
      expect(actual_badge.class).to eq CommentCreatedBadge
      expect(actual_badge.icon).to eq 'fa-comments-o'
      expect(actual_badge.achievement).to eq 8
      expect(actual_badge.color).to eq 'gold'
      expect(actual_badge.score).to eq 700

      actual_badge = actual_comment_badges[3]
      expect(actual_badge.class).to eq CommentConsecutiveCreatedBadge
      expect(actual_badge.icon).to eq 'fa-bullhorn'
      expect(actual_badge.achievement).to eq 3
      expect(actual_badge.color).to eq 'bronze'
      expect(actual_badge.score).to eq 510

      actual_badge = actual_comment_badges[4]
      expect(actual_badge.class).to eq CommentConsecutiveCreatedBadge
      expect(actual_badge.icon).to eq 'fa-bullhorn'
      expect(actual_badge.achievement).to eq 4
      expect(actual_badge.color).to eq 'silver'
      expect(actual_badge.score).to eq 610

      actual_badge = actual_comment_badges[5]
      expect(actual_badge.class).to eq CommentConsecutiveCreatedBadge
      expect(actual_badge.icon).to eq 'fa-bullhorn'
      expect(actual_badge.achievement).to eq 5
      expect(actual_badge.color).to eq 'gold'
      expect(actual_badge.score).to eq 710
    end

    it 'keeps given badges_description untouched' do
      cloned_badges_description = Marshal.load(Marshal.dump(tip_badges_description))
      BadgesBuilder.build tip_badges_description

      expect(tip_badges_description).to eq cloned_badges_description

    end
  end
end