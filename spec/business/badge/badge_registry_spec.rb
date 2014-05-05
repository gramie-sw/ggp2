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
      expect(actual_comment_badges[1]).to be_an_instance_of(CommentCreatedBadge)
      expect(actual_comment_badges[1].count).to eq 1
      expect(actual_comment_badges[1].position).to eq 2
      expect(actual_comment_badges[1].icon).to eq 'cool_icon'
      expect(actual_comment_badges[1].icon_color).to eq '#123456'

      actual_tip_badges = grouped_badges[:tip]

      expect(actual_tip_badges.size).to eq 2
      expect(actual_tip_badges[0]).to be_an_instance_of(TipConsecutiveBadge)
      expect(actual_tip_badges[0].count).to eq 3
      expect(actual_tip_badges[0].result).to eq 'correct'
      expect(actual_tip_badges[0].position).to eq 3
      expect(actual_tip_badges[0].icon).to eq 'icon'
      expect(actual_tip_badges[0].icon_color).to eq '#123456'
      expect(actual_tip_badges[1]).to be_an_instance_of(TipBadge)
      expect(actual_tip_badges[1].count).to eq 4
      expect(actual_tip_badges[1].result).to eq 'incorrect'
      expect(actual_tip_badges[1].position).to eq 4
      expect(actual_tip_badges[1].icon).to eq 'icon'
      expect(actual_tip_badges[1].icon_color).to eq '#123456'
    end

    it 'should be cached' do
      expect(subject.grouped_badges).to eq subject.grouped_badges
    end
  end
end