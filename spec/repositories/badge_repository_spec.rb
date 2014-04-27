describe BadgeRepository do

  let(:load_badges) do
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
      ]
    }
  end

  describe '#badges_by_group' do

    it 'should return array of strategies by given group' do

      allow(BadgeRepository).to receive(:load_badges).and_return(load_badges)

      comment_badges = subject.badges_by_group(group: :comment)
      expect(comment_badges.size).to eq 2
      actual_comment_badge_1 = comment_badges[0]
      expect(actual_comment_badge_1).to be_an_instance_of(ConsecutiveCreatedCommentBadge)
      expect(actual_comment_badge_1.count).to eq 3

      actual_comment_badge_2 = comment_badges[1]
      expect(actual_comment_badge_2).to be_an_instance_of(CreatedCommentBadge)
      expect(actual_comment_badge_2.count).to eq 4
    end

    it 'should have symbolized keys' do
      expect(subject.badges_by_group(group: :comment)).to be_an_instance_of(Array)
    end
  end
end