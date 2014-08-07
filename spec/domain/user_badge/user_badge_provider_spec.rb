describe UserBadgeProvider do

  let(:badges) do
    [
        CommentCreatedBadge.new(
            position: 1,
            icon: 'icon',
            icon_color: '#123456',
            count: 3,
            identifier: 'comment_created_badge_3'
        ),

        CommentCreatedBadge.new(
          position: 2,
          icon: 'icon',
          icon_color: '#123456',
          count: 2,
          identifier: 'comment_created_badge_2'
      ),

      CommentCreatedBadge.new(
          position: 3,
          icon: 'icon',
          icon_color: '#123456',
          count: 5,
          identifier: 'comment_created_badge_5'

      )
    ]
  end

  before :each do
    allow(badges[0]).to receive(:eligible_user_ids).and_return([1,3])
    allow(badges[1]).to receive(:eligible_user_ids).and_return([])
    allow(badges[2]).to receive(:eligible_user_ids).and_return([3])
  end

  describe '::provide' do

    it 'should return user_badges for given badges' do

      actual_user_badges = subject.provide badges
      expect(actual_user_badges.size).to eq 3

      actual_user_badge_1 = actual_user_badges[0]
      expect(actual_user_badge_1.user_id).to eq 1
      expect(actual_user_badge_1.badge_identifier).to eq 'comment_created_badge_3'

      actual_user_badge_1 = actual_user_badges[1]
      expect(actual_user_badge_1.user_id).to eq 3
      expect(actual_user_badge_1.badge_identifier).to eq 'comment_created_badge_3'

      actual_user_badge_1 = actual_user_badges[2]
      expect(actual_user_badge_1.user_id).to eq 3
      expect(actual_user_badge_1.badge_identifier).to eq 'comment_created_badge_5'
    end
  end
end