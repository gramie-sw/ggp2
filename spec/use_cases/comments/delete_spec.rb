describe Comments::Delete do

  let(:comment) { create(:comment) }

  describe '#run' do

    it 'deletes comment with given comment_id updates UserBadges and UsersMostValuableBadge' do

      expect(Comment).to receive(:destroy).with(comment.id).ordered
      expect(UpdateUserBadges).to receive(:run).with(group: :comment).ordered
      expect(Users::UpdateMostValuableBadge).to receive(:run).ordered

      Comments::Delete.run(id: comment.id)
    end
  end
end