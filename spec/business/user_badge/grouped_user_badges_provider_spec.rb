describe GroupedUserBadgesProvider do

  describe '#provide' do

    let(:user_id) { 1 }
    let(:tip_badges) { ['tip_badges']}
    let(:comment_badges) { ['comment_badges']}
    let(:groups) { ['tip', 'comment']}

    it 'should return hash with badge groups as keys and as user earned badges as values' do

      expect(UserBadge).to receive(:groups_by_user_id).with(user_id: user_id).and_return(groups)
      expect(UserBadge).to receive(:all_ordered_by_group_and_user_id).with(group: :tip,
                                                                           user_id: user_id).and_return(tip_badges)
      expect(UserBadge).to receive(:all_ordered_by_group_and_user_id).with(group: :comment,
                                                                           user_id: user_id).and_return(comment_badges)

      actual_grouped_user_badges = subject.provide(user_id: user_id, user_badge_repo: UserBadge)

      expect(actual_grouped_user_badges.keys).to include(:tip, :comment)
      expect(actual_grouped_user_badges[:tip]).to eq tip_badges
      expect(actual_grouped_user_badges[:comment]).to eq comment_badges
    end
  end
end