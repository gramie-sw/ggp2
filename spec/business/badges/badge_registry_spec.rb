describe BadgeRegistry do

  let(:stubbed_load_grouped_badges) do
    {
        comment: [
            {
                class: 'ConsecutiveCreatedCommentBadge',
                attributes: {
                    count: 3
                }
            },
            {
                class: 'CreatedCommentBadge',
                attributes: {
                    count: 4
                }
            }
        ],
        tip: [
            {
                class: 'ConsecutiveTipResultBadge',
                attributes: {
                    result: 'correct',
                    count: 3
                }
            },
            {
                class: 'TipResultBadge',
                attributes: {
                    result: 'incorrect',
                    count: 4
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
      expect(actual_comment_badges[0]).to be_an_instance_of(ConsecutiveCreatedCommentBadge)
      expect(actual_comment_badges[0].count).to eq 3
      expect(actual_comment_badges[1]).to be_an_instance_of(CreatedCommentBadge)
      expect(actual_comment_badges[1].count).to eq 4

      actual_tip_badges = grouped_badges[:tip]

      expect(actual_tip_badges.size).to eq 2
      expect(actual_tip_badges[0]).to be_an_instance_of(ConsecutiveTipResultBadge)
      expect(actual_tip_badges[0].count).to eq 3
      expect(actual_tip_badges[0].result).to eq 'correct'
      expect(actual_tip_badges[1]).to be_an_instance_of(TipResultBadge)
      expect(actual_tip_badges[1].count).to eq 4
      expect(actual_tip_badges[1].result).to eq 'incorrect'
    end

    it 'should be cached' do
      expect(subject.grouped_badges).to eq subject.grouped_badges
    end
  end
end