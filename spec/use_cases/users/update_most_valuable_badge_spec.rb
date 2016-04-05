describe Users::UpdateMostValuableBadge do

  let(:players) { (1..3).map { create(:player) } }

  let!(:user_badges) {
    [
        create(:user_badge, user: players.first, badge_identifier: 'comment_created_badge#gold'),
        create(:user_badge, user: players.first, badge_identifier: 'tip_missed_badge#bronze'),
        create(:user_badge, user: players.third, badge_identifier: 'tip_missed_badge#bronze')
    ]
  }

  describe '::run' do

    it 'updates the most valuable badge for every player' do
      Users::UpdateMostValuableBadge.run
      players.each(&:reload)

      expect(players.first.most_valuable_badge.identifier).to eq 'comment_created_badge#gold'
      expect(players.second.most_valuable_badge).to eq nil
      expect(players.third.most_valuable_badge.identifier).to eq 'tip_missed_badge#bronze'
    end
  end
end