describe ShowUserBadges do

  let(:users) do
    [
        create(:player),
        create(:player)
    ]
  end

  let(:user_badges) do
    [
        create(:user_badge, user_id: users.first.id, position: 2, group: :comment),
        create(:user_badge, user_id: users.first.id, position: 1, group: :comment),
        create(:user_badge, user_id: users.second.id, position: 5, group: :comment),
        create(:user_badge, user_id: users.first.id, position: 3, group: :tip)
    ]
  end

  let(:presenter) { double('presenter') }

  before :each do
    user_badges
  end

  describe '#run' do

    it 'should grouped_user_badges on presenter' do

      expect(presenter).to receive(:user).and_return(users.first)

      expect(presenter).to receive(:grouped_user_badges=) do |grouped_user_badges|
        expect(grouped_user_badges.keys).to include :comment, :tip
        actual_tip_user_badges = grouped_user_badges[:tip]
        expect(actual_tip_user_badges.size).to eq 1
        expect(actual_tip_user_badges.first).to eq user_badges.fourth

        actual_comment_user_badges = grouped_user_badges[:comment]
        expect(actual_comment_user_badges.size).to eq 2
        expect(actual_comment_user_badges.first).to eq user_badges.second
        expect(actual_comment_user_badges.second).to eq user_badges.first
      end

      subject.run presenter
    end
  end
end