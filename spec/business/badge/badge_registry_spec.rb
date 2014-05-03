describe BadgeRegistry do

  let(:stubbed_load_grouped_badges) do
    {
        comment: [
            {
                class: 'CommentConsecutiveCreatedBadge',
                attributes: {
                    count: 3,
                    position: 1,
                    icon: 'icon',
                    icon_color: '#123456'
                }
            },
            {
                class: 'CommentCreatedBadge',
                attributes: {
                    count: 4,
                    position: 2,
                    icon: 'icon',
                    icon_color: '#123456'
                }
            }
        ],
        tip: [
            {
                class: 'TipConsecutiveBadge',
                attributes: {
                    result: 'correct',
                    count: 3,
                    position: 3,
                    icon: 'icon',
                    icon_color: '#123456'
                }
            },
            {
                class: 'TipBadge',
                attributes: {
                    result: 'incorrect',
                    count: 4,
                    position: 4,
                    icon: 'icon',
                    icon_color: '#123456'
                }
            }
        ]
    }
  end

  describe '::grouped_badges' do

    before :each do
      BadgeRepository.stub(:load_grouped_badges).and_return(stubbed_load_grouped_badges)
    end

    it 'should return hash with badges grouped' do

      grouped_badges = subject.grouped_badges
      expect(grouped_badges.keys.size).to eq 2
      expect(grouped_badges.keys).to include(:comment, :tip)
      actual_comment_badges = grouped_badges[:comment]

      expect(actual_comment_badges.size).to eq 2
      expect(actual_comment_badges[0]).to be_an_instance_of(CommentConsecutiveCreatedBadge)
      expect(actual_comment_badges[0].count).to eq 3
      expect(actual_comment_badges[0].position).to eq 1
      expect(actual_comment_badges[0].icon).to eq 'icon'
      expect(actual_comment_badges[0].icon_color).to eq '#123456'
      expect(actual_comment_badges[1]).to be_an_instance_of(CommentCreatedBadge)
      expect(actual_comment_badges[1].count).to eq 4
      expect(actual_comment_badges[1].position).to eq 2
      expect(actual_comment_badges[1].icon).to eq 'icon'
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