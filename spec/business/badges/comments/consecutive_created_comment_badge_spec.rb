describe ConsecutiveCreatedCommentBadge do

  subject { ConsecutiveCreatedCommentBadge.new(count: 2) }

  it { should respond_to(:count=, :count) }

  describe '#initialize' do

    it 'should provide mass assignment' do
      expect(subject.count).to eq 2
    end
  end

  describe '#eligible_user_ids' do

    it 'should return user_ids having at least count consecutive comments' do

      expect(Comment).to receive(:user_ids_ordered_by_creation_desc).and_return([2,3,4,5,4,4,4,5,5,3,4,4,2])
      expect(Comment).to receive(:user_ids_grouped).and_return([2,3,4,5])

      actual_user_ids = subject.eligible_user_ids
      expect(actual_user_ids.size).to eq 2
      expect(actual_user_ids).to include(4,5)
    end
  end

  describe '#identifier' do
    it'should return symbolized underscored class name with count value' do
      expect(subject.identifier).to eq :consecutive_created_comment_badge_2
    end
  end
end