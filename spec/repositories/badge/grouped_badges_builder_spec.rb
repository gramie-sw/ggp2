describe GroupedBadgesBuilder do

  let(:badges_description) { BadgeDescriptionFileReader.read }

  describe '::build' do

    it 'returns grouped badges hash badges sorted by score' do

      grouped_badges = GroupedBadgesBuilder.build(badges_description)

      expect(grouped_badges.keys.size).to eq 2

      tip_badges = grouped_badges[:tip]

      expect(tip_badges.keys.size).to eq 5

      actual_tip_missed_badges = tip_badges['tip_missed_badge']
      expect(actual_tip_missed_badges.size).to be 4
      expect(actual_tip_missed_badges.first.identifier).to eq 'tip_missed_badge#bronze'
      expect(actual_tip_missed_badges.first.score).to eq 100
      expect(actual_tip_missed_badges.second.identifier).to eq 'tip_missed_badge#silver'
      expect(actual_tip_missed_badges.second.score).to eq 200
      expect(actual_tip_missed_badges.third.identifier).to eq 'tip_missed_badge#gold'
      expect(actual_tip_missed_badges.third.score).to eq 300
      expect(actual_tip_missed_badges.fourth.identifier).to eq 'tip_missed_badge#platinum'
      expect(actual_tip_missed_badges.fourth.score).to eq 400

      actual_tip_incorrect_badges = tip_badges['tip_badge#incorrect']
      expect(actual_tip_incorrect_badges.size).to be 4
      expect(actual_tip_incorrect_badges.first.identifier).to eq 'tip_badge#incorrect#bronze'
      expect(actual_tip_incorrect_badges.first.score).to eq 110
      expect(actual_tip_incorrect_badges.second.identifier).to eq 'tip_badge#incorrect#silver'
      expect(actual_tip_incorrect_badges.second.score).to eq 210
      expect(actual_tip_incorrect_badges.third.identifier).to eq 'tip_badge#incorrect#gold'
      expect(actual_tip_incorrect_badges.third.score).to eq 310
      expect(actual_tip_incorrect_badges.fourth.identifier).to eq 'tip_badge#incorrect#platinum'
      expect(actual_tip_incorrect_badges.fourth.score).to eq 410

      actual_tip_consecutive_correct_badges = tip_badges['tip_consecutive_badge#correct']
      expect(actual_tip_consecutive_correct_badges.size).to be 4
      expect(actual_tip_consecutive_correct_badges.first.identifier).to eq 'tip_consecutive_badge#correct#bronze'
      expect(actual_tip_consecutive_correct_badges.first.score).to eq 120
      expect(actual_tip_consecutive_correct_badges.second.identifier).to eq 'tip_consecutive_badge#correct#silver'
      expect(actual_tip_consecutive_correct_badges.second.score).to eq 220
      expect(actual_tip_consecutive_correct_badges.third.identifier).to eq 'tip_consecutive_badge#correct#gold'
      expect(actual_tip_consecutive_correct_badges.third.score).to eq 320
      expect(actual_tip_consecutive_correct_badges.fourth.identifier).to eq 'tip_consecutive_badge#correct#platinum'
      expect(actual_tip_consecutive_correct_badges.fourth.score).to eq 420

      actual_tip_consecutive_missed_badges = tip_badges['tip_consecutive_missed_badge']
      expect(actual_tip_consecutive_missed_badges.size).to be 4
      expect(actual_tip_consecutive_missed_badges.first.identifier).to eq 'tip_consecutive_missed_badge#bronze'
      expect(actual_tip_consecutive_missed_badges.first.score).to eq 130
      expect(actual_tip_consecutive_missed_badges.second.identifier).to eq 'tip_consecutive_missed_badge#silver'
      expect(actual_tip_consecutive_missed_badges.second.score).to eq 230
      expect(actual_tip_consecutive_missed_badges.third.identifier).to eq 'tip_consecutive_missed_badge#gold'
      expect(actual_tip_consecutive_missed_badges.third.score).to eq 330
      expect(actual_tip_consecutive_missed_badges.fourth.identifier).to eq 'tip_consecutive_missed_badge#platinum'
      expect(actual_tip_consecutive_missed_badges.fourth.score).to eq 430

      actual_tip_champion_missed_badges = tip_badges['tip_champion_missed_badge']
      expect(actual_tip_champion_missed_badges.size).to be 1
      expect(actual_tip_champion_missed_badges.first.identifier).to eq 'tip_champion_missed_badge#platinum'
      expect(actual_tip_champion_missed_badges.first.score).to eq 0


      comment_badges = grouped_badges[:comment]
      expect(comment_badges.keys.size).to eq 2

      actual_comment_created_badges = comment_badges['comment_created_badge']
      expect(actual_comment_created_badges.size).to be 3
      expect(actual_comment_created_badges.first.identifier).to eq 'comment_created_badge#bronze'
      expect(actual_comment_created_badges.first.score).to eq 500
      expect(actual_comment_created_badges.second.identifier).to eq 'comment_created_badge#silver'
      expect(actual_comment_created_badges.second.score).to eq 600
      expect(actual_comment_created_badges.third.identifier).to eq 'comment_created_badge#gold'
      expect(actual_comment_created_badges.third.score).to eq 700

      actual_comment_consecutive_created_badges = comment_badges['comment_consecutive_created_badge']
      expect(actual_comment_consecutive_created_badges.size).to be 3
      expect(actual_comment_consecutive_created_badges.first.identifier).to eq 'comment_consecutive_created_badge#bronze'
      expect(actual_comment_consecutive_created_badges.first.score).to eq 510
      expect(actual_comment_consecutive_created_badges.second.identifier).to eq 'comment_consecutive_created_badge#silver'
      expect(actual_comment_consecutive_created_badges.second.score).to eq 610
      expect(actual_comment_consecutive_created_badges.third.identifier).to eq 'comment_consecutive_created_badge#gold'
      expect(actual_comment_consecutive_created_badges.third.score).to eq 710
    end
  end
end
