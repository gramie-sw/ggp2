describe UpdateUserBadges do

  let(:load_grouped_badges) do
    {
        comment: [
            {
                class: 'CommentConsecutiveCreatedBadge',
                attributes: {
                    count: 2,
                    position: 1,
                    icon: 'my_consecutive_icon',
                    icon_color: '#123456'
                }
            },
            {
                class: 'CommentCreatedBadge',
                attributes: {
                    count: 1,
                    position: 2,
                    icon: 'my_icon',
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
            }
        ]
    }
  end

  before :each do
    BadgeRepository.stub(:load_grouped_badges).and_return(load_grouped_badges)
    badge_repository = BadgeRegistry.new.grouped_badges
    Ggp2.config.badges_registry_instance.stub(:grouped_badges).and_return badge_repository
  end

  describe'#run' do

    it 'should update user badges by given group' do

      user_1 = create(:user)
      user_2 = create(:user)
      user_3 = create(:user)

      create(:user_badge, user_id: user_1.id, group: :comment)
      expected_user_badge = create(:user_badge, user_id: user_1.id, group: :tip)

      create(:comment, user: user_2)
      create(:comment, user: user_2)
      create(:comment, user: user_3)
      create(:comment, user: user_2)
      create(:comment, user: user_3)

      subject.run(:comment)

      expect(UserBadge.all_by_group(:comment).all_by_user_id(user_1.id).size).to eq 0
      actual_tip_user_badges = UserBadge.all_by_group(:tip).all_by_user_id(user_1.id)
      expect(actual_tip_user_badges.size).to eq 1
      expect(actual_tip_user_badges[0]).to eq expected_user_badge

      expect(UserBadge.all_by_group(:comment).size).to eq 3

      actual_user_badges = UserBadge.all_by_group(:comment).all_by_user_id(user_2.id).order_by_position
      expect(actual_user_badges.size).to eq 2
      expect(actual_user_badges[0].user_id).to eq user_2.id
      expect(actual_user_badges[0].position).to eq 1
      expect(actual_user_badges[0].icon).to eq 'my_consecutive_icon'
      expect(actual_user_badges[1].user_id).to eq user_2.id
      expect(actual_user_badges[1].position).to eq 2
      expect(actual_user_badges[1].icon).to eq 'my_icon'

      actual_user_badges = UserBadge.all_by_group(:comment).all_by_user_id(user_3.id).order_by_position
      expect(actual_user_badges.size).to eq 1
      expect(actual_user_badges[0].user_id).to eq user_3.id
      expect(actual_user_badges[0].position).to eq 2
      expect(actual_user_badges[0].icon).to eq 'my_icon'
    end
  end
end